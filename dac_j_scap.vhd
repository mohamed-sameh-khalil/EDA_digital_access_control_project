LIBRARY sxlib_ModelSim;
entity dac_j_scap is
   port (
      clk     : in      bit;
      reset   : in      bit;
      daytime : in      bit;
      code    : in      bit_vector(3 downto 0);
      door    : out     bit;
      alarm   : out     bit;
      vss     : in      bit;
      vdd     : in      bit;
      scin    : in      bit;
      test    : in      bit;
      scout   : out     bit
 );
end dac_j_scap;

architecture structural of dac_j_scap is
Component a2_x2
   port (
      i0  : in      bit;
      i1  : in      bit;
      q   : out     bit;
      vdd : in      bit;
      vss : in      bit
 );
end component;

Component on12_x1
   port (
      i0  : in      bit;
      i1  : in      bit;
      q   : out     bit;
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

Component inv_x2
   port (
      i   : in      bit;
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

Component na4_x1
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

Component na2_x1
   port (
      i0  : in      bit;
      i1  : in      bit;
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

Component no2_x1
   port (
      i0  : in      bit;
      i1  : in      bit;
      nq  : out     bit;
      vdd : in      bit;
      vss : in      bit
 );
end component;

Component sff2_x4
   port (
      ck  : in      bit;
      cmd : in      bit;
      i0  : in      bit;
      i1  : in      bit;
      q   : out     bit;
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

signal dac_cst          : bit_vector( 2 downto 0);
signal not_code         : bit_vector( 3 downto 0);
signal not_dac_cst      : bit_vector( 2 downto 0);
signal oa22_x2_sig      : bit;
signal o2_x2_sig        : bit;
signal o2_x2_2_sig      : bit;
signal not_reset        : bit;
signal not_aux6         : bit;
signal not_aux4         : bit;
signal not_aux3         : bit;
signal not_aux2         : bit;
signal not_aux0         : bit;
signal noa22_x1_sig     : bit;
signal no4_x1_sig       : bit;
signal no4_x1_2_sig     : bit;
signal no3_x1_sig       : bit;
signal no3_x1_3_sig     : bit;
signal no3_x1_2_sig     : bit;
signal no2_x1_sig       : bit;
signal na4_x1_sig       : bit;
signal na4_x1_3_sig     : bit;
signal na4_x1_2_sig     : bit;
signal na3_x1_sig       : bit;
signal na3_x1_2_sig     : bit;
signal na2_x1_sig       : bit;
signal na2_x1_5_sig     : bit;
signal na2_x1_4_sig     : bit;
signal na2_x1_3_sig     : bit;
signal na2_x1_2_sig     : bit;
signal mbk_buf_not_aux2 : bit;
signal inv_x2_sig       : bit;
signal inv_x2_2_sig     : bit;
signal a2_x2_sig        : bit;

begin

a2_x2_ins : a2_x2
   port map (
      i0  => not_code(1),
      i1  => not_code(3),
      q   => a2_x2_sig,
      vdd => vdd,
      vss => vss
   );

not_aux6_ins : on12_x1
   port map (
      i0  => a2_x2_sig,
      i1  => dac_cst(0),
      q   => not_aux6,
      vdd => vdd,
      vss => vss
   );

not_dac_cst_0_ins : inv_x2
   port map (
      i   => dac_cst(0),
      nq  => not_dac_cst(0),
      vdd => vdd,
      vss => vss
   );

no2_x1_ins : no2_x1
   port map (
      i0  => not_aux4,
      i1  => not_aux2,
      nq  => no2_x1_sig,
      vdd => vdd,
      vss => vss
   );

not_aux3_ins : na2_x1
   port map (
      i0  => dac_cst(1),
      i1  => no2_x1_sig,
      nq  => not_aux3,
      vdd => vdd,
      vss => vss
   );

not_aux4_ins : o2_x2
   port map (
      i0  => code(3),
      i1  => not_code(1),
      q   => not_aux4,
      vdd => vdd,
      vss => vss
   );

o2_x2_ins : o2_x2
   port map (
      i0  => code(0),
      i1  => code(2),
      q   => o2_x2_sig,
      vdd => vdd,
      vss => vss
   );

not_aux2_ins : on12_x1
   port map (
      i0  => dac_cst(2),
      i1  => o2_x2_sig,
      q   => not_aux2,
      vdd => vdd,
      vss => vss
   );

not_aux0_ins : o2_x2
   port map (
      i0  => dac_cst(2),
      i1  => dac_cst(1),
      q   => not_aux0,
      vdd => vdd,
      vss => vss
   );

not_dac_cst_2_ins : inv_x2
   port map (
      i   => dac_cst(2),
      nq  => not_dac_cst(2),
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

inv_x2_ins : inv_x2
   port map (
      i   => dac_cst(1),
      nq  => inv_x2_sig,
      vdd => vdd,
      vss => vss
   );

oa22_x2_ins : oa22_x2
   port map (
      i0  => code(2),
      i1  => not_code(0),
      i2  => inv_x2_sig,
      q   => oa22_x2_sig,
      vdd => vdd,
      vss => vss
   );

na2_x1_ins : na2_x1
   port map (
      i0  => not_aux4,
      i1  => dac_cst(1),
      nq  => na2_x1_sig,
      vdd => vdd,
      vss => vss
   );

na4_x1_ins : na4_x1
   port map (
      i0  => dac_cst(0),
      i1  => not_dac_cst(2),
      i2  => na2_x1_sig,
      i3  => oa22_x2_sig,
      nq  => na4_x1_sig,
      vdd => vdd,
      vss => vss
   );

na2_x1_2_ins : na2_x1
   port map (
      i0  => not_reset,
      i1  => not_aux3,
      nq  => na2_x1_2_sig,
      vdd => vdd,
      vss => vss
   );

no3_x1_ins : no3_x1
   port map (
      i0  => not_code(2),
      i1  => not_aux6,
      i2  => not_code(0),
      nq  => no3_x1_sig,
      vdd => vdd,
      vss => vss
   );

noa22_x1_ins : noa22_x1
   port map (
      i0  => dac_cst(2),
      i1  => no3_x1_sig,
      i2  => na2_x1_2_sig,
      nq  => noa22_x1_sig,
      vdd => vdd,
      vss => vss
   );

inv_x2_2_ins : inv_x2
   port map (
      i   => daytime,
      nq  => inv_x2_2_sig,
      vdd => vdd,
      vss => vss
   );

no3_x1_2_ins : no3_x1
   port map (
      i0  => not_code(3),
      i1  => inv_x2_2_sig,
      i2  => code(1),
      nq  => no3_x1_2_sig,
      vdd => vdd,
      vss => vss
   );

na4_x1_2_ins : na4_x1
   port map (
      i0  => code(2),
      i1  => code(0),
      i2  => not_aux0,
      i3  => no3_x1_2_sig,
      nq  => na4_x1_2_sig,
      vdd => vdd,
      vss => vss
   );

na3_x1_ins : na3_x1
   port map (
      i0  => noa22_x1_sig,
      i1  => na4_x1_2_sig,
      i2  => na4_x1_sig,
      nq  => na3_x1_sig,
      vdd => vdd,
      vss => vss
   );

na2_x1_3_ins : na2_x1
   port map (
      i0  => code(3),
      i1  => code(1),
      nq  => na2_x1_3_sig,
      vdd => vdd,
      vss => vss
   );

no4_x1_ins : no4_x1
   port map (
      i0  => na2_x1_3_sig,
      i1  => not_dac_cst(0),
      i2  => mbk_buf_not_aux2,
      i3  => dac_cst(1),
      nq  => no4_x1_sig,
      vdd => vdd,
      vss => vss
   );

na2_x1_4_ins : na2_x1
   port map (
      i0  => not_reset,
      i1  => not_aux3,
      nq  => na2_x1_4_sig,
      vdd => vdd,
      vss => vss
   );

o2_x2_2_ins : o2_x2
   port map (
      i0  => na2_x1_4_sig,
      i1  => no4_x1_sig,
      q   => o2_x2_2_sig,
      vdd => vdd,
      vss => vss
   );

no4_x1_2_ins : no4_x1
   port map (
      i0  => not_code(1),
      i1  => code(3),
      i2  => not_code(2),
      i3  => code(0),
      nq  => no4_x1_2_sig,
      vdd => vdd,
      vss => vss
   );

na4_x1_3_ins : na4_x1
   port map (
      i0  => dac_cst(0),
      i1  => no4_x1_2_sig,
      i2  => dac_cst(1),
      i3  => not_dac_cst(2),
      nq  => na4_x1_3_sig,
      vdd => vdd,
      vss => vss
   );

no3_x1_3_ins : no3_x1
   port map (
      i0  => code(0),
      i1  => not_aux6,
      i2  => code(2),
      nq  => no3_x1_3_sig,
      vdd => vdd,
      vss => vss
   );

na2_x1_5_ins : na2_x1
   port map (
      i0  => no3_x1_3_sig,
      i1  => dac_cst(1),
      nq  => na2_x1_5_sig,
      vdd => vdd,
      vss => vss
   );

na3_x1_2_ins : na3_x1
   port map (
      i0  => not_reset,
      i1  => na2_x1_5_sig,
      i2  => na4_x1_3_sig,
      nq  => na3_x1_2_sig,
      vdd => vdd,
      vss => vss
   );

alarm_ins : no2_x1
   port map (
      i0  => not_aux0,
      i1  => dac_cst(0),
      nq  => alarm,
      vdd => vdd,
      vss => vss
   );

door_ins : no2_x1
   port map (
      i0  => not_aux0,
      i1  => not_dac_cst(0),
      nq  => door,
      vdd => vdd,
      vss => vss
   );

mbk_buf_not_aux2_device : buf_x2 --I changed this name
   port map (
      i   => not_aux2,
      q   => mbk_buf_not_aux2,
      vdd => vdd,
      vss => vss
   );

dac_cst_0_ins_scan_0 : sff2_x4
   port map (
      ck  => clk,
      cmd => test,
      i0  => na3_x1_sig,
      i1  => scin,
      q   => dac_cst(0),
      vdd => vdd,
      vss => vss
   );

dac_cst_1_ins_scan_1 : sff2_x4
   port map (
      ck  => clk,
      cmd => test,
      i0  => o2_x2_2_sig,
      i1  => dac_cst(0),
      q   => dac_cst(1),
      vdd => vdd,
      vss => vss
   );

dac_cst_2_ins_scan_2 : sff2_x4
   port map (
      ck  => clk,
      cmd => test,
      i0  => na3_x1_2_sig,
      i1  => dac_cst(1),
      q   => dac_cst(2),
      vdd => vdd,
      vss => vss
   );

buf_scan_3 : buf_x2
   port map (
      i   => dac_cst(2),
      q   => scout,
      vdd => vdd,
      vss => vss
   );


end structural;
