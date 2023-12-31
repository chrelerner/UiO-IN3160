library IEEE;
use IEEE.std_logic_1164.all;

entity TEST_FIRST is
-- Empty entity of the testbench
end TEST_FIRST;

architecture TESTBENCH of TEST_FIRST is
  -- Area for declarations

  -- Component declaration
  component FIRST
    port
      (
        clk       : in  std_logic;      -- Clock signal from push button
        reset     : in  std_logic;      -- Global asynchronous reset
        load      : in  std_logic;      -- Synchronous reset
        up        : in  std_logic;      -- Up/down signal
        inp       : in  std_logic_vector(3 downto 0);  -- Start value
        count     : out std_logic_vector(3 downto 0);  -- Count value
        max_count : out std_logic;      -- Indicates maximum count value
        min_count : out std_logic       -- Indicates minimum count value
        );
  end component;

  signal tb_clk       : std_logic := '0';
  signal tb_reset     : std_logic := '0';
  signal tb_load      : std_logic := '0';
  signal tb_up        : std_logic := '1';
  signal tb_inp       : std_logic_vector(3 downto 0) := "0000";
  signal tb_count     : std_logic_vector(3 downto 0);
  signal tb_max_count : std_logic := '0';
  signal tb_min_count : std_logic := '0';

  -- 50 Mhz clock frequency
  constant HALF_PERIOD : time := 10 ns;
  
begin
  -- Concurrent statements

  -- Instantiating the unit under test
  UUT : FIRST
    port map
    (
      clk       => tb_clk,
      reset     => tb_reset,
      load      => tb_load,
      up        => tb_up,
      inp       => tb_inp,
      count     => tb_count,
      max_count => tb_max_count,
      min_count => tb_min_count
      );

  -- Generating the clock signal
  tb_clk <= not tb_clk after HALF_PERIOD;

  STIMULI :
  process
  begin
    -- Counting up
    tb_reset <= '1', '0' after 100 ns;
    wait for 2*HALF_PERIOD*18;

    -- Counting down
    tb_inp <= "1111";
    wait for 100 ns; -- Allows max signal to show
    tb_up <= '0';
    tb_load <= '1', '0' after 100 ns;
    wait for 2*HALF_PERIOD*18;

    -- Counting up
    tb_inp <= "0000";
    wait for 100 ns; -- Allows min signal to show 
    tb_up <= '1';
    tb_load <= '1', '0' after 100 ns;
    wait for 2*HALF_PERIOD*18;

  end process;
  
end TESTBENCH;
