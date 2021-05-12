//++++++++++MODULO PROBADOR PARA LA LIBRERIA DE COMPONENTES: GENERADOR DE SEÑALES Y MONITOR DE DATOS +++++++++++++++

module probador_compuertas( 
    
    input  out_and,
    input  out_or,
    input out_not,
    output reg A,
    output reg B

    );

    reg 		clk;

	// Bloque de procedimiento, no sintetizable, se recorre una unica vez

	initial begin
        // Nombre de archivo del "dump"
		$dumpfile("lib_componentes.vcd");

        // Directiva para "dumpear" variables	
		$dumpvars;		
    
		// Mensaje que se imprime en consola una vez

        $display ("\t\t\tPrueba para componentes de la librería");
		$display ("\t\ttiempo\t\tA\tB\tOut_And\tOut_Or\tOut_Not");

		// Mensaje que se imprime en consola cada vez que un elemento de la lista cambia
		$monitor($time,"\t\t%b\t%b\t%b\t%b\t%b", A, B, out_and, out_or, out_not);

        // Asignamos valores 
		A = 1'b0; 
        B = 1'b0;
        
        // Repite 5 veces
		repeat (5) begin
            @(posedge clk);	
            // Suma 1 a cada entrada
            {A, B} <= {A, B} + 1; 
		end


        @(posedge clk);	

        // Asigna un tipo bit con valor 0
        A <= 1'b0; 
        B <= 1'b0;

        // Termina de almacenar señales
		$finish;

	end

    // Reloj
	initial	clk 	<= 0;			// Valor inicial al reloj, sino siempre ser� indeterminado
	always	#5 clk 	<= ~clk;		// Hace "toggle" cada 2*10ns
    		
endmodule