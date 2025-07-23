/Versión corregida de sensor
-- MicroZed-Chronicles
-- VHDL_Part56.vhd: Prototipo para simular sensor_link

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

library UNISIM;
use UNISIM.VComponents.all;

entity sensor_link_stim is
end sensor_link_stim;

architecture Behavioral of sensor_link_stim is

    component sensor_link
        port (
            _     : in  std_logic;
            _     : out std_logic;
            _     : out std_logic;
            _     : out std_logic;
            _     : out std_logic_vector(9 downto 0)
        );
    end component;

    -- Señales del reloj y modo de operación
    signal clk        : std_logic := '0';
    signal ser_clk    : std_logic := '0';

    -- Señales de generación de resolución
    signal gen_h_total  : integer range 0 to 2047 := 1280;
    signal gen_h_act    : integer range 0 to 2047 := 1024;
    signal gen_h_blank  : integer range 0 to 2047 := 256;
    signal gen_v_total  : integer range 0 to 2047 := 720;
    signal gen_v_act    : integer range 0 to 2047 := 640;
    signal gen_v_blank  : integer range 0 to 2047 := 80;

    -- Contadores de línea y cuadro
    signal line_cnt   : integer range 0 to 2047 := 0;
    signal frame_cnt  : integer range 0 to 2047 := 0;

    -- Señales de control
    signal lval       : std_logic;
    signal fval       : std_logic;
    signal dval       : std_logic;

    -- Señales de datos
    signal data       : unsigned(9 downto 0) := (others => '0');
    signal data_rx    : std_logic_vector(9 downto 0);
    signal fval_rx    : std_logic;
    signal lval_rx    : std_logic;
    signal dval_rx    : std_logic;

begin

    -- Generador de reloj
    clk_gen : process
    begin
        while true loop
            clk <= '0';
            wait for 10 ns;
            clk <= '1';
            wait for 10 ns;
        end loop;
    end process;

    -- Generador de señales de control
    gen_proc : process(clk)
    begin
        if rising_edge(clk) then
            if line_cnt < gen_h_total - 1 then
                line_cnt <= line_cnt + 1;
            else
                line_cnt <= 0;
                if frame_cnt < gen_v_total - 1 then
                    frame_cnt <= frame_cnt + 1;
                else
                    frame_cnt <= 0;
                end if;
            end if;
        end if;
    end process;

    -- Señales de validez
    lval <= '1' when line_cnt >= gen_h_blank else '0';
    fval <= '1' when frame_cnt >= gen_v_blank else '0';
    dval <= lval and fval;

    -- Generador de datos
    data_gen : process(clk)
    begin
        if rising_edge(clk) then
            if dval = '1' then
                data <= data + 1;
            else
                data <= (others => '0');
            end if;
        end if;
    end process;

    -- Instancia del sensor simulado
    uut: sensor_link
        port map (
            _   => clk,
            _  => fval_rx,
            _  => lval_rx,
            _  => dval_rx,
            _  => data_rx
        );

end Behavioral;
