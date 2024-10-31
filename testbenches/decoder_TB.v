module decoder_TB ();
    parameter SIZE = 16;
    reg[3:0] Opcode;
    wire[3:0] Ulasrc;
    wire[2:0] Pcsrc;
    wire Imm, Regsrc, Mw, Rw;

    decoder DUT (.opcode(Opcode), .ulasrc(Ulasrc), .pcsrc(Pcsrc), .imm(Imm),
                .regsrc(Regsrc), .mw(Mw), .rw(Rw));
    
    initial begin
        $dumpfile("decoder.vcd");
        $dumpvars(0, decoder_TB);
        $readmemh("./decoder_rom.mem", DUT.rom, 0, SIZE - 1);
    end

    integer i;
    initial begin
        Opcode = 4'b0;
        for (i = 0; i < SIZE; i = i + 1) begin
            #1; $display("Op = %b/Ula = %b/Pcsrc = %b/Imm = %b/Reg = %b/Mw = %b/Rw = %b",
                         Opcode, Ulasrc, Pcsrc, Imm, Regsrc, Mw, Rw);
            Opcode = Opcode + 1; 
        end

        $finish();
    end
endmodule