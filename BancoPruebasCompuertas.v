//++++++++++MODULO PROBADOR PARA AND, OR, NOT, FLIP FLOP, MUX 2X1 DE 1 BIT, MUX 2X1 DE 2 BITS +++++++++++++++

// escala	unidad temporal (valor de "#1") / precisi�n
`timescale 	1ns	/ 100ps

// includes de archivos de verilog
 
`include "libreria_componentes.v"
`include "probador_compuertas.v"


 // Testbench
module BancoPruebasCompuertas;

    // +++++++++++++++++++++++++Prueba para AND +++++++++++++++++++++++++++++++++++

    wire A, B, outand;

    // Descripcion conductual del AND
    and_lib andbanco(.A(A), .B(B), .out(outand));

    wire  outor;

    // Descripcion conductual del OR
    or_lib orbanco(.A(A), .B(B), .out(outor));

     wire  outnot;

    // Descripcion conductual del NOT
    not_lib notbanco(.A(A),.out(outnot));


    probador_compuertas prob_comp(.A(A), .B(B), .out_and(outand), .out_or(outor), .out_not(outnot));


endmodule