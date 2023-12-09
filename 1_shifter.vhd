library ieee;
use ieee.std_logic_1164.all;

entity shifter1 is
	port (
		di : in std_logic_vector(15 downto 0);
		do : out std_logic_vector(15 downto 0)
	);
end entity;

architecture comb of shifter1 is

begin
	do(15 downto 1)<=di(14 downto 0);
	do(0)<='0';
end comb;
