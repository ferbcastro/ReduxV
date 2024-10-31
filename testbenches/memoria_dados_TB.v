module memoria_dados_TB ();
    reg[7:0] posicao, entrada;
    reg Clk, Mw;
    wire[7:0] saida;

    memoria_dados DUT (.position(posicao), .data_in(entrada), .clk(Clk), .mw(Mw), .data_out(saida));

    initial begin
        $dumpfile("memoria_dados.vcd");
        $dumpvars(0, memoria_dados_TB);
        $monitor("Saida RAM[%d] = %d", posicao, saida);
    end

    initial begin
        posicao = 8'Hff;
        entrada = 8'H9;
        Clk = 1'b0;
        Mw = 1'b0; #1;
        Clk = 1'b1; #5;
        Clk = 1'b0; #5;

        Mw = 1'b1; #1;
        Clk = 1'b1; #5;
        Clk = 1'b0; #5;
    end
endmodule