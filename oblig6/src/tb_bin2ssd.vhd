library ieee;
use ieee.std_logic_1164.all;
use IEEE.numeric_std.all;

entity tb_bin2ssd is
end tb_bin2ssd;

architecture testbench of tb_bin2ssd is

  component bin2ssd is
    port (
           d       : in std_logic_vector(4 downto 0);  -- Binary 5-bit input.
           abcdefg : out std_logic_vector(6 downto 0) -- Seven segment output
           );
  end component bin2ssd;

  component seg7model is
    port (
           c         : in  std_logic;
           abcdefg   : in  std_logic_vector(6 downto 0);
           disp1     : out std_logic_vector(4 downto 0);
           disp0     : out std_logic_vector(4 downto 0)
           );
  end component seg7model;

  -- Signal for bin2ssd
  signal tb_d       : std_logic_vector(4 downto 0);

  -- Signals for seg7model
  signal tb_c       : std_logic;
  signal tb_disp1   : std_logic_vector(4 downto 0);
  signal tb_disp0   : std_logic_vector(4 downto 0);

  -- Signal used to connect bin2ssd output to seg7model input
  signal tb_abcdefg : std_logic_vector(6 downto 0);

begin
  UUT_1: bin2ssd
    port map (
               d => tb_d,
               abcdefg => tb_abcdefg
               );

  UUT_2: seg7model
    port map (
               c => tb_c,
               abcdefg => tb_abcdefg,
               disp1 => tb_disp1,
               disp0 => tb_disp0
               );

  SWITCHING:
  process
  begin
    tb_c <= '0';
    wait for 100 ns;
    tb_c <= '1';
    wait for 100 ns;
  end process SWITCHING;

  STIMULI:
  process
    variable test_vector : unsigned(4 downto 0);
  begin
    increment_loop: for i in 0 to 31 loop
      test_vector := to_unsigned(i, test_vector'length);
      tb_d <= std_logic_vector(test_vector);
      wait for 10 ns;
    end loop;
  end process STIMULI;
  

end architecture testbench;



