library ieee;
use ieee.std_logic_1164.all;
use IEEE.numeric_std.all;

entity seg7ctrl is
  port (
         mclk     : in std_logic;  -- 100 MHz, positive flank
         reset    : in std_logic;  -- Asynchronous reset, active high
         d0       : in std_logic_vector(4 downto 0);  -- digit 0 input
         d1       : in std_logic_vector(4 downto 0);  -- digit 1 input
         abcdefg  : out std_logic_vector(6 downto 0);  
         c        : out std_logic
         );
end entity seg7ctrl;

architecture mixed of seg7ctrl is

  component bin2ssd is
    port (
           d       : in std_logic_vector(4 downto 0);  -- Binary 5-bit input.
           abcdefg : out std_logic_vector(6 downto 0)  -- Seven segment output
           );
  end component bin2ssd;

  signal counter : unsigned(19 downto 0) := x"00000";  -- Singal able to count to 524 287.
  signal switch  : std_logic := '0';  -- Used to change between digits.
  signal output0 : std_logic_vector(6 downto 0);
  signal output1 : std_logic_vector(6 downto 0);

begin

  DECODER_0: bin2ssd
    port map (
               d => d0,
               abcdefg => output0
               );

  DECODER_1: bin2ssd
    port map (
               d => d1,
               abcdefg => output1
               );

  -- Switching the digit displayed by means of a counter.
  SWITCHING:
  process (mclk, reset)
    variable increment     : unsigned(19 downto 0);
    variable change_switch : std_logic;
  begin
    if (reset = '1') then
      counter <= x"00000";
      switch <= '0';
    elsif rising_edge(mclk) then
      -- Incrementing the counter, or resetting to 0 when it is 499 999.
      increment := x"00000" when (counter = x"7A11F") else counter + '1';
      counter <= increment;
      -- Switching the display the instant counter goes to 0.
      change_switch := switch;
      switch <= not(change_switch) when (increment = x"00000") else change_switch;
    end if;
  end process SWITCHING;

  -- Displaying the digit by means of the switch signal.
  DISPLAYING:
  process (mclk, reset)
  begin
    if (reset = '1') then
      abcdefg <= "0000000";  -- Reset default value
    elsif rising_edge(mclk) then
      abcdefg <= output0 when (switch = '0') else output1;
    end if;
  end process DISPLAYING;

  c <= switch;

end mixed;
