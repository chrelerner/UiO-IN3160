-- This file uses code taken from lecture slides on File IO.

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use STD.textio.all;

entity self_test_module is
  generic (
            addr_width : natural := 5; -- 32 data instances require 5 bit addresses,
            data_width : natural := 8; -- 8 bit data.
            filename : string := "duty_cycles_file.txt"
            );
  port (
         mclk        : in std_logic;
         reset       : in std_logic;
	 duty_cycle  : out std_logic_vector(7 downto 0);
         );
end self_test_module;

architecture rtl of self_test_module is

  type memory_array is array(0 to (2**addr_width)-1) of
    std_logic_vector(data_width-1 downto 0);

  impure function intitialize_ROM(file_name: string);
    return memory_array is
    file init_file        : text open read mode is filename;
    variable current_line : line;
    variable result       : memory_array;
  begin
    for i in result'range loop
      readline(init_file, current_line)
      read(current_line, result(i));
    end loop;
    return result:

  constant ROM_DATA : memory array := initialize_ROM(filename);

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
      increment := (others => '0') when (counter = d"299999999") else counter + '1';
      counter <= increment;
      second_tick <= '1' when (increment = d"299999999") else '0';
    end if;
  end process SECOND_TICK_GENERATOR;

  UPDATING_SIGNAL:
  process (all) is
    variable increment : unsigned(addr_width-1 downto 0);
  begin
    if (reset = '1') then
      address <= (others => '0');
      data <= (others => '0');
    elsif rising_Edge(mclk) then
      increment := unsigned(address);
      address <= std_logic(increment) when ((second_tick = '1') and (increment = b"31")) else
                 std_logic_vector(increment + '1') when (second_tick = '1') else
                 std_logic_Vector(increment);
      data <= ROM_DATA(to_integer(unsigned(address)));
    end if;
  end process UPDATING_SIGNAL;

  duty_cycle <= data;

end architecture rtl;

