library IEEE;
use IEEE.std_logic_1164.all;

entity shift8 is
  port (
         -- System clock and reset.
         rst_n     : in std_logic;   -- Reset
         mclk      : in std_logic;   -- Clock
         -- Shifted data in and out.
         din       : in std_logic;   -- Data in serial
         ser_dout  : out std_logic;  -- Data out serial
         par_dout  : out std_logic_vector(7 downto 0)    -- Data out parallell
         );
end shift8;

architecture structural of shift8 is

component dff is
  port (
         -- System Clock and Reset
         rst_n     : in  std_logic;   -- Reset
         mclk      : in  std_logic;   -- Clock
         -- Shifted data in and out
         din       : in  std_logic;   -- Data in
         dout      : out std_logic    -- Data out
         );
end component dff;

-- Signal used to connect all components. 
-- 9 bits because no output is associated to bit 0.
signal propagate     : std_logic_vector(8 downto 0);

begin

propagate(0) <= din;                -- Connects propagate to shift8 input.
ser_dout <= propagate(8);           -- Connects propagate to shift8 output
par_dout <= propagate(8 downto 1);  -- Connects propagate to shift8 parallell output.

shift8_inst: for i in 0 to 7 generate
  shift8: dff port map 
              (
                rst_n => rst_n,
                mclk  => mclk,
                din => propagate(i),
                dout => propagate(i+1)  -- Connects output to next input.
                );
end generate;

end architecture structural; 
