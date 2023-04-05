library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity self_test_module is
  generic (
            addr_width : natural := 5; -- 32 data instances require 5 bit addresses,
            data_width : natural := 8; -- 8 bit data. 
            );
  port (
         mclk        : in std_logic;
         reset       : in std_logic;
	 duty_cycle : out std_logic_vector(7 downto 0);
         );
end self_test_module;

architecture rtl of self_test_module is

  type memory_array is array(0 to (2**addr_width)-1) of
    std_logic_vector(data_width-1 downto 0);

  constant ROM_DATA : memory array :=
  (

    -- Fill in the data with 31 entries, last slot has to be b"0".
    -- The values are meant to be changed, therefore use FILE IO.

  );

  signal second_tick : std_logic;
  signal counter     : unsigned (28 downto 0) := (others => '0');
  signal address     : std_logic_vector(addr_width-1 downto 0) := (others => '0');
  signal data        : std_logic_vector(data_width-1 downto 0);
  signal data_out    : std_logic_vector(data_width-1 downto 0);

begin

  SECOND_TICK_GENERATOR:
  process (mclk, reset) is
    variable increment : unsigned(28 downto 0);
  begin
    if (reset = '1') then
      counter <= (others => '0');
      second_tick <= '0';
    elsif rising_Edge(mclk) then
      increment := (others => '0') when (counter = b"299999999") else counter + '1';
      counter <= increment;
      second_tick <= '1' when (increment = b"299999999") else '0';
    end if;
  end process SECOND_TICK_GENERATOR;

  UPDATING_SIGNAL:
  process (all) is
    variable increment : unsigned(addr_width-1 downto 0);
  begin
    if (reset = '1') then
      address <= (others => '0');
      data_out <= (others => '0');
    elsif rising_Edge(mclk) then
      increment := unsigned(address);
      address <= std_logic(increment) when ((second_tick = '1') and (increment = b"31")) else
                 std_logic_vector(increment + '1') when (second_tick = '1') else
                 std_logic_Vector(increment);
    end if;
  end process UPDATING_SIGNAL;

  data <= ROM_DATA(to_integer(unsigned(address)));
  duty_cycle <= data_out;

end architecture rtl;

