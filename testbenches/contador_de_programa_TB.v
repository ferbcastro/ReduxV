module contador_de_programa_TB ();
    reg Clk;
    wire [7:0] pc_novo, pc_atual;

    contador_de_programa DUT (.next_pc(pc_novo), .clk(Clk), .curr_pc(pc_atual));

    initial begin
        $dumpfile("contador_de_programa.vcd");
        $dumpvars(0, contador_de_programa_TB);
        $monitor("PC = %d", pc_atual[3:0]);
    end

    assign pc_novo = pc_atual + 8'H4;

    initial begin
        Clk = 1'b0;
        DUT.curr_pc = 8'b0; #5
        Clk = 1'b1; #5;
        Clk = 1'b0; #5;
        Clk = 1'b1; #5;
        Clk = 1'b0; #5;
        Clk = 1'b1; #5;
    end
endmodule