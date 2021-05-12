CONDUCTUAL = mux_memoria.v
BANCO  = BancoPruebaEstructural.v
BANCOMP  = BancoPruebasCompuertas.v
BANCFLOP = BancoPruebasMuxesFlop.v
PROBESCT = probador_estructural.v
PROBCOMP= probador_compuertas.v
PROBMUXFLOP = probador_muxes_flop.v
DUMPFILE = mux_memoria_estructural.vcd
LIB = libreria_componentes.v


all: compuertas muxesflop estructural gtkwave

compuertas: 
	@echo ----------------------------------
	@echo Corriendo Pruebas de Compuertas de Libreria en Icarus Verilog: 
	@echo ----------------------------------
	iverilog $(LIB)
	iverilog -o compuertas.vvp $(BANCOMP)
	vvp compuertas.vvp

muxesflop:
	@echo ----------------------------------
	@echo Corriendo Pruebas de Muxes y Flip Flop de la libreria : 
	@echo ----------------------------------
	iverilog -o muxesflop.vvp $(BANCFLOP)
	vvp muxesflop.vvp

estructural:
	@echo ----------------------------------
	@echo Corriendo Todo el circuito Estructural:
	@echo ----------------------------------
	iverilog -o mux_memoria_estructural.vvp $(BANCO)
	vvp mux_memoria_estructural.vvp

gtkwave: $(DUMPFILE)
	@echo ----------------------------------
	@echo Gtkwave:
	gtkwave $(DUMPFILE)

	

	
