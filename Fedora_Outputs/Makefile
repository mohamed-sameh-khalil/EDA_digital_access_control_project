FILE=dac_j_scap

%.ap: %.vst
	MBK_IN_LO=vst MBK_OUT_PH=ap \
	ocp -v -ring -ioc pinorder $* $* > $*_ap.out

%.nero: %.ap
	MBK_IN_LO=vst MBK_OUT_PH=ap \
	nero -V $* $*_nero > $*_nero.out

%.lvx: %.nero
	MBK_OUT_LO=al \
	RDS_TECHNO_NAME=/home/alliance/project/phase3/techno/techno-035.rds \
	cougar -v $*_nero $*_cougar > $*_coug.out; \
	lvx vst al $* $*_cougar -f > $*_lvx.out

%.druc: %.nero
	RDS_TECHNO_NAME=/home/alliance/project/phase3/techno/techno-symb.rds \
	druc $*_nero > $*_druc.out

%.s2r: %.nero
	RDS_TECHNO_NAME=/home/alliance/project/phase3/techno/techno-035.rds \
	RDS_OUT=cif \
	s2r -v -r $*_nero > $*_s2r.out
all:
	make ${FILE}.s2r
	make ${FILE}.druc
	make ${FILE}.lvx

.SECONDARY:




	