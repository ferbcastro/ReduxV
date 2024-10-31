module ula_TB ();
    reg[7:0] ra, rb;
    reg[3:0] op;
    wire[7:0] out;
    wire zero;

    ula DUT(.s_ra(ra), .s_rb(rb), .op(op), .s(out), .zero(zero));

    initial begin
        $dumpfile("ula_TB.vcd");
        $dumpvars(0, ula_TB);
        $monitor("Zero <= %d", zero);
    end

    initial begin
        ra = 8'h0;
        rb = 8'hFF;
        op = 4'b0000;
        #1
        $display(" ~%d     <= %d", rb, out);
        #4 
        
        op = 4'b0001;
        #1
        $display("%d & %d <= %d", ra, rb, out);
        #4

        op = 4'b0010;
        #1
        $display("%d | %d <= %d", ra, rb, out);
        #4

        op = 4'b0011;
        #1
        $display("%d ^ %d <= %d", ra, rb, out);
        #4

        op = 4'b0100;
        ra = 8'hA;
        #1
        $display("%d + %d   <= %d", $signed(rb), ra[3:0], out);
        #4

        op = 4'b1100;
        #1
        $display("%d + 1    <= %d", $signed(rb), out);
        #4

        op = 4'b0101;
        #1
        $display(" %d - (-1) <= %d", ra, out);
        #4

        op = 4'b0110;
        #1
        $display(" %d << %d <= %d", ra, rb, out);
        #4

        rb = 8'H1;
        #1
        $display(" %d << %d <= %d", ra, rb, out);
        #4

        // Shift Left Four
        op = 4'b1110;
        #1
        $display(" %d <<   4 <= %d", rb, out);
        #4

        op = 4'b0111;
        #1
        $display(" %d >> %d <= %d", ra, rb, out);
        #4

        op = 4'b0111;
        rb = 8'Hff;
        #1
        $display(" %d >> %d <= %d", ra, rb, out);
        #4

        $finish();
    end


endmodule