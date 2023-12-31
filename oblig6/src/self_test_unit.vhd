library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity self_test_unit is
  generic (
              addr_width : natural := 4;   -- 16 rows of inputs.
              data_width : natural := 5    -- 5 bit input
              );
  port (
         mclk  : in std_logic;
         reset : in std_logic;
         d0    : out std_logic_vector(4 downto 0);
         d1    : out std_logic_vector(4 downto 0)
         );
end self_test_unit;

architecture rtl of self_test_unit is

  component rom is
    generic (
              addr_width : natural := 4;   -- 16 rows of inputs.
              data_width : natural := 5    -- 5 bit input
              );
    port (
           address : in std_logic_vector(addr_width-1 downto 0);
           data : out std_logic_vector((data_width*2)-1 downto 0)
           );
  end component rom;

  signal counter : unsigned(26 downto 0) := (others => '0');  -- Can count to 99 999 999.
  signal second_tick : std_logic;

  -- Signals to connect rom
  signal address : std_logic_vector(addr_width-1 downto 0) := (others => '0');
  signal data : std_logic_vector((data_width*2)-1 downto 0);  -- Two inputs per row

  -- Signal to connect to d0 and d1 outputs
  signal data_out : std_logic_vector((data_width*2)-1 downto 0);  -- Two inputs per row

begin

  TABLE: rom
    port map (
               address => address,
               data => data
               );

  -- second_tick will be active for 1 clock cycle every second.
  -- In this case, it will be 100 000 000 clock periods (100MHz) between each '1'.
  SECOND_TICK_GENERATOR:
  process (mclk, reset)
    variable increment : unsigned(26 downto 0);
  begin
    if (reset = '1') then
      counter <= (others => '0');
      second_tick <= '0';
    elsif rising_edge(mclk) then
      -- Incrementing the counter, or resetting to 0 when it is 99 999 999 (x5F5E0FF).
      increment := (others => '0') when (counter = "101111101011110000011111111") else counter + '1';
      counter <= increment;
      -- Setting second_tick to 1 for exactly one clock period.
      second_tick <= '1' when (increment = "101111101011110000011111111") else '0';
    end if;
  end process SECOND_TICK_GENERATOR;

  UPDATING_ADDRESS:
  process(mclk, reset)
    variable increment : unsigned(addr_width-1 downto 0);
  begin
    if (reset = '1') then
      address <= (others => '0');
    elsif rising_edge(mclk) then
      increment := unsigned(address);
      address <= (others => '0') when ((second_tick = '1') and (increment = "1111")) else
                 std_logic_vector(increment + '1') when (second_tick = '1') else
                 std_logic_vector(increment);
    end if;
  end process UPDATING_ADDRESS;

  UPDATING_DATA:
  process(mclk, reset)
  begin
    if (reset = '1') then
      data_out <= (others => '0');
    elsif rising_edge(mclk) then
      data_out <= data;
    end if;
  end process UPDATING_DATA;

  -- Sending data that is updated on the rising edge of the clock.
  d1 <= data_out((data_width*2)-1 downto data_width);
  d0 <= data_out(data_width-1 downto 0);

end architecture rtl;