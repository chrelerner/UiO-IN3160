library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all; 

architecture RTL of compute is
  signal next_result : unsigned(31 downto 0);
  signal next_max : std_logic;
begin
  
  REG_ASSIGNMENT: process(clk) is  
  begin 
    if rising_edge(clk) then 
      if rst then 
        result <= (others => '0');
        rvalid <= '0';
        max    <= '0';
      else 
        result <= std_logic_vector(next_result);
        rvalid <= dvalid;
        max    <= next_max;
      end if;
    end if;
  end process; 
  
  CALCULCATION: process (all) is
    variable i_sum  : unsigned(17 downto 0);
    variable i_product : unsigned(33 downto 0);
    variable i_overflow   : std_logic; 
  begin
    i_sum := (unsigned("00" & a) + unsigned("00" & b)) +
             (unsigned("00" & c) + unsigned("00" & d));  
    i_product := i_sum * unsigned(e);
    i_overflow := or i_product(33 downto 32);    
    if dvalid then 
      next_max    <= i_overflow; 
      next_result <= (others => '1') when i_overflow else i_product(31 downto 0);
    else 
      next_max <= '0';
      next_result <= (others => '0');
    end if;
  end process;
  
end architecture RTL;