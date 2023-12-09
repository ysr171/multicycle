library ieee;
use ieee.std_logic_1164.all;

entity controller is 
	port (
	
	clk: in std_logic;
	reset: in std_logic;

	opcode: in std_logic_vector(3 downto 0);
	cz: in std_logic_vector(1 downto 0);
	carry: in std_logic;
	zero: in std_logic;


	pc_en: out std_logic;
	ir_en: out std_logic;
	rf_en: out std_logic;
	mem_d_en: out std_logic;
	carry_en: out std_logic;
	zero_en: out std_logic;
	t1_en: out std_logic;
	t2_en: out std_logic;
	t3_en: out std_logic;
	
	mem_a_select: out std_logic;
	pc_select: out std_logic_vector(1 downto 0);
	a1_select: out std_logic_vector(1 downto 0);
	a2_select: out std_logic;
	t2_select: out std_logic_vector(1 downto 0);
  	alu_op: out std_logic_vector(1 downto 0);
	alu_a_select: out std_logic_vector(1 downto 0);
	alu_b_select: out std_logic;
	t3_select: out std_logic;
	d3_select: out std_logic_vector(1 downto 0)

);
end entity;

architecture behav of controller is
	type state is (S0, S1, S2, S3, S4, S5, S6, S7, S8, S9, S10, S11, S12, S13, S14, S15, S16, S17, S18, S19);
	signal y_present, y_next: state;
begin


