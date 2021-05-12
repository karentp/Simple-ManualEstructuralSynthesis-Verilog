//++++++++++MODULO ESTRYCTURA MULTIPLEXOR 2 X 1 CON UN FLIP FLOP PARA GUARDAR EN MEMORIA EL ESTADO Y CON RESET +++++++++++++++

`include "libreria_componentes.v"

module mux_memoria_estructural(
    input clk,
    input reset_L,
    input selector,
    input [1:0] data_in0,
    input [1:0] data_in1,
    output [1:0] data_out
);

    // Primer MUX

    wire [1:0] data_out_mux1, data_out_mux2;;
    mux_2x1_2bit primer_mux(.selector(selector), .in_0(data_in0), .in_1(data_in1), .data_out(data_out_mux1));

    // MUX de Reset
    mux_2x1_2bit reset_mux(.selector(reset_L), .in_0(2'b00), .in_1(data_out_mux1), .data_out(data_out_mux2));

    // FLIP FLOP
    flip_flop_lib flop_entrada0(.clk(clk), .D(data_out_mux2[0]), .Q(data_out[0]));
    flip_flop_lib flop_entrada1(.clk(clk), .D(data_out_mux2[1]), .Q(data_out[1]));

    //flip_flop_lib_2bit flop_entrada(.clk(clk), .D(data_out_mux2), .Q(data_out));


endmodule