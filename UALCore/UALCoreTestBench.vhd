library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.ALL;


entity UALCoreTestBench is

end UALCoreTestBench;




architecture UALCoreTestBench_ARCH of UALCoreTestBench is

    -- Composants

    component UALCore is
        port (
            -- Entrées
            A : in std_logic_vector(3 downto 0);
            B : in std_logic_vector(3 downto 0);
            SR_In_L : in std_logic;
            SR_In_R : in std_logic;
            SelectFunction : in std_logic_vector(3 downto 0);

            -- Sorties
            S : out std_logic_vector(7 downto 0);
            SR_Out_L : out std_logic;
            SR_Out_R : out std_logic
        );
    end component;


    -- Signals

    signal A_sim, B_sim, SelectFunction_sim : std_logic_vector(3 downto 0);
    signal SR_In_L_sim, SR_In_R_sim : std_logic;
    signal S_sim : std_logic_vector(7 downto 0);
    signal SR_Out_L_sim, SR_Out_R_sim : std_logic;



begin

    UALCoreEnTest : UALCore
    port map (
        A => A_sim,
        B => B_sim,
        SR_In_L => SR_In_L_sim,
        SR_In_R => SR_In_R_sim,
        SelectFunction => SelectFunction_sim,
        S => S_sim,
        SR_Out_L => SR_Out_L_sim,
        SR_Out_R => SR_Out_R_sim
    );


    UALCoreTestBenchProcess : process
    begin
        for fct in 0 to 15 loop
            for a in 0 to 3 loop
                for b in 0 to 3 loop
                    for l_in in 0 to 1 loop
                        for r_in in 0 to 1 loop
                            SelectFunction_sim <= std_logic_vector(to_unsigned(fct,8));
                            A_sim <= std_logic_vector(to_unsigned(a,4));
                            B_sim <= std_logic_vector(to_unsigned(b,4));
                            SR_In_L_sim <= to_unsigned(l_in,1)(0);
                            SR_In_R_sim <= to_unsigned(r_in,1)(0);
                            report "sel_fct=" & integer'image(fct) & " | A =" & integer'image(a) & " | B =" & integer'image(b) & " | SR_IN_L =" & integer'image(l_in) & " | SR_IN_R =" & integer'image(r_in) & " | S =" & integer'image(to_integer(signed(S_sim))) & " | SR_OUT_R =" & integer'image(to_integer(SR_Out_R_sim)) & " | SR_OUT_L =" & integer'image(to_integer(SR_Out_L_sim));
                            wait for 10 us;
                        end loop;
                    end loop;
                end loop;
            end loop;
        end loop;
    end process;

end UALCoreTestBench_ARCH;