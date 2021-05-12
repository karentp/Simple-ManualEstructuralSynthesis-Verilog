//++++++++++MODULO PROBADOR PARA MUX 2X1 DE 1 BIT y de 2 BIT +++++++++++++++

// escala	unidad temporal (valor de "#1") / precisi�n
`timescale 	1ns	/ 100ps

// includes de archivos de verilog

`include "libreria_componentes.v"
`include "probador_muxes_flop.v"


 // Testbench
module BancoPruebasMuxesFlop;

    // +++++++++++++++++++++++Prueba para MUX 2x1 1 bit+++++++++++++++++++++++
	
	wire selector, data_in0, data_in1, data_out;

    // Descripcion conductual del MUX 2x1 de 1 bit
    mux_2x1_1bit mux1bit(.in_0(data_in0), .selector(selector), .in_1(data_in1), .data_out(data_out));

    // +++++++++++++++++++++++Prueba para MUX 2x1 2 bits++++++++++++++++++++++
	
	wire selector_2;
    wire[1:0] data_in0_2, data_in1_2, data_out_2;

    // Descripcion conductual del MUX 2x1 de 2 bits
    mux_2x1_2bit mux2bit(.in_0(data_in0_2), .selector(selector_2), .in_1(data_in1_2), .data_out(data_out_2));

    // +++++++++++++++++++++++Prueba para FLIP FLOP++++++++++++++++++++++
    wire clk, reset_L;
	wire D, Q;

    // Descripcion conductual del FLIP FLOP
    flip_flop_lib flop(.D(D), .Q(Q), .clk(clk));


    probador_muxes_flop prob_mux_flop(.in_0(data_in0), .selector(selector), .in_1(data_in1), .data_out(data_out),.in_0_2(data_in0_2),
                             .selector_2(selector_2), .in_1_2(data_in1_2), .data_out_2(data_out_2), .D(D), .Q(Q), .clk(clk));


endmodule