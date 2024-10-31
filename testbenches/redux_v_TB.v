module redux_v_TB ();
    reg clk, reset;

    redux_v DUT(.clock(clk), .reset(reset));

    initial begin
        $dumpfile("./redux_v_TB.vcd");
        $dumpvars(2, DUT);
        $readmemh("./memory_files/teste_instrucoes.mem", DUT.ci.rom, 0, 23);
        $readmemh("./memory_files/decoder_rom.mem", DUT.decod.rom, 0, 15);
    end

    always #5 clk = ~clk;

    integer contador_ciclos, i;
    initial begin
        reset = 1'b1;
        clk = 1'b0;
        #1; clk = 1'b1;
        #1 reset = 1'b0;

        contador_ciclos = 0;
        while (DUT.instrucao != 8'H10) begin
            @(posedge clk);
            contador_ciclos = contador_ciclos + 1;
        end

        $display("Testbench finalizado apos %d ciclos", contador_ciclos[7:0]);

        $display("Estado final do banco de registradores:");
        for (i = 0; i < 4; i = i + 1)
            $display("R[%d] = %d", i[1:0], DUT.regs.bank[i]);
        $display("Estado final da memória de dados:");
        for (i = 0; i < 255; i = i + 1)
            $display("MEM[%d] = %d", i[7:0], DUT.ram.ram[i]);

        $finish();
    end
endmodule