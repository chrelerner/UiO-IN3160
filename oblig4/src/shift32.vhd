library IEEE;
use IEEE.std_logic_1164.all;

entity shift32 is
  port (
         -- System clock and reset.
         rst_n     : in std_logic;   -- Reset
         mclk      : in std_logic;   -- Clock
         -- Shifted data in and out.
         din       : in std_logic;   -- Data in serial
         ser_dout  : out std_logic;  -- Data out serial
         par_dout  : out std_logic_vector(31 downto 0)    -- Data out parallell
         );
end shift32;

architecture structural of shift32 is

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
-- 33 bits because no output is associated to bit 0.
signal propagate     : std_logic_vector(32 downto 0);

begin

propagate(0) <= din;                 -- Connects propagate to shift32 input.
ser_dout <= propagate(32);           -- Connects propagate to shift32 output
par_dout <= propagate(32 downto 1);  -- Connects propagate to shift32 parallell output.

shift32_inst: for i in 0 to 31 generate
  shift32: dff port map 
              (
                rst_n => rst_n,
                mclk  => mclk,
                din => propagate(i),
                dout => propagate(i+1) -- Connects output to next input.
                );
end generate;

end architecture structural; 