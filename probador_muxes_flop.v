//++++++++++MODULO PROBADOR PARA MUX 2x1 de 2 bits: GENERADOR DE SEÑALES Y MONITOR DE DATOS +++++++++++++++

module probador_muxes_flop( 
    
    input  data_out,
    input  [1:0] data_out_2,
    input  Q,
    output reg clk,
    output reg D,
    output reg selector_2,
    output reg [1:0] in_0_2,
    output reg [1:0] in_1_2, 
    output reg selector,
    output reg  in_0,
    output reg  in_1 
    
    );
	// Bloque de procedimiento, no sintetizable, se recorre una unica vez

	initial begin
        // Nombre de archivo del "dump"
		$dumpfile("muxesflop.vcd");

        // Directiva para "dumpear" variables	
		$dumpvars;		
	
		// Mensaje que se imprime en consola una vez
        $display ("\t\t\t\tPrueba para MUX 2X1 de 1 bit, 2 bits y Flip Flop");
		$display ("\t\ttiempo,\tselector,\tdata_in_0,\tdata_in_1,\tdata_out\tselector2bits\tdata_in_0 2bits\tdata_in_1 2bits\tdata_outselector 2bits\tClk\tD\tQ");

		// Mensaje que se imprime en consola cada vez que un elemento de la lista cambia
		$monitor($time,"\t%b\t\t%b\t\t%b\t\t%b\t\t%b\t\t%b\t\t\t%b\t\t%b\t\t%b\t%b\t%b", selector, in_0, in_1, data_out, selector_2, in_0_2, in_1_2, data_out_2, clk, D, Q);

        // Asignamos valores 
		{in_0} = 1'b0; 
        {in_1} = 1'b0;
        {selector} = 1'b0;

         // Asignamos valores 
		{in_0_2} = 2'b00; 
        {in_1_2} = 2'b00;
        {selector_2} = 1'b0;

        D = 2'b0; 
        
        // Repite 8 veces
		repeat (8) begin
            @(posedge clk);	
            // Suma 1 a cada entrada
            {selector,in_0, in_1} <= {selector,in_0, in_1} + 1; 
            {in_0_2, in_1_2} <= {in_0_2, in_1_2} + 1; 
            selector_2 <= selector_2+1;

            D <= D + 1; 
		end
        @(posedge clk);	
        // Asigna un tipo bit con valor 0
        {in_0} <= 1'b0; 
        {in_1} <= 1'b0;
        {selector} <= 1'b0;

                // Asigna un tipo bit con valor 0
        {in_0_2} <= 2'b00; 
        {in_1_2} <= 2'b00;
        {selector_2} <= 1'b0;

        D <= 2'b0; 


        // Termina de almacenar señales
		$finish;

	end

    // Reloj
	initial	clk 	<= 0;			// Valor inicial al reloj, sino siempre ser� indeterminado
	always	#20 clk 	<= ~clk;		// Hace "toggle" cada 2*10ns
    		
endmodule
