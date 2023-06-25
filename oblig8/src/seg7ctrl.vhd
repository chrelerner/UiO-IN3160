library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity seg7ctrl is
  port (
         mclk     : in std_logic;  -- 100 MHz, positive flank
         reset    : in std_logic;  -- Asynchronous reset, active high
         d0       : in std_logic_vector(4 downto 0);  -- digit 0 input
         d1       : in std_logic_vector(4 downto 0);  -- digit 1 input
         abcdefg  : out std_logic_vector(6 downto 0);  
         c        : out std_logic
         );
end seg7ctrl;

architecture mixed of seg7ctrl is

  component bin2ssd is
    port (
           d       : in std_logic_vector(4 downto 0);  -- Binary 5-bit input.
           abcdefg : out std_logic_vector(6 downto 0)  -- Seven segment output
           );
  end component bin2ssd;

  -- Signals used to switch digits.
  signal counter : unsigned(18 downto 0) := (others => '0');  -- Can count to 524 287.
  signal switch  : std_logic := '0';

  -- Signals used by the decoder.
  signal output : std_logic_vector(6 downto 0);
  signal d : std_logic_vector(4 downto 0);

begin

  DECODER: bin2ssd
    port map (
               d => d,
               abcdefg => output
               );

  -- Switching the digit displayed by using a counter.
  -- Digits will switch with a period that lasts 1 000 000 clock periods.
  -- That is 500 000 rising edges between off/on for one digit.
  -- Produces digit-flicker of 100Hz.
  SWITCHING:
  process (mclk, reset)
    variable increment     : unsigned(18 downto 0);
    variable change_switch : std_logic;
  begin
    if (reset = '1') then
      counter <= (others => '0');
      switch <= '0';
    elsif rising_edge(mclk) then
      -- Incrementing the counter, or resetting to 0 when it is 499 999 (x7A11F).
      increment := (others => '0') when (counter = "1111010000100011111") else counter + '1';
      counter <= increment;
      -- Switching the display the instant counter goes to 0.
      change_switch := switch;
      switch <= not(change_switch) when (increment = "0000000000000000000") else change_switch;
    end if;
  end process SWITCHING;

  -- Displaying the digit.
  DISPLAYING:
  process (mclk, reset)
  begin
    if (reset = '1') then
      -- We do not wait for "switch"-signal to update here.
      abcdefg <= (others => '0');  -- Reset default value
      c <= '0';
    elsif rising_edge(mclk) then
      abcdefg <= output;
      c <= switch;
    end if;
  end process DISPLAYING;

  -- Changing output.
  d <= d1 when (switch = '1') else d0;

end mixed;