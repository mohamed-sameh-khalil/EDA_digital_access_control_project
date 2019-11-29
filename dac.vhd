entity dac is
  port (
	clk, reset, daytime: in bit;
	code: in bit_vector(3 downto 0);
	door: out bit;
	alarm: out bit;
	vss: in bit;
	vdd: in bit
  ) ;
end dac ;


architecture alternate of dac is
	
	--pragma clock clk
	--pragma current_state cst
	--pragma next_state nst

	type altstate is(hear0, hear1, hear2, hear3, hear4, good, bad);	
	signal cst, nst: altstate;

begin


	ck: process(clk)
	begin
		if(clk = '1' and clk'event) then
			cst <= nst;
		end if;
	end process ck;

	main: process(cst, code, daytime, reset) --moore output will be used
		
	begin
		if (reset = '1') then
			nst <= hear0;
		else
			
			case(cst) is
			when bad => nst <= bad;
			when good => nst <= good; -- when wrong or correct wait for reset

			when hear0 =>
				if(daytime = '1' and code = X"D") then
					nst <= good;
				elsif(code = X"2") then
					nst <= hear1;
				else
					nst <= bad;
				end if;
			
			when hear1 =>
				if(daytime = '1' and code = X"D") then
					nst <= good;
				elsif(code = X"6") then
					nst <= hear2;
				else
					nst <= bad;
				end if;
				
			when hear2 =>
				if(daytime = '1' and code = X"D") then
					nst <= good;
				elsif(code = X"A") then
					nst <= hear3;
				else
					nst <= bad;
				end if;


			when hear3 =>
				if(daytime = '1' and code = X"D") then
					nst <= good;
				elsif(code = X"0") then
					nst <= hear4;
				else
					nst <= bad;
				end if;	


			when hear4 =>
				if(daytime = '1' and code = X"D") then
					nst <= good;
				elsif(code = X"5") then
					nst <= good;
				else
					nst <= bad;
				end if;
			when others =>
				nst <= hear0;

			end case;
		end if;

		case (cst) is
			when bad =>
				door <= '0'; alarm <= '1';
			when good =>
				door <= '1'; alarm <= '0';
			when hear0 =>
				door <= '0'; alarm <= '0';
			when hear1 =>
				door <= '0'; alarm <= '0';
			when hear2 =>
				door <= '0'; alarm <= '0';
			when hear3 =>
				door <= '0'; alarm <= '0';
			when hear4 =>
				door <= '0'; alarm <= '0';
			when others =>
				door <= '0'; alarm <= '0';

		end case;
	end process main;

end alternate;