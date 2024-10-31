module decoder (input wire[3:0] opcode, output wire[3:0] ulasrc, output wire[2:0] pcsrc, output imm, regsrc, mw, rw);
    parameter SIZE = 4'Hf;
    reg [10:0] rom [0:SIZE];
    wire[10:0] aux;

    assign aux = rom[opcode];

    assign ulasrc = aux[10 -: 4]; 
    assign pcsrc = aux[6 -: 3];
    assign imm = aux[3];
    assign regsrc = aux[2]; 
    assign mw = aux[1];
    assign rw = aux[0];
endmodule