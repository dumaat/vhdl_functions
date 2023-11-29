-- FILEPATH: /g:/Meu Drive/_Obsidian/Projetos/IC Listz/vhdl_personal_ip/pwm_generator_tb.vhdl

-- Testbench for the PWM Generator module
-- This testbench is used to verify the functionality of the PWM Generator module by providing different duty cycle values and observing the corresponding PWM output.

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity pwm_generator_tb is
end entity pwm_generator_tb;

architecture tb_arch of pwm_generator_tb is
    -- Component declaration for the unit under test (UUT)
    component pwm_generator is
        port (
            duty_cycle : in std_logic_vector(7 downto 0);  -- Input duty cycle value
            clk_in : in std_logic;  -- Input clock signal
            pwm_out : out std_logic  -- Output PWM signal
        );
    end component;

    -- Signal declarations
    signal clk : std_logic := '0';  -- Clock signal
    signal duty_cycle_in : std_logic_vector(7 downto 0) := "00000000";  -- Input duty cycle value
    signal pwm_out : std_logic;  -- Output PWM signal

begin
    -- Instantiate the unit under test (UUT)
    uut: pwm_generator
        port map (
            duty_cycle => duty_cycle_in,
            clk_in => clk,
            pwm_out => pwm_out
        );

    -- Clock process
    clk_process: process
    begin
        while now < 1000 ns loop  -- Change the simulation time as needed
            clk <= '0';
            wait for 5 ns;
            clk <= '1';
            wait for 5 ns;
        end loop;
        wait;
    end process;

    -- Stimulus process
    stim_process: process
    begin
        -- Test case 1: Duty cycle = 50%
        duty_cycle_in <= "10000000";
        wait for 500 ns;

        -- Test case 2: Duty cycle = 25%
        duty_cycle_in <= "01000000";
        wait for 500 ns;

        -- Test case 3: Duty cycle = 75%
        duty_cycle_in <= "11000000";
        wait for 500 ns;

        -- Add more test cases as needed

        wait;
    end process;

end architecture tb_arch;-- FILEPATH: /g:/Meu Drive/_Obsidian/Projetos/IC Listz/vhdl_personal_ip/pwm_generator_tb.vhdl

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity pwm_generator_tb is
end entity pwm_generator_tb;

architecture tb_arch of pwm_generator_tb is
    -- Component declaration for the unit under test (UUT)
    component pwm_generator is
        generic (
            duty_cycle_resolution : integer := 8
        );
        port (
            duty_cycle : in std_logic_vector(duty_cycle_resolution - 1 downto 0);
            clk_in : in std_logic;
            enable : in std_logic;
            pwm_out : out std_logic
        );
    end component;

    -- Signal declarations
    signal clk : std_logic := '0';
    signal duty_cycle_in : std_logic_vector(7 downto 0) := "00000000";
    signal enable_in : std_logic := '0';
    signal pwm_out : std_logic;

begin
    -- Instantiate the unit under test (UUT)
    uut: pwm_generator
        generic map (
            duty_cycle_resolution => 8
        )
        port map (
            duty_cycle => duty_cycle_in,
            clk_in => clk,
            enable => enable_in,
            pwm_out => pwm_out
        );

    -- Clock process
    clk_process: process
    begin
        while now < 1000 ns loop
            clk <= '0';
            wait for 5 ns;
            clk <= '1';
            wait for 5 ns;
        end loop;
        wait;
    end process;

    -- Stimulus process
    stim_process: process
    begin
        -- Test case 1: Duty cycle = 50%, enable = 1
        duty_cycle_in <= "10000000";
        enable_in <= '1';
        wait for 500 ns;

        -- Test case 2: Duty cycle = 25%, enable = 1
        duty_cycle_in <= "01000000";
        enable_in <= '1';
        wait for 500 ns;

        -- Test case 3: Duty cycle = 75%, enable = 1
        duty_cycle_in <= "11000000";
        enable_in <= '1';
        wait for 500 ns;

        -- Test case 4: Duty cycle = 0%, enable = 0
        duty_cycle_in <= "00000000";
        enable_in <= '0';
        wait for 500 ns;

        -- Add more test cases as needed

        wait;
    end process;

end architecture tb_arch;