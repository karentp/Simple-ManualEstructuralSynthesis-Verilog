//++++++++++MODULO MULTIPLEXOR 2 X 1 CON UN FLIP FLOP PARA GUARDAR EN MEMORIA EL ESTADO Y CON RESET +++++++++++++++

module mux_memoria(
    input clk,
    input reset_L,
    input selector,
    input [1:0] data_in0,
    input [1:0] data_in1,
    output reg [1:0] data_out
);
    // Este es un wire temporal que pasará los registros del MUX al Flip Flop
    reg [1:0] temporal_output;

    // Este es el bloque always para la lógica del MUX 2x1
    always @(*) begin
        if (selector)
            temporal_output = data_in1;
        else
            temporal_output = data_in0;

    end

    // Este es el bloque always para la lógica del Flip Flop con reset

    always @(posedge clk) begin
        if (reset_L)
            data_out <= temporal_output;
        else
            data_out <= 2'b00;
    end

endmodule