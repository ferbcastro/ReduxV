module next_pc_TB ();
    reg zero;
    reg[2:0] pcsrc;
    reg[7:0] brzr_pc, brzi_pc, ji_pc, std_pc;
    wire[7:0] new_pc;

    parameter BRZR = 3'b000,
              BRZI = 3'b100,
              JI = 3'b101,
              NO_JMP = 3'b110;

    next_pc DUT(.pcsrc(pcsrc), .zero(zero), .brzr_pc(brzr_pc), .brzi_pc(brzi_pc), 
                .ji_pc(ji_pc), .std_pc(std_pc), .new_pc(new_pc));

    initial begin
        $dumpfile("next_pc_TB.vcd");
        $dumpvars(0, next_pc_TB);
        $monitor("pc <= %d", new_pc);
    end

    initial begin
        std_pc  = 8'd10;
        ji_pc   = 8'd11;
        brzi_pc = 8'd12;
        brzr_pc = 8'd13;
        
        // BRZR & zero = 0
        zero = 1'b0;
        pcsrc = BRZR;
        #5
        
        // BRZR & zero = 1
        zero = 1'b1;
        #5

        // BRZI & zero = 0
        zero = 1'b0;
        pcsrc = BRZI;
        #5

        // BRZI & zero = 1
        zero = 1'b1;
        #5
        
        // JI & zero = 0
        zero = 1'b0;
        pcsrc = JI;
        #5
        
        // JI & zero = 1
        zero = 1'b1;
        #5

        // NO_JMP & zero = 0
        zero = 1'b0; 
        pcsrc = NO_JMP;
        #5

        // NO_JMP & zero = 1
        zero = 1'b1;
        #5 $finish();
    end
endmodule