library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity system is
  port (
         mclk      : in std_logic;
         reset     : in std_logic;
         SA        : in std_logic;  -- Input synchronizer
         SB        : in std_logic;  -- Input synchronizer
         DIR_synch : out std_logic;  -- Output synchronizer
         EN_synch  : out std_logic;  -- Output synchronizer
         abcdefg   : out std_logic_vector(6 downto 0);  -- seg7ctrl
         c         : out std_logic  -- seg7ctrl
         );
end system;

architecture structural of system is

  component self_test_module is
    generic (
              addr_width : natural := 5; -- 21 data instances require 5 bit addresses,
              data_width : natural := 8; -- 8 bit data.
              filename : string := "duty_cycles_file.txt"
              );
    port (
           mclk        : in std_logic;
           reset       : in std_logic;
	   duty_cycle  : out std_logic_vector(7 downto 0)
           );
  end component;

  component pulse_width_modulator is
    port (
           mclk       : in std_logic;
           reset      : in std_logic;
           duty_cycle : in std_logic_vector(7 downto 0);
           dir        : out std_logic;
           en         : out std_logic
           );
  end component;

  component output_synchronizer is
    port (
           mclk      : in std_logic;
           reset     : in std_logic;
           DIR       : in std_logic;
           EN        : in std_logic;
           DIR_synch : out std_logic;
           EN_synch  : out std_logic
           );
  end component;

  component input_synchronizer is
    port (
           mclk     : in std_logic;
           reset    : in std_logic;
           SA       : in std_logic;
           SB       : in std_logic;
           SA_synch : out std_logic;
           SB_synch : out std_logic
           );
  end component;

  component quadrature_decoder is
    port (
         mclk    : in std_logic;
         reset   : in std_logic;
         SA      : in std_logic;
         SB      : in std_logic;
         pos_inc : out std_logic;
         pos_dec : out std_logic;
         err     : out std_logic
         );
  end component;

  component velocity_reader is
    generic(
      -- these are made generics for the purpose of testing with a lower clock frequency:
      RCOUNT_WIDTH : natural := 20; -- width of clock dividing down to 100Hz; -- 20 bit should be enough for 100MHz / 10^6 = 100Hz
      TEN_MS_COUNT : natural := 1_000_000 -- number of cycles until 10 ms is reached at 100MHz
    );
    port(
      mclk      : in std_logic; 
      reset     : in std_logic; 
      pos_inc   : in std_logic;
      pos_dec   : in std_logic;
      velocity  : out signed(7 downto 0) -- rpm value updated every 1/100 s 
    );
  end component;

  component seg7ctrl is
    port (
           mclk     : in std_logic;  -- 100 MHz, positive flank
           reset    : in std_logic;  -- Asynchronous reset, active high
           d0       : in std_logic_vector(4 downto 0);  -- digit 0 input
           d1       : in std_logic_vector(4 downto 0);  -- digit 1 input
           abcdefg  : out std_logic_vector(6 downto 0);  
           c        : out std_logic
           );
  end component;

  -- Signals used by the upper half of system.
  signal duty_cycle : std_logic_vector(7 downto 0);
  signal dir : std_logic;
  signal en : std_logic;

  -- Signals used by the lower half of system.
  signal SA_synch, SB_synch : std_logic;
  signal pos_inc, pos_dec   : std_logic;
  signal err                : std_logic;  -- not used
  signal velocity           : signed(7 downto 0);
  signal d1, d0             : std_logic_vector(4 downto 0) := (others => '0');

begin

  COMPONENT_1 : self_test_module
    port map (
               mclk       => mclk,
               reset      => reset,
               duty_cycle => duty_cycle
               );

  COMPONENT_2 : pulse_width_modulator
    port map (
               mclk       => mclk,
               reset      => reset,
               duty_cycle => duty_cycle,
               dir        => dir,
               en         => en
               );

  COMPONENT_3 : output_synchronizer
    port map (
               mclk      => mclk,
               reset     => reset,
               DIR       => dir,
               EN        => en,
               DIR_synch => DIR_synch,
               EN_synch  => EN_synch
               );

  COMPONENT_4 : input_synchronizer
    port map (
               mclk     => mclk,
               reset    => reset,
               SA       => SA,
               SB       => SB,
               SA_synch => SA_synch,
               SB_synch => SB_synch
               );

  COMPONENT_5 : quadrature_decoder
    port map (
               mclk    => mclk,
               reset   => reset,
               SA      => SA_synch,
               SB      => SB_synch,
               pos_inc => pos_inc,
               pos_dec => pos_dec,
               err     => err  -- not used
               );

  COMPONENT_6 : velocity_reader
    port map (
               mclk     => mclk,
               reset    => reset,
               pos_inc  => pos_inc,
               pos_dec  => pos_dec,
               velocity => velocity
               );

  COMPONENT_7 : seg7ctrl
    port map (
               mclk    => mclk,
               reset   => reset,
               d0      => d0,
               d1      => d1,
               abcdefg => abcdefg,
               c       => c
               );

  d1(3 downto 0) <= std_logic_vector(velocity(7 downto 4));
  d0(3 downto 0) <= std_logic_vector(velocity(3 downto 0));

end architecture structural;

