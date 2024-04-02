library IEEE;
use IEEE.std_logic_1164.all;


entity UALCore is
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
end UALCore;





architecture UALCore_ARCH of UALCore is

begin

    UALCoreProcess : process (SelectFunction, A, B, SR_In_L, SR_In_R)
    variable Grand_A, Grand_B : std_logic_vector(7 downto 0);    

    begin
        SR_Out_R <= '0';
        SR_Out_L <= '0';
        
        Gros_A(3 downto 0) := A;
        Gros_A(7 downto 4) := (others => A(3));
        Gros_B(3 downto 0) := B;
        Gros_B(7 downto 4) := (others => B(3));
           case(SEL_FCT) is
            when "0001" =>
                SR_Out_R <= A(0);
                S(2 downto 0) <= A(3 downto 1);
                S(3) <= SR_In_L;
            when "0010" =>
                SR_Out_L <= A(3);
                S(3 downto 1) <= A(2 downto 0);
                S(3) <= SR_In_R;
            when "0011" =>
                SR_Out_R <= B(0);
                S(2 downto 0) <= B(3 downto 1);
                S(3) <= SR_In_L;
            when "0100" =>
                SR_Out_L <= B(3);
                S(3 downto 1) <= B(2 downto 0);
                S(3) <= SR_In_R;
            when "0101" =>
                S(3 downto 0) <= A;
            when "0110" =>
                S(3 downto 0) <= B;
            when "0111" =>
                S(3 downto 0) <= not A;
            when "1000" =>
                S(3 downto 0) <= not B;
            when "1001" =>
                S(3 downto 0) <= A and B;
            when "1010" =>
                S(3 downto 0) <= A or B;
            when "1011" =>
                S(3 downto 0) <= A xor B;
            when "1100" =>
                S <= Gros_A + Gros_B + SR_In_R;
            when "1101" =>
                S <= Gros_A + Gros_B;
            when "1110" =>
                S <= Gros_A - Gros_B;
            when "1111" =>
                S <= A * B;
            when others =>
                S <= "00000000";
            end case;
    end process;

end UALCore_ARCH;