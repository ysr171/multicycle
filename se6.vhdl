library ieee;
use ieee.std_logic_1164.all;

entity se6 is
	port(
		di : in std_logic_vector(5 downto 0);
		do : out std_logic_vector(15 downto 0)
	);
end entity;

architecture comb of se6 is

begin
	do(5 downto 0) <= di(5 downto 0);
	do(6) <= di(5);
	do(7) <= di(5);
	do(8) <= di(5);
	do(9) <= di(5);
	do(10) <= di(5);
	do(11) <= di(5);
	do(12) <= di(5);
	do(13) <= di(5);
	do(14) <= di(5);
	do(15) <= di(5);
end comb;