clock_proc: process(clk, reset)
begin
	if(clk='1' and clk' event) then
		if(reset='1') then
			y_present<=S0;
		else
			y_present<=y_next;
		end if;
	end if;
end process;


state_transition_proc: process(y_present)
begin
	case y_present is
		when S0=>
			y_next<=S1;
		when S1=>
			if(opcode="0001" or opcode="0010") then
				if(cz="11") then
					y_next<=S5;
				elsif(carry='1' or zero='1') then
					y_next<=S2;
				else
					y_next<=S0;
				end if;
			elsif(opcode="0000" or opcode="0111" or opcode="0101") then
				y_next<=S7;
         elsif(opcode="0011") then
				y_next<=S8;
         elsif(opcode="1000") then
				y_next<=S11;
         elsif(opcode="1001" or opcode="1010") then
				y_next<=S14;
         elsif(opcode="1011") then
				y_next<=S17;
			else
				y_next<=S0;
			end if;
		when S2=>
			if(opcode="0001") then
				y_next<=S3;
			else
				y_next<=S6;
			end if;
		when S3=>
			y_next<=S4;
		when S4=>
			y_next<=S0;
		when S5=>
			y_next<=S3;
		when S6=>
			if(opcode="0010") then
				y_next<=S4;
			elsif(opcode="0111") then
				y_next<=S9;
			else
				y_next<=S10;
			end if;
		when S7=>
			if(opcode="0000") then
				y_next<=S3;
			else
				y_next<=S6;
			end if;
		when S8=>
			y_next<=S0;
		when S9=>
			y_next<=S0;
		when S10=>
			y_next<=S0;
		when S11=>
			y_next<=S19;
		when S12=>
			y_next<=S13;
		when S13=>
			if(opcode="1001") then
				y_next<=S15;
			else
				y_next<=S0;
			end if;
		when S14=>
			if(opcode="1001") then
				y_next<=S13;
			else
				y_next<=S2;
			end if;
		when S15=>
			y_next<=S0;
		when S16=>
			y_next<=S0;
		when S17=>
			y_next<=S18;
		when S18=>
			y_next<=S0;
		when S19=>
         if(opcode="1000" and zero='1') then
				y_next<=S12;
			else
				y_next<=S0;
			end if;
	end case;
end process;



output_proc: process(y_present)
begin
	case y_present is
		when S0=>
			pc_en<='0';
			ir_en<='0';
			rf_en<='0';
			mem_d_en<='0';
			carry_en<='0';
			zero_en<='0';
			t1_en<='0';
			t2_en<='0';
			t3_en<='0';
			mem_a_select<='0';
			pc_select<="00";
			a1_select<="00";
			a2_select<='0';
			t2_select<="00";
			alu_op<="00";
			alu_a_select<="00";
			alu_b_select<='0';
			t3_select<='0';
			d3_select<="00";
		when S1=>
			pc_en<='1';
			ir_en<='1';
			rf_en<='0';
			mem_d_en<='0';
			carry_en<='0';
			zero_en<='0';
			t1_en<='0';
			t2_en<='0';
			t3_en<='0';
			mem_a_select<='1';
			pc_select<="01";
			a1_select<="00";
			a2_select<='0';
			t2_select<="00";
			alu_op<="00";
			alu_a_select<="00";
			alu_b_select<='0';
			t3_select<='0';
			d3_select<="00";
		when S2=>
			pc_en<='0';
			ir_en<='0';
			rf_en<='0';
			mem_d_en<='0';
			carry_en<='0';
			zero_en<='0';
			t1_en<='1';
			t2_en<='1';
			t3_en<='0';
			mem_a_select<='0';
			pc_select<="00";
			a1_select<="10";
			a2_select<='1';
			t2_select<="01";
			alu_op<="00";
			alu_a_select<="00";
			alu_b_select<='0';
			t3_select<='0';
			d3_select<="00";
		when S3=>
			pc_en<='0';
			ir_en<='0';
			rf_en<='0';
			mem_d_en<='0';
			carry_en<='1';
			zero_en<='1';
			t1_en<='0';
			t2_en<='0';
			t3_en<='1';
			mem_a_select<='0';
			pc_select<="00";
			a1_select<="00";
			a2_select<='1';
			t2_select<="00";
			alu_op<="11";
			alu_a_select<="00";
			alu_b_select<='1';
			t3_select<='0';
			d3_select<="00";
		when S4=>
			pc_en<='0';
			ir_en<='0';
			rf_en<='1';
			mem_d_en<='0';
			carry_en<='0';
			zero_en<='0';
			t1_en<='0';
			t2_en<='0';
			t3_en<='0';
			mem_a_select<='0';
			pc_select<="00";
			a1_select<="00";
			a2_select<='0';
			t2_select<="00";
			alu_op<="00";
			alu_a_select<="00";
			alu_b_select<='0';
			t3_select<='0';
			d3_select<="01";
		when S5=>
			pc_en<='0';
			ir_en<='0';
			rf_en<='0';
			mem_d_en<='0';
			carry_en<='0';
			zero_en<='0';
			t1_en<='1';
			t2_en<='1';
			t3_en<='0';
			mem_a_select<='0';
			pc_select<="00";
			a1_select<="10";
			a2_select<='1';
			t2_select<="00";
			alu_op<="00";
			alu_a_select<="00";
			alu_b_select<='0';
			t3_select<='0';
			d3_select<="00";
		when S6=>
			pc_en<='0';
			ir_en<='0';
			rf_en<='0';
			mem_d_en<='0';
			carry_en<='0';
			zero_en<='1';
			t1_en<='0';
			t2_en<='0';
			t3_en<='1';
			mem_a_select<='0';
			pc_select<="00";
			a1_select<="00";
			a2_select<='1';
			t2_select<="00";
			alu_op<="00";
			alu_a_select<="00";
			alu_b_select<='1';
			t3_select<='0';
			d3_select<="00";
		when S7=>
			pc_en<='0';
			ir_en<='0';
			rf_en<='0';
			mem_d_en<='0';
			carry_en<='0';
			zero_en<='0';
			t1_en<='1';
			t2_en<='1';
			t3_en<='0';
			mem_a_select<='0';
			pc_select<="00";
			a1_select<="01";
			a2_select<='0';
			t2_select<="10";
			alu_op<="00";
			alu_a_select<="00";
			alu_b_select<='0';
			t3_select<='0';
			d3_select<="00";
		when S8=>
			pc_en<='0';
			ir_en<='0';
			rf_en<='1';
			mem_d_en<='0';
			carry_en<='0';
			zero_en<='0';
			t1_en<='0';
			t2_en<='0';
			t3_en<='0';
			mem_a_select<='0';
			pc_select<="00";
			a1_select<="00";
			a2_select<='0';
			t2_select<="00";
			alu_op<="00";
			alu_a_select<="00";
			alu_b_select<='0';
			t3_select<='0';
			d3_select<="10";
		when S9=>
			pc_en<='0';
			ir_en<='0';
			rf_en<='1';
			mem_d_en<='0';
			carry_en<='0';
			zero_en<='0';
			t1_en<='0';
			t2_en<='0';
			t3_en<='0';
			mem_a_select<='0';
			pc_select<="00";
			a1_select<="00";
			a2_select<='0';
			t2_select<="00";
			alu_op<="00";
			alu_a_select<="00";
			alu_b_select<='0';
			t3_select<='0';
			d3_select<="00";
		when S10=>
			pc_en<='0';
			ir_en<='0';
			rf_en<='0';
			mem_d_en<='1';
			carry_en<='0';
			zero_en<='0';
			t1_en<='0';
			t2_en<='0';
			t3_en<='0';
			mem_a_select<='0';
			pc_select<="00";
			a1_select<="00";
			a2_select<='0';
			t2_select<="00";
			alu_op<="00";
			alu_a_select<="00";
			alu_b_select<='0';
			t3_select<='0';
			d3_select<="00";
		when S11=>
			pc_en<='0';
			ir_en<='0';
			rf_en<='0';
			mem_d_en<='0';
			carry_en<='0';
			zero_en<='0';
			t1_en<='1';
			t2_en<='1';
			t3_en<='0';
			mem_a_select<='0';
			pc_select<="00";
			a1_select<="01";
			a2_select<='0';
			t2_select<="01";
			alu_op<="00";
			alu_a_select<="00";
			alu_b_select<='0';
			t3_select<='0';
			d3_select<="00";
		when S12=>
			pc_en<='1';
			ir_en<='0';
			rf_en<='0';
			mem_d_en<='0';
			carry_en<='0';
			zero_en<='0';
			t1_en<='0';
			t2_en<='0';
			t3_en<='0';
			mem_a_select<='0';
			pc_select<="00";
			a1_select<="00";
			a2_select<='0';
			t2_select<="00";
			alu_op<="11";
			alu_a_select<="01";
			alu_b_select<='0';
			t3_select<='0';
			d3_select<="00";
		when S13=>
			pc_en<='1';
			ir_en<='0';
			rf_en<='0';
			mem_d_en<='0';
			carry_en<='0';
			zero_en<='0';
			t1_en<='0';
			t2_en<='0';
			t3_en<='0';
			mem_a_select<='0';
			pc_select<="11";
			a1_select<="00";
			a2_select<='0';
			t2_select<="00";
			alu_op<="00";
			alu_a_select<="00";
			alu_b_select<='0';
			t3_select<='0';
			d3_select<="00";
		when S14=>
			pc_en<='0';
			ir_en<='0';
			rf_en<='1';
			mem_d_en<='0';
			carry_en<='0';
			zero_en<='0';
			t1_en<='0';
			t2_en<='0';
			t3_en<='1';
			mem_a_select<='0';
			pc_select<="00";
			a1_select<="00";
			a2_select<='0';
			t2_select<="00";
			alu_op<="00";
			alu_a_select<="00";
			alu_b_select<='0';
			t3_select<='1';
			d3_select<="01";
		when S15=>
			pc_en<='1';
			ir_en<='0';
			rf_en<='0';
			mem_d_en<='0';
			carry_en<='0';
			zero_en<='0';
			t1_en<='0';
			t2_en<='0';
			t3_en<='0';
			mem_a_select<='0';
			pc_select<="00";
			a1_select<="00";
			a2_select<='0';
			t2_select<="00";
			alu_op<="11";
			alu_a_select<="10";
			alu_b_select<='0';
			t3_select<='0';
			d3_select<="00";
		when S16=>
			pc_en<='1';
			ir_en<='0';
			rf_en<='0';
			mem_d_en<='0';
			carry_en<='0';
			zero_en<='0';
			t1_en<='0';
			t2_en<='0';
			t3_en<='0';
			mem_a_select<='0';
			pc_select<="10";
			a1_select<="00";
			a2_select<='0';
			t2_select<="00";
			alu_op<="00";
			alu_a_select<="00";
			alu_b_select<='0';
			t3_select<='0';
			d3_select<="00";
		when S17=>
			pc_en<='0';
			ir_en<='0';
			rf_en<='0';
			mem_d_en<='0';
			carry_en<='0';
			zero_en<='0';
			t1_en<='1';
			t2_en<='1';
			t3_en<='0';
			mem_a_select<='0';
			pc_select<="00";
			a1_select<="00";
			a2_select<='0';
			t2_select<="11";
			alu_op<="00";
			alu_a_select<="00";
			alu_b_select<='0';
			t3_select<='0';
			d3_select<="00";
		when S18=>
			pc_en<='1';
			ir_en<='0';
			rf_en<='0';
			mem_d_en<='0';
			carry_en<='0';
			zero_en<='0';
			t1_en<='0';
			t2_en<='0';
			t3_en<='0';
			mem_a_select<='0';
			pc_select<="00";
			a1_select<="00";
			a2_select<='0';
			t2_select<="00";
			alu_op<="11";
			alu_a_select<="00";
			alu_b_select<='1';
			t3_select<='0';
			d3_select<="00";
		when S19=>
			pc_en<='0';
			ir_en<='0';
			rf_en<='0';
			mem_d_en<='0';
			carry_en<='0';
			zero_en<='1';
			t1_en<='0';
			t2_en<='0';
			t3_en<='1';
			mem_a_select<='0';
			pc_select<="00";
			a1_select<="00";
			a2_select<='1';
			t2_select<="00";
			alu_op<="01";
			alu_a_select<="00";
			alu_b_select<='1';
			t3_select<='0';
			d3_select<="00";
	end case;
end process;

end behav;
