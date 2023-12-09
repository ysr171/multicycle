library ieee;
use ieee.std_logic_1164.all;


entity reg_file is
	port(
	clk : in std_logic;

	rf_en : in std_logic;
	pc_en : in std_logic;

	pc_in : in std_logic_vector(15 downto 0);
	a1 : in std_logic_vector(2 downto 0);
	a2 : in std_logic_vector(2 downto 0);
	a3 : in std_logic_vector(2 downto 0);

	d3 : in std_logic_vector(15 downto 0);
	
	d1 : out std_logic_vector(15 downto 0);
	d2 : out std_logic_vector(15 downto 0);
	pc_out : out std_logic_vector(15 downto 0)
	);
end entity;

architecture behav of reg_file is

	signal reg_0 : std_logic_vector(15 downto 0);
	signal reg_1 : std_logic_vector(15 downto 0);
	signal reg_2 : std_logic_vector(15 downto 0);
	signal reg_3 : std_logic_vector(15 downto 0);
	signal reg_4 : std_logic_vector(15 downto 0);
	signal reg_5 : std_logic_vector(15 downto 0);
	signal reg_6 : std_logic_vector(15 downto 0);
	signal reg_7 : std_logic_vector(15 downto 0);

begin
write_proc: process(clk)
begin
	if (clk'event and clk = '0') then 
		if (rf_en = '1') then 
			if a3 = "000" then 
				reg_0 <= d3;
			elsif a3 = "001" then 
				reg_1 <= d3;
			elsif a3 = "010" then 
				reg_2 <= d3;
			elsif a3 = "011" then 
				reg_3 <= d3;
			elsif a3 = "100" then 
				reg_4 <= d3;
			elsif a3 = "101" then 
				reg_5 <= d3;
			elsif a3 = "110" then 
				reg_6 <= d3;
			elsif a3 = "111" then 
				reg_7 <= d3;
			end if;
		end if;
		if (pc_en = '1') then 
			reg_7 <= pc_in;
		end if;
	end if;
end process;

read_proc: process(a1, a2)
begin
	if a1 = "000" then
		d1<=reg_0;
	elsif a1 = "001" then
		d1<=reg_1;
	elsif a1 = "010" then
		d1<=reg_2;
	elsif a1 = "011" then
		d1<=reg_3;
	elsif a1 = "100" then
		d1<=reg_4;
	elsif a1 = "101" then
		d1<=reg_5;
	elsif a1 = "110" then
		d1<=reg_6;
	elsif a1 = "111" then
		d1<=reg_7;
	end if;
	
	
	if a2 = "000" then
		d2<=reg_0;
	elsif a2 = "001" then
		d2<=reg_1;
	elsif a2 = "010" then
		d2<=reg_2;
	elsif a2 = "011" then
		d2<=reg_3;
	elsif a2 = "100" then
		d2<=reg_4;
	elsif a2 = "101" then
		d2<=reg_5;
	elsif a2 = "110" then
		d2<=reg_6;
	elsif a2 = "111" then
		d2<=reg_7;
	end if;
end process;

end behav;