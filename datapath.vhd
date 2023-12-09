library ieee;
use ieee.std_logic_1164.all;
library work;

entity datapath is
   port(
		clk: in std_logic;
		init_mem: in std_logic;
		rst_ctrl: in std_logic
	);
end entity;

architecture basic of datapath is
	
	signal mem_d_en : std_logic;
	signal mem_a : std_logic_vector(15 downto 0);
	signal mem_d_in_d1 : std_logic_vector(15 downto 0);
	signal mem_d_out_ir_in : std_logic_vector(15 downto 0);
	
	signal ir_en : std_logic;
	signal ir_out_15_12_opcode : std_logic_vector(3 downto 0);
	signal ir_out_11_9_a3 : std_logic_vector(2 downto 0);
	signal ir_out_8_6 : std_logic_vector(2 downto 0);
	signal ir_out_5_3 : std_logic_vector(2 downto 0);
	signal ir_out_5_0_se6_di : std_logic_vector(5 downto 0);
	signal ir_out_8_0_se9_di_dex_di : std_logic_vector(8 downto 0);
	signal ir_out_1_0_cz : std_logic_vector(1 downto 0);
	
	signal rf_en : std_logic;
	signal pc_en : std_logic;
	signal pc_in : std_logic_vector(15 downto 0);
	signal a1 : std_logic_vector(2 downto 0);
	signal a2 : std_logic_vector(2 downto 0);
	signal d3 : std_logic_vector(15 downto 0);
	signal d2_shifter1_di : std_logic_vector(15 downto 0);
	signal pc_out_inc_dec_di : std_logic_vector(15 downto 0);
	
	signal alu_a : std_logic_vector(15 downto 0);
	signal alu_b : std_logic_vector(15 downto 0);
	signal alu_op : std_logic_vector(1 downto 0);
	signal alu_out : std_logic_vector(15 downto 0);
	signal alu_carry : std_logic;
	signal alu_zero : std_logic;
	
	signal se6_do : std_logic_vector(15 downto 0);
	
	signal se9_do : std_logic_vector(15 downto 0);
	
	signal dex_do : std_logic_vector(15 downto 0);
	
	signal inc : std_logic_vector(15 downto 0);
	signal dec : std_logic_vector(15 downto 0);
	
	signal shifter1_do : std_logic_vector(15 downto 0);
	
	signal carry : std_logic;
	signal zero : std_logic;
	signal carry_en : std_logic;
	signal zero_en : std_logic;
	signal t1_en : std_logic;
	signal t2_en : std_logic;
	signal t3_en : std_logic;
	signal mem_a_select : std_logic;
	signal pc_select : std_logic_vector(1 downto 0);
	signal a1_select : std_logic_vector(1 downto 0);
	signal a2_select : std_logic;
	signal t2_select : std_logic_vector(1 downto 0);
	signal alu_a_select : std_logic_vector(1 downto 0);
	signal alu_b_select : std_logic;
	signal t3_select : std_logic;
	signal d3_select : std_logic_vector(1 downto 0);
	
	signal t1 : std_logic_vector(15 downto 0);
	signal t2 : std_logic_vector(15 downto 0);
	signal t3 : std_logic_vector(15 downto 0);
	signal t2_in : std_logic_vector(15 downto 0);
	signal t3_in : std_logic_vector(15 downto 0);
	
