library ieee;
use ieee.std_logic_1164.all;

entity tb_self_test_system is
end entity;

architecture self_testing_testbench of tb_self_test_system is
  
  component self_test_system is
    port(
        mclk    : in std_logic;
        reset   : in std_logic;
        abcdefg : out std_logic_vector(6 downto 0);
        c       : out std_logic
        );
  end component self_test_system;

  signal tb_mclk  : std_logic;
  signal tb_reset : std_logic;
  signal tb_abcdefg  : std_logic_vector(6 downto 0);
  signal tb_c     : std_logic;

begin

  UUT: self_test_system
    port map (
               mclk    => tb_mclk,
               reset   => tb_reset,
               abcdefg => tb_abcdefg,
               c       => tb_c
               );

  CLOCK_stimuli:
  process
  begin
    tb_mclk <= '0';
    wait for 5 ns;
    tb_mclk <= '1';
    wait for 5 ns;
  end process CLOCK_stimuli;

  tb_reset <= '1', '0' after 100 ns;

end;




