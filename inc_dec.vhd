library std;
library ieee;
use ieee.numeric_std.all;
use ieee.std_logic_1164.all;

entity inc_dec is
	port(
		di : in std_logic_vector(15 downto 0);
		inc : out std_logic_vector(15 downto 0);
		dec : out std_logic_vector(15 downto 0)
	);
end entity;

architecture comb of inc_dec is
begin
	inc <= std_logic_vector(unsigned(di) + 1);
	dec <= std_logic_vector(unsigned(di) - 1);
end comb;