
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity tb_pargen is
  generic (
    TB_WIDTH : integer := 16
  );

end tb_pargen;

architecture beh1 of tb_pargen is

  component pargen is
    generic (
      WIDTH : integer := TB_WIDTH
    );
    port (
      rst_n   : in  std_logic;
      mclk    : in  std_logic;
      indata1 : in  std_logic_vector(WIDTH-1 downto 0);
      indata2 : in  unsigned(WIDTH-1 downto 0);
      par     : out std_logic
    );
  end component pargen;
    
  signal rst_n   : std_logic;
  signal mclk    : std_logic;
  signal indata1 : std_logic_vector(TB_WIDTH-1 downto 0);
  signal indata2 : unsigned(TB_WIDTH-1 downto 0) := x"0000";
  signal par     : std_logic  := '0';  -- Had to give default value for it to show in the waveform
  
begin

  UUT: entity work.pargen(rtl1)
    port map (
      rst_n   => rst_n,   
      mclk    => mclk,    
      indata1 => indata1, 
      indata2 => indata2, 
      par     => par
    );    
    
  P_CLK_0: process
    variable increment : unsigned(TB_WIDTH-1 downto 0);
  begin
    mclk <= '0';
    wait for 50 ns;
    mclk <= '1';
    wait for 50 ns;
    increment := indata2 + x"000D";  -- Incrementing with 13
    indata2 <= increment;
  end process P_CLK_0;

  TEST: process
    procedure test_values(signal par: in std_logic) is
    begin
      -- Testing with values of indata2 incrementing by 13 from x0000 and up.
      -- Make sense of comments: toggle_parity xor xor_parity with indata2 = XXXX

      -- Testing values indata1 = 0001
      wait for 60 ns;  -- We want to match the clock.
      assert (par = '0')  -- 1 xor 0 with indata2 = 0000, but rst_n is 0!
       report "Parity not correct at simulation start"
       severity warning;

      wait for 100 ns;
      assert (par = '0')  -- 1 xor 1 with indata2 = 000D
       report "Parity not correct after 100 ns"
       severity warning;

      wait for 100 ns;  -- 1 xor 1 with indata2 = 001A
      assert (par = '0')
       report "Parity not correct after 200 ns"
       severity warning;

      wait for 100 ns;
      assert (par = '1')  -- 1 xor 0 with indata2 = 0027
       report "Parity not correct after 300 ns"
       severity warning;

      wait for 100 ns;
      assert (par = '0')  -- 1 xor 1 with indata2 = 0034
       report "Parity not correct after 400 ns"
       severity warning;

      -- Testing values indata1 = 0003
      wait for 100 ns;  -- 0 xor 0 with indata2 = 0041
      assert (par = '0')
       report "Parity not correct after 500 ns"
       severity warning;

      wait for 100 ns;
      assert (par = '0')  -- 0 xor 0 with indata2 = 004E
       report "Parity not correct after 600 ns"
       severity warning;

      wait for 100 ns;  -- 0 xor 1 with indata2 = 005B
      assert (par = '1')
       report "Parity not correct after 700 ns"
       severity warning;

      wait for 100 ns;
      assert (par = '1')  -- 0 xor 1 with indata2 = 0068
       report "Parity not correct after 800 ns"
       severity warning;

      -- Testing values indata = 0004
      wait for 100 ns;
      assert (par = '0')  -- 1 xor 1 with indata2 = 0075
       report "Parity not correct after 900 ns"
       severity warning;

      wait for 100 ns;
      assert (par = '1')  -- 1 xor 0 with indata2 = 0082
       report "Parity not correct after 1000 ns"
       severity warning;

      wait for 100 ns;  -- 1 xor 1 with indata2 = 008F
      assert (par = '0')
       report "Parity not correct after 1100 ns"
       severity warning;

      wait for 100 ns;
      assert (par = '1')  -- 1 xor 0 with indata2 = 009C
       report "Parity not correct after 1200 ns"
       severity warning;

      -- Testing values indata = 0005
      wait for 100 ns;
      assert (par = '0')  -- 0 xor 0 with indata2 = 00A9
       report "Parity not correct after 1300 ns"
       severity warning;

      wait for 100 ns;
      assert (par = '1')  -- 0 xor 1 with indata2 = 00B6
       report "Parity not correct after 1400 ns"
       severity warning;

      wait for 100 ns;  -- 0 xor 0 with indata2 = 00C3
      assert (par = '0')
       report "Parity not correct after 1500 ns"
       severity warning;

      wait for 100 ns;
      assert (par = '1')  -- 0 xor 1 with indata2 = 00D0
       report "Parity not correct after 1600 ns"
       severity warning;

      -- Testing values indata = 0007
      wait for 100 ns;
      assert (par = '1')  -- 1 xor 0 with indata2 = 00DD
       report "Parity not correct after 1700 ns"
       severity warning;

      wait for 100 ns;
      assert (par = '0')  -- 1 xor 1 with indata2 = 00EA
       report "Parity not correct after 1800 ns"
       severity warning;

      wait for 100 ns;  -- 1 xor 1 with indata2 = 00F7
      assert (par = '0')
       report "Parity not correct after 1900 ns"
       severity warning;
      
    end procedure;
  begin
    test_values(par);
  end process TEST;


  rst_n  <= '0', '1' after 100 ns;
  indata1 <= x"0001",
             x"0003" after 500 ns,
             x"0004" after 900 ns,
             x"0005" after 1300 ns,
             x"0007" after 1700 ns;

end beh1;
