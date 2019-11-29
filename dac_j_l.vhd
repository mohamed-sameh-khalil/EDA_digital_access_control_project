LIBRARY sxlib_ModelSim;
entity dac_j_l is
   port (
      clk     : in      bit;
      reset   : in      bit;
      daytime : in      bit;
      code    : in      bit_vector(3 downto 0);
      door    : out     bit;
      alarm   : out     bit;
      vss     : in      bit;
      vdd     : in      bit
 );
end dac_j_l;

architecture structural of dac_j_l is
Component o3_x2
   port (
      i0  : in      bit;
      i1  : in      bit;
      i2  : in      bit;
      q   : out     bit;
      vdd : in      bit;
      vss : in      bit
 );
end component;

Component inv_x4
   port (
      i   : in      bit;
      nq  : out     bit;
      vdd : in      bit;
      vss : in      bit
 );
end component;

Component inv_x2
   port (
      i   : in      bit;
      nq  : out     bit;
      vdd : in      bit;
      vss : in      bit
 );
end component;

Component a2_x2
   port (
      i0  : in      bit;
      i1  : in      bit;
      q   : out     bit;
      vdd : in      bit;
      vss : in      bit
 );
end component;

Component no4_x1
   port (
      i0  : in      bit;
      i1  : in      bit;
      i2  : in      bit;
      i3  : in      bit;
      nq  : out     bit;
      vdd : in      bit;
      vss : in      bit
 );
end component;

Component na3_x1
   port (
      i0  : in      bit;
      i1  : in      bit;
      i2  : in      bit;
      nq  : out     bit;
      vdd : in      bit;
      vss : in      bit
 );
end component;

Component na2_x1
   port (
      i0  : in      bit;
      i1  : in      bit;
      nq  : out     bit;
      vdd : in      bit;
      vss : in      bit
 );
end component;

Component a4_x2
   port (
      i0  : in      bit;
      i1  : in      bit;
      i2  : in      bit;
      i3  : in      bit;
      q   : out     bit;
      vdd : in      bit;
      vss : in      bit
 );
end component;

Component no3_x1
   port (
      i0  : in      bit;
      i1  : in      bit;
      i2  : in      bit;
      nq  : out     bit;
      vdd : in      bit;
      vss : in      bit
 );
end component;

Component noa22_x1
   port (
      i0  : in      bit;
      i1  : in      bit;
      i2  : in      bit;
      nq  : out     bit;
      vdd : in      bit;
      vss : in      bit
 );
end component;

Component nao22_x1
   port (
      i0  : in      bit;
      i1  : in      bit;
      i2  : in      bit;
      nq  : out     bit;
      vdd : in      bit;
      vss : in      bit
 );
end component;

Component o2_x2
   port (
      i0  : in      bit;
      i1  : in      bit;
      q   : out     bit;
      vdd : in      bit;
      vss : in      bit
 );
end component;

Component nao2o22_x1
   port (
      i0  : in      bit;
      i1  : in      bit;
      i2  : in      bit;
      i3  : in      bit;
      nq  : out     bit;
      vdd : in      bit;
      vss : in      bit
 );
end component;

Component oa22_x2
   port (
      i0  : in      bit;
      i1  : in      bit;
      i2  : in      bit;
      q   : out     bit;
      vdd : in      bit;
      vss : in      bit
 );
end component;

Component sff1_x4
   port (
      ck  : in      bit;
      i   : in      bit;
      q   : out     bit;
      vdd : in      bit;
      vss : in      bit
 );
end component;

Component no2_x1
   port (
      i0  : in      bit;
      i1  : in      bit;
      nq  : out     bit;
      vdd : in      bit;
      vss : in      bit
 );
end component;

Component buf_x2
   port (
      i   : in      bit;
      q   : out     bit;
      vdd : in      bit;
      vss : in      bit
 );
end component;

signal dac_cst             : bit_vector( 2 downto 0);
signal mbk_buf_dac_cst     : bit_vector( 0 downto 0);
signal mbk_buf_not_dac_cst : bit_vector( 0 downto 0);
signal not_code            : bit_vector( 3 downto 0);
signal not_dac_cst         : bit_vector( 1 downto 0);
signal oa22_x2_sig         : bit;
signal oa22_x2_2_sig       : bit;
signal o2_x2_sig           : bit;
signal not_reset           : bit;
signal not_aux4            : bit;
signal not_aux3            : bit;
signal not_aux2            : bit;
signal noa22_x1_sig        : bit;
signal no4_x1_sig          : bit;
signal no3_x1_sig          : bit;
signal no3_x1_4_sig        : bit;
signal no3_x1_3_sig        : bit;
signal no3_x1_2_sig        : bit;
signal no2_x1_sig          : bit;
signal no2_x1_2_sig        : bit;
signal nao2o22_x1_sig      : bit;
signal nao22_x1_sig        : bit;
signal na3_x1_sig          : bit;
signal na3_x1_2_sig        : bit;
signal na2_x1_sig          : bit;
signal inv_x2_sig          : bit;
signal inv_x2_2_sig        : bit;
signal aux6                : bit;
signal aux0                : bit;
signal a4_x2_sig           : bit;
signal a2_x2_sig           : bit;
signal a2_x2_2_sig         : bit;

