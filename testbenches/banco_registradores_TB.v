module banco_registradores_TB ();
    reg[7:0] Dado;
    reg[1:0] Ra, Rb;
    reg Clk, Reset, We;
    wire[7:0] S_ra, S_rb;

    banco_registradores DUT (.dado(Dado), .ra(Ra), .rb(Rb), .clk(Clk), .rw(We), .s_ra(S_ra), .s_rb(S_rb));

    initial begin
        $dumpfile("banco_registradores.vcd");
        $dumpvars(0, banco_registradores_TB);
        $monitor ("ra = %d/Bank[ra] = %d", Ra, S_ra);
        $monitor ("rb = %d/Bank[rb] = %d", Rb, S_rb);
    end

    initial begin
        Ra = 2'b11;
        Rb = 2'b11;
        Dado = 8'H5;
        We = 1'b0;
        Clk = 1'b0; #1;
        Clk = 1'b1; #5;
        Clk = 1'b0; #5;

        Reset = 1'b0;
        We = 1'b1; #1
        Clk = 1'b1; #5;

        $finish();
    end

endmodule