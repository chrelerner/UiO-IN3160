library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity selftest_seg7ctrl is
  generic (
              data_width : natural := 5;  -- 5 bit input
              addr_width : natural := 4   -- 16 rows of inputs.
              );
  port (
         mclk  : in std_logic;
         reset : in std_logic;
         d0    : out std_logic_vector(4 downto 0);
         d1    : out std_logic_vector(4 downto 0)
         );
end selftest_seg7ctrl;

architecture rtl of selftest_seg7ctrl is

  component rom is
    generic (
              data_width : natural := 5;  -- 5 bit input
              addr_width : natural := 4   -- 16 rows of inputs.
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
      -- Setting second_tick to 1 for exactly one clock period. The first "second_tick" will appear on the one second mark.
      second_tick <= '1' when (increment = "101111101011110000011111111") else '0';
    end if;
  end process SECOND_TICK_GENERATOR;

  UPDATING_ADDRESS:
  process(all)
    variable increment : unsigned(addr_width-1 downto 0);
  begin
    increment := unsigned(address);
    if ((reset = '1') or ((second_tick = '1') and (increment = "1111"))) then
      address <= (others => '0');                   -- Message starts over.
    elsif (second_tick = '1') then
      address <= std_logic_vector(increment + '1');  -- Next address.
    else
      address <= std_logic_vector(increment);       -- Second tick is 0.
    end if;
  end process UPDATING_ADDRESS;

  -- Sending data on the rising edge of the clock.
  d0 <= data((data_width*2)-1 downto data_width) when rising_Edge(mclk);
  d1 <= data(data_width-1 downto data_width) when rising_Edge(mclk);

end architecture rtl;