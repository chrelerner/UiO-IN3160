library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

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

  component seg7model is
    port (
           c         : in  std_logic;
           abcdefg   : in  std_logic_vector(6 downto 0);
           disp1     : out std_logic_vector(4 downto 0);
           disp0     : out std_logic_vector(4 downto 0)
           );
  end component seg7model;

  -- Signals for seg7ctrl
  signal tb_mclk    : std_logic;
  signal tb_reset   : std_logic;
  signal tb_d0      : std_logic_vector(4 downto 0);
  signal tb_d1      : std_logic_vector(4 downto 0);

  -- Signals for seg7model
  signal tb_disp1   : std_logic_vector(4 downto 0);
  signal tb_disp0   : std_logic_vector(4 downto 0);

  -- Signals used to connect the two
  signal tb_abcdefg : std_logic_vector(6 downto 0);
  signal tb_c       : std_logic;

begin

  UUT_1: seg7ctrl
    port map (
               mclk    => tb_mclk,
               reset   => tb_reset,
               d0      => tb_d0,
               d1      => tb_d1,
               abcdefg => tb_abcdefg,
               c       => tb_c
               );

  UUT_2: seg7model
    port map (
               c => tb_c,
               abcdefg => tb_abcdefg,
               disp1 => tb_disp1,
               disp0 => tb_disp0
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
      wait for 4 us;
    end loop;
  end process VECTOR0_stimuli;

  VECTOR1_stimuli:
  process
    variable test_vector1 : unsigned(4 downto 0);
  begin
    looping: for i in 31 downto 0 loop
      test_vector1 := to_unsigned(i, test_vector1'length);
      tb_d1 <= std_logic_vector(test_vector1);
      wait for 4 us;
    end loop;
  end process VECTOR1_stimuli;

  tb_reset <= '0',
              '1' after 4 us,
              '0' after 8 us;

end architecture testbench;


