library ieee;
use ieee.std_logic_1164.all;
use IEEE.numeric_std.all;

entity tb_seg7ctrl is
end tb_seg7ctrl;

architecture testbench of tb_seg7ctrl is

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

  signal tb_mclk    : std_logic;
  signal tb_reset   : std_logic;
  signal tb_d0      : std_logic_vector(4 downto 0);
  signal tb_d1      : std_logic_vector(4 downto 0);
  signal tb_abcdefg : std_logic_vector(6 downto 0);
  signal tb_c       : std_logic;

begin

  UUT: seg7ctrl
    port map (
               mclk    => tb_mclk,
               reset   => tb_reset,
               d0      => tb_d0,
               d1      => tb_d1,
               abcdefg => tb_abcdefg,
               c       => tb_c
               );


  CLOCK_stimuli:
  process
  begin
    tb_mclk <= '0';
    wait for 1 ps;
    tb_mclk <= '1';
    wait for 1 ps;
  end process CLOCK_stimuli;

  VECTOR0_stimuli:
  process
    variable test_vector0 : unsigned(4 downto 0);
  begin
    looping: for i in 0 to 31 loop
      test_vector0 := to_unsigned(i, test_vector0'length);
      tb_d0 <= std_logic_vector(test_vector0);
      wait for 2 us;
    end loop;
  end process VECTOR0_stimuli;

  VECTOR1_stimuli:
  process
    variable test_vector1 : unsigned(4 downto 0);
  begin
    looping: for i in 31 downto 0 loop
      test_vector1 := to_unsigned(i, test_vector1'length);
      tb_d1 <= std_logic_vector(test_vector1);
      wait for 2 us;
    end loop;
  end process VECTOR1_stimuli;

  tb_reset <= '1',
              '0' after 4 us,
              '1' after 8 us,
              '0' after 10 us;

end architecture testbench;


