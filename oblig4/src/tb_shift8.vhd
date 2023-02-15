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

signal tb_rst_n : std_logic = '0';
signal tb_mclk  : std_logic = '0';
signal tb_din      : std_logic = '0';
signal tb_ser_dout : std_logic = '0';
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

  STIMULI:
  process
  begin
    -- Start writing simulation code.


  end process
end architecture testbench;