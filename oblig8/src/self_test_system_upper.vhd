-- Self test system for oblig 8 task c.
library ieee;
use ieee.std_logic_1164.all;

entity self_test_system_upper is
  port(
        mclk      : in std_logic;
        reset     : in std_logic;
        DIR_synch : out std_logic;
        EN_synch  : out std_logic
        );
end self_test_system_upper;

architecture structural of self_test_system_upper is

  component self_test_module is
    generic (
              addr_width : natural := 5; -- 21 data instances require 5 bit addresses,
              data_width : natural := 8 -- 8 bit data. 
              );
    port (
           mclk        : in std_logic;
           reset       : in std_logic;
	   duty_cycle : out std_logic_vector(7 downto 0)
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

  signal duty_cycle : std_logic_vector(7 downto 0);
  signal dir : std_logic;
  signal en : std_logic;

begin

  COMPONENT_1 : self_test_module
    port map (
               mclk => mclk,
               reset => reset,
               duty_cycle => duty_cycle
               );

  COMPONENT_2 : pulse_width_modulator
    port map (
               mclk => mclk,
               reset => reset,
               duty_cycle => duty_cycle,
               dir => dir,
               en => en
               );

  COMPONENT_3 : output_synchronizer
    port map (
               mclk => mclk,
               reset => reset,
               DIR => dir,
               EN => en,
               DIR_synch => DIR_synch,
               EN_synch => EN_synch
               );

end architecture structural;
