library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity pulse_width_modulator is
  port (
         mclk       : in std_logic;
         reset      : in std_logic;
         duty_cycle : in std_logic_vector(7 downto 0);
         dir        : out std_logic;
         en         : out std_logic
         );
end pulse_width_modulator;

architecture rtl of pulse_width_modulator is
  type state_type is (forward_idle, forward, reverse_idle, reverse);
  signal current_state, next_state : state_type;

  signal reset_handler : std_logic := '0';

  -- Signals used for pulse-width modulation.
  signal pwm : std_logic;
  signal counter : unsigned(15 downto 0) := (others => '0'); -- Counts to 49 999;

begin

  PULSE_WIDTH_MODULATION:
  process (mclk, reset) is
    variable increment : unsigned(15 downto 0);
    variable period_high_check : unsigned(16 downto 0);
  begin
    if (reset = '1') then
      counter <= (others => '0');
    elsif rising_edge(mclk) then
      increment := (others => '0') when (counter = d"49999") else counter + '1';
      counter <= increment;

      -- Has a max value of 49 999, min value of 480, and absolute min value of 0.
      period_high_check := (others => '0') when (duty_cycle = "00000000") else
                           to_unsigned(to_integer(abs(signed(duty_cycle))) * 390, period_high_check'length);
      pwm <= '1' when (to_integer(increment) < to_integer(period_high_check)) else '0';
    end if;
  end process PULSE_WIDTH_MODULATION;

  current_state <= next_state when rising_edge(mclk);

  UPDATE_STATE:
  process (all) is
  begin
    if (reset = '1' or reset_handler = '1') then
      reset_handler <= '1' when (current_state = forward) else '0';
      next_state <= forward_idle when (current_state = forward) else reverse_idle;
    else
      -- Default value
      next_state <= current_state;
      case current_state is
        when reverse_idle =>
          next_state <= reverse when (to_integer(signed(duty_cycle)) < 0) else forward_idle;
        when reverse =>
          next_state <= current_state when (to_integer(signed(duty_cycle)) < 0) else reverse_idle;
        when forward_idle =>
          next_state <= forward when (to_integer(signed(duty_cycle)) > 0) else reverse_idle;
        when forward =>
          next_state <= current_state when (to_integer(signed(duty_cycle)) > 0) else forward_idle;
      end case;
    end if;
  end process UPDATE_STATE;

  STATE_OUTPUT:
  process (all) is
    variable direction : std_logic;
  begin
    if (reset = '1' or reset_handler = '1') then
      en <= '0';
      direction := dir;
      dir <= direction when (current_state = forward) else '0';
    else
      -- Default values
      direction := dir;
      dir <= direction;  -- Hinders short
      en <= '0';
      case current_state is
        when reverse_idle =>
          en <= '0';
          dir <= '0';
        when reverse =>
          en <= pwm;
          dir <= '0';
        when forward_idle =>
          en <= '0';
          dir <= '1';
        when forward =>
          en <= pwm;
          dir <= '1';
      end case;
    end if;
  end process STATE_OUTPUT;

end architecture rtl;