begin

not_aux2_ins : o3_x2
   port map (
      i0  => not_code(2),
      i1  => dac_cst(2),
      i2  => not_dac_cst(0),
      q   => not_aux2,
      vdd => vdd,
      vss => vss
   );

not_aux3_ins : na2_x1
   port map (
      i0  => not_code(2),
      i1  => dac_cst(2),
      nq  => not_aux3,
      vdd => vdd,
      vss => vss
   );

not_aux4_ins : o2_x2
   port map (
      i0  => dac_cst(1),
      i1  => dac_cst(2),
      q   => not_aux4,
      vdd => vdd,
      vss => vss
   );

not_dac_cst_1_ins : inv_x2
   port map (
      i   => dac_cst(1),
      nq  => not_dac_cst(1),
      vdd => vdd,
      vss => vss
   );

not_dac_cst_0_ins : inv_x4
   port map (
      i   => dac_cst(0),
      nq  => not_dac_cst(0),
      vdd => vdd,
      vss => vss
   );

not_reset_ins : inv_x2
   port map (
      i   => reset,
      nq  => not_reset,
      vdd => vdd,
      vss => vss
   );

not_code_3_ins : inv_x2
   port map (
      i   => code(3),
      nq  => not_code(3),
      vdd => vdd,
      vss => vss
   );

not_code_2_ins : inv_x2
   port map (
      i   => code(2),
      nq  => not_code(2),
      vdd => vdd,
      vss => vss
   );

not_code_1_ins : inv_x2
   port map (
      i   => code(1),
      nq  => not_code(1),
      vdd => vdd,
      vss => vss
   );

not_code_0_ins : inv_x2
   port map (
      i   => code(0),
      nq  => not_code(0),
      vdd => vdd,
      vss => vss
   );

no2_x1_ins : no2_x1
   port map (
      i0  => code(0),
      i1  => code(3),
      nq  => no2_x1_sig,
      vdd => vdd,
      vss => vss
   );

aux6_ins : a2_x2
   port map (
      i0  => no2_x1_sig,
      i1  => dac_cst(1),
      q   => aux6,
      vdd => vdd,
      vss => vss
   );

aux0_ins : no2_x1
   port map (
      i0  => not_aux4,
      i1  => mbk_buf_not_dac_cst(0),
      nq  => aux0,
      vdd => vdd,
      vss => vss
   );

a2_x2_ins : a2_x2
   port map (
      i0  => not_aux3,
      i1  => not_aux2,
      q   => a2_x2_sig,
      vdd => vdd,
      vss => vss
   );

inv_x2_ins : inv_x2
   port map (
      i   => aux6,
      nq  => inv_x2_sig,
      vdd => vdd,
      vss => vss
   );

no3_x1_2_ins : no3_x1
   port map (
      i0  => not_code(1),
      i1  => inv_x2_sig,
      i2  => a2_x2_sig,
      nq  => no3_x1_2_sig,
      vdd => vdd,
      vss => vss
   );

no3_x1_ins : no3_x1
   port map (
      i0  => reset,
      i1  => no3_x1_2_sig,
      i2  => aux0,
      nq  => no3_x1_sig,
      vdd => vdd,
      vss => vss
   );

oa22_x2_ins : oa22_x2
   port map (
      i0  => mbk_buf_not_dac_cst(0),
      i1  => dac_cst(2),
      i2  => code(3),
      q   => oa22_x2_sig,
      vdd => vdd,
      vss => vss
   );

inv_x2_2_ins : inv_x2
   port map (
      i   => dac_cst(2),
      nq  => inv_x2_2_sig,
      vdd => vdd,
      vss => vss
   );

a2_x2_2_ins : a2_x2
   port map (
      i0  => daytime,
      i1  => code(3),
      q   => a2_x2_2_sig,
      vdd => vdd,
      vss => vss
   );

