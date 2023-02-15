library IEEE;
use IEEE.std_logic_1164.all;

entity shiftn is
  generic (
            n : positive := 64
);
  port (
         -- System clock and reset.
         rst_n     : in std_logic;   -- Reset
         mclk      : in std_logic;   -- Clock
         -- Shifted data in and out.
         din       : in std_logic;   -- Data in serial
         ser_dout  : out std_logic;  -- Data out serial
         par_dout  : out std_logic_vector(n-1 downto 0)    -- Data out parallell
         );
end shiftn;

architecture structural of shiftn is

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
-- n+1 bits because no output is associated to bit 0.
signal propagate     : std_logic_vector(n downto 0);

begin

propagate(0) <= din;                -- Connects propagate to shiftn input.
ser_dout <= propagate(n);           -- Connects propagate to shiftn output
par_dout <= propagate(n downto 1);  -- Connects propagate to shiftn parallell output.

shiftn_inst: for i in 0 to n-1 generate
  shiftn: dff port map 
              (
                rst_n => rst_n,
                mclk  => mclk,
                din => propagate(i),
                dout => propagate(i+1) -- Connects output to next input.
                );
end generate;

end architecture structural; 