library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity pwm_module is
  port (
         mclk       : in std_logic;
         reset      : in std_logic;
         duty_cycle : in std_logic_vector(7 downto 0);
         dir        : out std_logic;
         en         : out std_logic
         );
end pwm module;

architecture rtl of pwm_module is
  type state_type is (forward_idle, forward, reverse_idle, reverse);
  signal current_state, next_state : state_type;

  -- Signals used for pulse-width modulation.
  signal pwm : std_logic;
  signal counter : std_logic_vector(10 downto 0) := (others => '0');
  signal duty_cycle_signed : signed(7 downto 0) := signed(duty_cycle);

begin

  PULSE_WIDTH_MODULATION:
  process is
  begin
  end process PULSE_WIDTH_MODULATION;

  current_state <=
    reverse_idle when reset else
    next_state when riging_edge(mclk);

  NEXT_STATE:
  process is
  begin
  end process NEXT_STATE;

  STATE_OUTPUT:
  process is
  begin
  end process STATE_OUTPUT;

end architecture rtl;
