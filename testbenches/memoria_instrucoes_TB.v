module memoria_instrucoes_TB ();
    parameter ALGORITMO_BASE = 35,
              FIBONACCI = 48;
    reg [7:0] posicao;
    wire [7:0] instrucao;

    memoria_instrucoes DUT (.position(posicao), .instruction(instrucao));

    integer i;
    initial begin
        $dumpfile("memoria_instrucoes.vcd");
        $dumpvars(0, memoria_instrucoes_TB);
        $readmemh ("./algoritmo_base.mem", DUT.rom, 0, ALGORITMO_BASE - 1);
    end

    initial begin
        posicao = 8'H00;
        for (i = 0; i < ALGORITMO_BASE; i = i + 1) begin
            #1; $display("Instrucao %d: %h", i[5:0], instrucao);
            posicao = posicao + 1;
        end
        
        $finish();
    end
endmodule