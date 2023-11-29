-- FILEPATH: /g:/Meu Drive/_Obsidian/Projetos/IC Listz/vhdl_personal_ip/pwm_generator.vhdl

-- This VHDL code defines a PWM generator module.
-- It generates a PWM signal based on the duty cycle input and a clock signal.
-- The duty cycle resolution is configurable and defaults to 8 bits.
-- The PWM output is controlled by an enable signal.
-- This entity represents a PWM generator module.
-- The pwm switching frequency is equal to the clock frequency divided by the resolution (in number of states) of the duty cycle.
-- For example, for 8 bits the swithing frequency will be equal to the clock frequency divided by 256.

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity pwm_generator is
    generic (
        duty_cycle_resolution : integer := 8  -- Resolution of the duty cycle (8 bits by default)
    );
    port (
        duty_cycle : in std_logic_vector(duty_cycle_resolution - 1 downto 0);  -- Duty cycle of the generated PWM (0-255 - where 255 is 100%)
        clk_in : in std_logic;      -- Input clock (Resolution of the duty cycle)
        enable : in std_logic;           -- Enable signal (active high)
        pwm_out : out std_logic := '0'  -- PWM output (initially low)
    );
end entity pwm_generator;

architecture rtl of pwm_generator is
    signal counter : unsigned(duty_cycle_resolution - 1 downto 0) := (others => '0');  -- Initializes the counter to 0
    constant zero_value : unsigned(duty_cycle_resolution - 1 downto 0) := (others => '0');  -- Constant value of 0
    constant max_value : unsigned(duty_cycle_resolution - 1 downto 0) := (others => '1');  -- Constant value of 1

begin
    process(clk_in)
    begin
        if rising_edge(clk_in) then
            if enable = '1' then
                if counter = zero_value then
                    pwm_out <= '1';
                elsif counter = unsigned(duty_cycle) then
                    pwm_out <= '0';
                end if;
                counter <= counter + 1;
            else
                pwm_out <= '0';
            end if;
        end if;
    end process;
end architecture rtl;
