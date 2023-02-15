library IEEE;
use IEEE.std_logic_1164.all;

entity tb_shift8 is
end tb_shift8;

architecture testbench of tb_shift8 is

component shift8 is
  port (
         -- System clock and reset.
         rst_n     : in std_logic;   -- Reset
         mclk      : in std_logic;   -- Clock
         -- Shifted data in and out.
         din       : in std_logic;   -- Data in serial
         ser_dout  : out std_logic;  -- Data out serial
         par_dout  : out std_logic_vector(7 downto 0)    -- Data out parallell
         );
end component shift8;

signal tb_rst_n : std_logic;
signal tb_mclk  : std_logic;
signal tb_din      : std_logic;
signal tb_ser_dout : std_logic := '0';
signal tb_par_dout : std_logic_vector(7 downto 0);

begin

  UUT : shift8
    port map
    (
      rst_n => tb_rst_n,
      mclk => tb_mclk,
      din => tb_din,
      ser_dout => tb_ser_dout,
      par_dout => tb_par_dout  
      );

  CLOCK_stimuli:
  process
  begin
    tb_mclk <= '0';
    wait for 50 ns;
    tb_mclk <= '1';
    wait for 50 ns;
  end process;

  INPUT_stimuli:
  process
  begin
    tb_din <= '0';
    wait for 100 ns;
    tb_din <= '1';
    wait for 100 ns;
    tb_din <= '0';
    wait for 200 ns;
    tb_din <= '1';
    wait for 100 ns;
  end process;
  
  tb_rst_n <= '0', '1' after 100 ns,'0' after 800 ns, '1' after 1100 ns;
  

end architecture testbench;