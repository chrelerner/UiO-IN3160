library ieee;
use ieee.std_logic_1164.all;

entity self_test_system is
  port(
        mclk    : in std_logic;
        reset   : in std_logic;
        abcdefg : out std_logic_vector(6 downto 0);
        c       : out std_logic
        );
end self_test_system;

architecture structural of self_test_system is

  component seg7ctrl is
    port (
         mclk     : in std_logic;  -- 100 MHz, positive flank
         reset    : in std_logic;  -- Asynchronous reset, active high
         d0       : in std_logic_vector(4 downto 0);  -- digit 0 input
         d1       : in std_logic_vector(4 downto 0);  -- digit 1 input
         abcdefg  : out std_logic_vector(6 downto 0);  
         c        : out std_logic
         );
  end component seg7ctrl;

  component self_test_unit is
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
  end component self_test_unit;

  signal d0    : std_logic_vector(4 downto 0);
  signal d1    : std_logic_vector(4 downto 0);
  signal abcdefg_out : std_logic_vector(6 downto 0);
  signal c_out : std_logic;

begin

  COMPONENT_1: seg7ctrl
    port map (
               mclk => mclk,
               reset => reset,
               d0 => d0,
               d1 => d1,
               abcdefg => abcdefg_out,
               c => c_out
               );

  COMPONENT_2: self_test_unit
    port map(
              mclk => mclk,
              reset => reset,
              d0 => d0,
              d1 => d1
              );
  
  abcdefg <= abcdefg_out;
  c <= c_out;

end architecture structural;