begin
   memory: work.memory
	port map(
		clk => clk,
		initialize => init_mem,
		mem_d_en => mem_d_en,
		mem_a => mem_a,
		mem_d_in => mem_d_in_d1,
		mem_d_out => mem_d_out_ir_in
	);
	instr_reg: work.instr_reg
	port map(
		ir_in => mem_d_out_ir_in,
		ir_en => ir_en,
		ir_out_15_12 => ir_out_15_12_opcode,
		ir_out_11_9 => ir_out_11_9_a3,
		ir_out_8_6 => ir_out_8_6,
		ir_out_5_3 => ir_out_5_3,
		ir_out_5_0 => ir_out_5_0_se6_di,
		ir_out_8_0 => ir_out_8_0_se9_di_dex_di,
		ir_out_1_0 => ir_out_1_0_cz,
		clk => clk
	);
	reg_file: work.reg_file
	port map(
		clk => clk,
		rf_en => rf_en,
		pc_en => pc_en,
		pc_in => pc_in,
		a1 => a1,
		a2 => a2,
		a3 => ir_out_11_9_a3,
		d3 => d3,
		d1 => mem_d_in_d1,
		d2 => d2_shifter1_di,
		pc_out => pc_out_inc_dec_di
	);
	alu: work.alu
	port map(
		alu_a => alu_a,
		alu_b => alu_b,
		alu_op => alu_op,
		alu_out => alu_out,
		carry => alu_carry,
		zero => alu_zero
	);
	se6: work.se6
	port map(
		di => ir_out_5_0_se6_di,
		do => se6_do
	);
	se9: work.se9
	port map(
		di => ir_out_8_0_se9_di_dex_di,
		do => se9_do
	);
	dex: work.dex
	port map(
		di => ir_out_8_0_se9_di_dex_di,
		do => dex_do
	);
	inc_dec: work.inc_dec
	port map(
		di => pc_out_inc_dec_di,
		inc => inc,
		dec => dec
	);
	shifter1: work.shifter1
	port map(
		di => d2_shifter1_di,
		do => shifter1_do
	);
	controller: work.controller
	port map(
		clk => clk,
		reset => rst_ctrl,

		opcode => ir_out_15_12_opcode,
		cz => ir_out_1_0_cz,
		carry => carry,
		zero => zero,


		pc_en => pc_en,
		ir_en => ir_en,
		rf_en => rf_en,
		mem_d_en => mem_d_en,
		carry_en => carry_en,
		zero_en => zero_en,
		t1_en => t1_en,
		t2_en => t2_en,
		t3_en => t3_en,
		
		mem_a_select => mem_a_select,
		pc_select => pc_select,
		a1_select => a1_select,
		a2_select => a2_select,
		t2_select => t2_select,
		alu_op => alu_op,
		alu_a_select => alu_a_select,
		alu_b_select => alu_b_select,
		t3_select => t3_select,
		d3_select => d3_select
	);

mux_mem_a: process(mem_a_select, t3, pc_out_inc_dec_di)
begin
	if(mem_a_select='0') then
		mem_a<=t3;
	else
		mem_a<=pc_out_inc_dec_di;
	end if;
end process;

mux_pc_in: process(pc_select, alu_out, inc, t2, dec)
begin
	if(pc_select="00") then
		pc_in<=alu_out;
	elsif(a1_select="01") then
		pc_in<=inc;
	elsif(a1_select="10") then
		pc_in<=t2;
	else
		pc_in<=dec;
	end if;
end process;

mux_a1: process(a1_select, ir_out_11_9_a3, ir_out_8_6, ir_out_5_3)
begin
	if(a1_select="00") then
		a1<=ir_out_11_9_a3;
	elsif(a1_select="01") then
		a1<=ir_out_8_6;
	else
		a1<=ir_out_5_3;
	end if;
end process;

mux_a2: process(a2_select, ir_out_11_9_a3, ir_out_8_6)
begin
	if(a2_select='0') then
		a2<=ir_out_11_9_a3;
	else
		a2<=ir_out_8_6;
	end if;
end process;

mux_t2: process(t2_select, shifter1_do, d2_shifter1_di, se6_do, se9_do)
begin
	if(t2_select="00") then
		t2_in<=shifter1_do;
	elsif(t2_select="01") then
		t2_in<=d2_shifter1_di;
	elsif(t2_select="10") then
		t2_in<=se6_do;
	else
		t2_in<=se9_do;
	end if;
end process;

mux_alu_a: process(alu_a_select, t1, se6_do, se9_do)
begin
	if(alu_a_select="00") then
		alu_a<=t1;
	elsif(alu_a_select="01") then
		alu_a<=se6_do;
	else
		alu_a<=se9_do;
	end if;
end process;

mux_alu_b: process(alu_b_select, pc_out_inc_dec_di, t2)
begin
	if(alu_b_select='0') then
		alu_b<=pc_out_inc_dec_di;
	else
		alu_b<=t2;
	end if;
end process;

mux_t3: process(t3_select, alu_out, pc_out_inc_dec_di)
begin
	if(t3_select='0') then
		t3_in<=alu_out;
	else
		t3_in<=pc_out_inc_dec_di;
	end if;
end process;

mux_d3: process(d3_select, mem_d_out_ir_in, t3, dex_do)
begin
	if(d3_select="00") then
		d3<=mem_d_out_ir_in;
	elsif(d3_select="01") then
		d3<=t3;
	else
		d3<=dex_do;
	end if;
end process;

write_proc: process(clk)
begin
	if(clk='0' and clk' event) then
		if(t1_en='1') then
			t1<=mem_d_in_d1;
		end if;
		if(t2_en='1') then
			t2<=t2_in;
		end if;
		if(t3_en='1') then
			t3<=t3_in;
		end if;
		if(carry_en='1') then
			carry<=alu_carry;
		end if;
		if(zero_en='1') then
			zero<=alu_zero;
		end if;
	end if;
end process;

end basic;

