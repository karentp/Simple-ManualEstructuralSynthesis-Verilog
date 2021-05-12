//++++++++++MODULO PROBADOR PARA MUX CON MEMORIA: GENERADOR DE SEÑALES Y MONITOR DE DATOS +++++++++++++++

`timescale 	1ns	/ 100ps
// escala	unidad temporal (valor de "#1") / precisi�n

// includes de archivos de verilog

`include "mux_memoria_estructural.v"
`include "mux_memoria.v"
`include "probador_estructural.v"
//`include "checker.v"


 // Testbench
module BancoPruebasEstructural;
	
    wire clk, selector, reset_L, checker;
	wire [1:0] data_in0, data_in1, data_out_conductual, data_out_estructural;

	// Descripcion conductual del MUX con memoria
	mux_memoria	mux_conductual( .clk(clk), .selector(selector), .reset_L(reset_L), 
                             .data_in0(data_in0), .data_in1(data_in1), .data_out(data_out_conductual) );

	// Descripcion conductual del MUX con memoria
	mux_memoria_estructural	mux_estructural( .clk(clk), .selector(selector), .reset_L(reset_L), 
                             .data_in0(data_in0), .data_in1(data_in1), .data_out(data_out_estructural) );


	// Probador: generador de señales y monitor
	probador_estructural 	prob( .clk(clk), .selector(selector), .reset_L(reset_L), 
                     .data_in0(data_in0), .data_in1(data_in1), .data_out_conductual(data_out_conductual),
					.data_out_estructural(data_out_estructural));

	

endmodule