library ieee;
use ieee.std_logic_1164.all;

entity instr_reg is
  port (
	ir_in : in std_logic_vector(15 downto 0);
	ir_en : in std_logic;
	ir_out_15_12 : out std_logic_vector(3 downto 0);
	ir_out_11_9 : out std_logic_vector(2 downto 0);
	ir_out_8_6 : out std_logic_vector(2 downto 0);
	ir_out_5_3 : out std_logic_vector(2 downto 0);
	ir_out_5_0 : out std_logic_vector(5 downto 0);
	ir_out_8_0 : out std_logic_vector(8 downto 0);
	ir_out_1_0 : out std_logic_vector(1 downto 0);
	clk : in std_logic
  );
end entity;

architecture basic of instr_reg is

begin
write_proc: process(clk)
begin
	if (clk'event and clk = '0' and ir_en = '1') then 
		ir_out_15_12 <= ir_in(15 downto 12);
		ir_out_11_9 <= ir_in(11 downto 9);
		ir_out_8_6 <= ir_in(8 downto 6);
		ir_out_5_3 <= ir_in(5 downto 3);
		ir_out_5_0 <= ir_in(5 downto 0);
		ir_out_8_0 <= ir_in(8 downto 0);
		ir_out_1_0 <= ir_in(1 downto 0);
	end if;
end process;
end basic;