//++++++++++MODULO PROBADOR PARA MUX CON MEMORIA: GENERADOR DE SEÑALES Y MONITOR DE DATOS +++++++++++++++

module probador_estructural( 
    
    input  [1:0] data_out_conductual,
    input  [1:0] data_out_estructural,

    output reg clk,
    output reg reset_L,
    output reg selector,
    output reg [1:0] data_in0,
    output reg [1:0] data_in1
    
    );

	// Bloque de procedimiento, no sintetizable, se recorre una unica vez
    reg check;

    reg [3:0] counter_conductual  = 4'b0000;
    reg [3:0]  counter_estructural = 4'b0000;
    reg ready, ready_est = 1'b0;
    reg counter_switch, counter_switch_est;

	initial begin
        // Nombre de archivo del "dump"
		$dumpfile("mux_memoria_estructural.vcd");

        // Directiva para "dumpear" variables	
		$dumpvars;		
	
		// Mensaje que se imprime en consola una vez
		$display ("\t\ttiempo\t\tclk,\tselector,\treset_L,\tdata_in0,\tdata_in1,\tdata_out\tchecker\t\tcontador conductual\t contador estructural");

		// Mensaje que se imprime en consola cada vez que un elemento de la lista cambia
		$monitor($time,"\t\t%b\t%b\t\t%b\t\t%b\t\t%b\t\t%b\t\t%b\t\t\t%b\t\t\t%b", clk, selector, reset_L, data_in0, data_in1, data_out_estructural, check
                , counter_conductual, counter_conductual);

        // Asignamos valores
		{data_in0} = 2'b00; 
        {data_in1} = 2'b00;
        {selector} = 1'b0;
        {reset_L} = 1'b0;
        
        // Repite 8 veces
		repeat (12) begin

            // Espera/sincroniza con el flanco positivo del reloj	
            @(posedge clk);	

            // Suma 1 a cada entrada
            {data_in0, data_in1} <= {data_in0, data_in1} + 1; 
            { selector, reset_L} <= {selector, reset_L} +1;

		end

		@(posedge clk);

        // Asigna un tipo bit con valor 0
        {data_in0} <= 2'b00; 
        {data_in1} <= 2'b00;
        {selector} <= 1'b0;
        {reset_L} <= 1'b0;

        // Termina de almacenar señales
		$finish;

    end 

    // Checker

    always  @(posedge clk)begin
        if ( data_out_conductual == data_out_estructural)
            check <=1;
        else
            check <=0;
    end

    // Contador de cada salida. Suma 1 cada vez que un bit de la salida cambia de 0 a 1
    // Si la salida cambia de 00 a 11 cuenta 2.

    always@(posedge clk) begin
        if (data_out_conductual[0] | data_out_conductual[1] ) begin 
            counter_switch <= 1;
        end else if (ready) begin
            counter_switch <= 0;
        end 

        if (data_out_estructural[0] | data_out_estructural[1] ) begin 
            counter_switch_est <= 1;
        end else if (ready_est) begin
            counter_switch_est <= 0;
        end 
         
    end

    always@(posedge clk) begin
            if (counter_switch)
                counter_conductual <= counter_conductual +1;
                if (data_out_conductual == 2'b11)
                    counter_conductual <= counter_conductual +1;
            else
                ready <= 0;  

            if (counter_switch_est)
                counter_estructural <= counter_estructural +1;
                if (data_out_estructural == 2'b11)
                    counter_estructural <= counter_estructural +1;
            else
                ready_est <= 0;   
    end


    //reg signnal = signal_changed_at_clock_edge;

	// Reloj

    //Valor inicial del reloj para que no sea indeterminado
	initial	clk 	<= 0;	

    //Toggle cada 2*10 nano segundos		
	always	#20 clk 	<= ~clk;
    		
endmodule
