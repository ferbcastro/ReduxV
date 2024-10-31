module next_pc (input wire[2:0] pcsrc, input wire[7:0] brzr_pc, brzi_pc, ji_pc, std_pc,
                input zero, output wire[7:0] new_pc);
    wire[2:0] pcsrc_mod;

    parameter BRZR = 3'b000,
              BRZI = 3'b100,
              JI = 3'b101,
              NO_JMP = 3'b110;

    assign pcsrc_mod = (((pcsrc == BRZR) || (pcsrc == BRZI)) && zero == 1'b0) ? NO_JMP : pcsrc;
    assign new_pc = (pcsrc_mod == BRZR) ? brzr_pc :
                    (pcsrc_mod == JI)   ? ji_pc :
                    (pcsrc_mod == BRZI) ? brzi_pc : std_pc;
endmodule