na3_x1_2_ins : na3_x1
   port map (
      i0  => a2_x2_2_sig,
      i1  => inv_x2_2_sig,
      i2  => not_dac_cst(1),
      nq  => na3_x1_2_sig,
      vdd => vdd,
      vss => vss
   );

no2_x1_2_ins : no2_x1
   port map (
      i0  => daytime,
      i1  => not_code(3),
      nq  => no2_x1_2_sig,
      vdd => vdd,
      vss => vss
   );

no4_x1_ins : no4_x1
   port map (
      i0  => not_code(2),
      i1  => code(1),
      i2  => no2_x1_2_sig,
      i3  => not_code(0),
      nq  => no4_x1_sig,
      vdd => vdd,
      vss => vss
   );

na3_x1_ins : na3_x1
   port map (
      i0  => no4_x1_sig,
      i1  => na3_x1_2_sig,
      i2  => oa22_x2_sig,
      nq  => na3_x1_sig,
      vdd => vdd,
      vss => vss
   );

na2_x1_ins : na2_x1
   port map (
      i0  => na3_x1_sig,
      i1  => no3_x1_sig,
      nq  => na2_x1_sig,
      vdd => vdd,
      vss => vss
   );

dac_cst_0_ins : sff1_x4
   port map (
      ck  => clk,
      i   => na2_x1_sig,
      q   => dac_cst(0),
      vdd => vdd,
      vss => vss
   );

no3_x1_3_ins : no3_x1
   port map (
      i0  => not_code(1),
      i1  => not_code(3),
      i2  => code(2),
      nq  => no3_x1_3_sig,
      vdd => vdd,
      vss => vss
   );

a4_x2_ins : a4_x2
   port map (
      i0  => not_dac_cst(1),
      i1  => no3_x1_3_sig,
      i2  => dac_cst(2),
      i3  => mbk_buf_dac_cst(0),
      q   => a4_x2_sig,
      vdd => vdd,
      vss => vss
   );

no3_x1_4_ins : no3_x1
   port map (
      i0  => not_code(1),
      i1  => not_aux3,
      i2  => code(3),
      nq  => no3_x1_4_sig,
      vdd => vdd,
      vss => vss
   );

noa22_x1_ins : noa22_x1
   port map (
      i0  => dac_cst(1),
      i1  => no3_x1_4_sig,
      i2  => a4_x2_sig,
      nq  => noa22_x1_sig,
      vdd => vdd,
      vss => vss
   );

nao22_x1_ins : nao22_x1
   port map (
      i0  => code(0),
      i1  => noa22_x1_sig,
      i2  => not_reset,
      nq  => nao22_x1_sig,
      vdd => vdd,
      vss => vss
   );

dac_cst_1_ins : sff1_x4
   port map (
      ck  => clk,
      i   => nao22_x1_sig,
      q   => dac_cst(1),
      vdd => vdd,
      vss => vss
   );

o2_x2_ins : o2_x2
   port map (
      i0  => code(1),
      i1  => code(2),
      q   => o2_x2_sig,
      vdd => vdd,
      vss => vss
   );

nao2o22_x1_ins : nao2o22_x1
   port map (
      i0  => o2_x2_sig,
      i1  => mbk_buf_dac_cst(0),
      i2  => not_aux2,
      i3  => not_code(1),
      nq  => nao2o22_x1_sig,
      vdd => vdd,
      vss => vss
   );

oa22_x2_2_ins : oa22_x2
   port map (
      i0  => aux6,
      i1  => nao2o22_x1_sig,
      i2  => reset,
      q   => oa22_x2_2_sig,
      vdd => vdd,
      vss => vss
   );

dac_cst_2_ins : sff1_x4
   port map (
      ck  => clk,
      i   => oa22_x2_2_sig,
      q   => dac_cst(2),
      vdd => vdd,
      vss => vss
   );

alarm_ins : no2_x1
   port map (
      i0  => not_aux4,
      i1  => mbk_buf_dac_cst(0),
      nq  => alarm,
      vdd => vdd,
      vss => vss
   );

door_ins : buf_x2
   port map (
      i   => aux0,
      q   => door,
      vdd => vdd,
      vss => vss
   );

mbk_buf_dac_cst_0 : buf_x2
   port map (
      i   => dac_cst(0),
      q   => mbk_buf_dac_cst(0),
      vdd => vdd,
      vss => vss
   );

mbk_buf_not_dac_cst_0 : buf_x2
   port map (
      i   => not_dac_cst(0),
      q   => mbk_buf_not_dac_cst(0),
      vdd => vdd,
      vss => vss
   );


end structural;
