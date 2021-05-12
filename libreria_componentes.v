//******Módulo AND con los retardos********

`timescale 1ns/100ps

module and_lib #( parameter PwrC = 0) 
                ( 
                    input A,
                    input B,
                    output out);

// Retardos
        assign #(1:3:4, 1:3:4) out = A&B;

//assign #100 out = A&B;

endmodule

//******Módulo OR con los retardos********

module or_lib #( parameter PwrC = 0) 
                ( 
                    input A,
                    input B,
                    output out);

// Retardos
//assign #(1:2.75:4.5, 1:2.75:4.5) out = A | B;
 
        assign #(0:3.8:3.8, 1:3.8:3.8) out = A | B;


endmodule

//******Módulo NOT con los retardos********

module not_lib #( parameter PwrC = 0) 
                ( 
                    input A,
                    output wire out);

// Retardos

        assign #(1:1:1.7, 1:1:1.7) out = ~A;
    

endmodule

// ++++++++++ MODULO FLIP FLOP TIPO D de 1 bit+++++++++++++++

module flip_flop_lib #( parameter PwrC = 0) (
    input clk,
    input  D,
    output reg  Q );


     // Este es el bloque always para la lógica del Flip Flop con reset
    always @(posedge clk) begin
        #3.1 Q <= D;
    end

endmodule

//++++++++++MODULO MULTIPLEXOR 2 X 1  de 1 bit+++++++++++++++

module mux_2x1_1bit(
    input selector,
    input in_0,
    input in_1,
    output wire data_out
);

    // Estos son los wire para comunicar la lógica
    wire notSelector;
    wire firstAnd;
    wire secondAnd;

    // A continuación se realiza la siguiente expresión con las 
    // compuertas de la librería: ~selector & in_0 | selector & in_1; 
    not_lib notS(.A(selector), .out(notSelector));
    and_lib and1(.A(notSelector), .B(in_0), .out(firstAnd));
    and_lib and2(.A(selector), .B(in_1), .out(secondAnd));
    or_lib or1(.A(firstAnd), .B(secondAnd), .out(data_out));

endmodule

//++++++++++MODULO MULTIPLEXOR 2 X 1  de 2 bits+++++++++++++++

module mux_2x1_2bit(
    input selector,
    input [1:0]in_0,
    input [1:0]in_1,
    output wire [1:0]data_out
);

    // Hacemos el mux 2x1 de 1 bit a partir del mux 2x1 de 2 bits.

    mux_2x1_1bit muxEntrada0(.selector(selector), .in_0(in_0[0]), .in_1(in_1[0]), .data_out(data_out[0]));
    
    mux_2x1_1bit muxEntrada1(.selector(selector), .in_0(in_0[1]), .in_1(in_1[1]), .data_out(data_out[1]));


endmodule