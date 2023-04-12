library ieee;
use ieee.std_logic_1164.all;

entity quadrature_decoder is
  port (
         mclk    : in std_logic;
         reset   : in std_logic;
         SA      : in std_logic;
         SB      : in std_logic;
         pos_inc : out std_logic;
         pos_dec : out std_logic;
         err     : out std_logic
         );
end quadrature_decoder;

architecture rtl of quadrature_decoder is
  type state_type is (S_reset, S_init, S_0, S_1, S_2, S_3);
  signal current_state, next_state : state_type;
  signal AB : std_logic_vector(1 downto 0);

begin

  AB(1) <= SA;
  AB(0) <= SB;
  
  current_state <= 
    S_reset when (reset = '1') else
    next_state when rising_edge(mclk);

  UPDATE_STATE:
  process (all) is
  begin
    -- Default value
    next_state <= current_state;

    case current_state is
      when S_reset =>
        next_state <= S_init;
      when S_init =>
        next_state <= 
          S_0 when (AB = "00") else
          S_1 when (AB = "01") else
          S_2 when (AB = "11") else
          S_3 when (AB = "10");
      when S_0 =>
        next_state <= 
          S_0     when (AB = "00") else
          S_1     when (AB = "01") else
          S_reset when (AB = "11") else
          S_3     when (AB = "10");
      when S_1 =>
        next_state <=
          S_0     when (AB = "00") else
          S_1     when (AB = "01") else
          S_2     when (AB = "11") else
          S_reset when (AB = "10");
      when S_2 =>
        next_state <=
          S_reset when (AB = "00") else
          S_1     when (AB = "01") else
          S_2     when (AB = "11") else
          S_3     when (AB = "10");
      when S_3 =>
        next_state <=
          S_0     when (AB = "00") else
          S_reset when (AB = "01") else
          S_2     when (AB = "11") else
          S_3     when (AB = "10");
    end case;
  end process UPDATE_STATE;

  STATE_OUTPUT:
  process (all) is
  begin
    -- Default values
    pos_inc <= '0';
    pos_dec <= '0';
    err <= '0';

    case current_state is
      when S_reset =>
        pos_inc <= '0';
        pos_dec <= '0';
        err <= '0';
      when S_init =>
        pos_inc <= '0';
        pos_dec <= '0';
        err <= '0';
      when S_0 =>
        pos_inc <= '1' when (AB = "01") else '0';
        pos_dec <= '1' when (AB = "10") else '0';
        err <= '1'     when (AB = "11") else '0';
      when S_1 =>
        pos_inc <= '1' when (AB = "11") else '0';
        pos_dec <= '1' when (AB = "00") else '0';
        err <= '1'     when (AB = "10") else '0';
      when S_2 =>
        pos_inc <= '1' when (AB = "10") else '0';
        pos_dec <= '1' when (AB = "01") else '0';
        err <= '1'     when (AB = "00") else '0';
      when S_3 =>
        pos_inc <= '1' when (AB = "00") else '0';
        pos_dec <= '1' when (AB = "11") else '0';
        err <= '1'     when (AB = "01") else '0';
    end case;
  end process STATE_OUTPUT;

end architecture rtl;


