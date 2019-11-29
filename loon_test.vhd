
package types is
	type hexkey is ARRAY (0 to 4) of bit_vector(3 downto 0);
	constant O: bit_vector := X"D"; -- the O from the keypad
	constant correct_key: hexkey := (X"2",X"6",X"A",X"0",X"5"); -- this array of hex vectors represents the correct key
end package;


library ieee;
use ieee.std_logic_1164.all;
use work.types.all;

entity loon_test is
end entity;

architecture test of loon_test is

	component dac is
		port(
			clk, reset, daytime: in bit;
			code: in bit_vector(3 downto 0);
			door: out bit;
			alarm: out bit;
			vss: in bit;
			vdd: in bit
			);
	end component;

	signal clk, reset, daytime, door, alarm: bit;
	signal code: bit_vector(3 downto 0);
	constant clk_period : time := 50 ns;
	
	for all : dac use entity work.dac_j_l (structural);


begin
	
	dut : dac port map (
		clk, reset, daytime, code, door, alarm, '0', '1'
	);

	p0: process is 

		procedure check_door_closed(msg: string := "") is begin -- checks both alarm and door are off
			assert door = '0' and alarm = '0' report "door should not be open, " & msg severity error;
		end procedure check_door_closed;

		procedure check_door_open(msg: string := "") is begin -- checks door is open and alarm is off
			assert door = '1' and alarm = '0' report "door did not open, " & msg severity error;
		end procedure check_door_open;


		procedure check_alarm_on(msg: string := "") is begin -- checks alarm is on and door is closed
			assert door = '0' and alarm = '1' report "alarm did not work, " & msg severity error;
		end procedure check_alarm_on;


		procedure do_reset is begin -- this procedure resets the device
			reset <= '1';daytime <= '0';
			wait for clk_period;
			reset <= '0';
		end procedure do_reset;

		procedure enter_key(key: bit_vector(3 downto 0)) is begin -- enters a digit of the code
			code <= key;
			wait for clk_period;
		end procedure enter_key;

		procedure test_reset is begin -- this procedure tests the reset
			do_reset;
			assert door = '0' and alarm = '0' report "reset not working" severity error;
		end procedure test_reset;



		procedure check_daytime is begin --checks all testcases that need the daylight on
			-- test first O directly
			do_reset; daytime <= '1';
			enter_key(O); -- O is read from package 'type'
			check_door_open("applied only O");

			-- test first input only then O
			do_reset; daytime <= '1';
			enter_key(correct_key(0));
			check_door_closed("problem when testing daytime with first digit");
			enter_key(O);
			check_door_open("applied 2 then O");

			-- test the full key
			do_reset; daytime <= '1';
			for i in 0 to 4 loop
				check_door_closed("problem when testing daytime with the full code" & integer'image(i));
				enter_key(correct_key(i));
			end loop ;
			check_door_open("applied the full key");

			-- test alarm will sound if wrong character
			do_reset; daytime <= '1';
			enter_key(X"4");
			check_alarm_on("alarm doesn't work at daytime");

		end procedure check_daytime;

		procedure check_night is begin -- checks all cases that need the light off

			do_reset;
			for i in 0 to 4 loop
				check_door_closed("problem when testing night with the full code at digit " & integer'image(i));
				enter_key(correct_key(i));
			end loop ;
			check_door_open("applied the full key");
			enter_key(O);
			check_door_open("O after entering correct code at night made a difference, it shouldn't");


			-- testing wrong entries at every digits
			for i in 0 to 4 loop
				do_reset;
				for j in 0 to i - 1 loop
					check_door_closed("problem when checking wrong digits");
					enter_key(correct_key(j));
				end loop ;
				check_door_closed("problem when checking wrong digits");
				enter_key(X"7"); -- 7 is not a correct code
				check_alarm_on("at night when entering a wrong digit the alarm did not sound at digit no. " & integer'image(i));
				enter_key(correct_key(i));
				check_alarm_on("right key after wrong key should not stop the alarm or open the door");
			end loop ;

		end procedure check_night;

	begin

		test_reset;
		check_daytime;
		check_night;

		wait;
	end process p0;

	p1: process is begin
		clk <= '0';
		wait for clk_period / 2;
		clk <= '1';
		wait for clk_period / 2;

	end process p1;




end architecture;



