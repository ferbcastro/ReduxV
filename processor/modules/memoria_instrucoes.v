module memoria_instrucoes (input wire[7:0] position, output wire[7:0] instruction);
    parameter SIZE = 8'Hff;
    reg [7:0] rom [0:SIZE];

    assign instruction = rom[position];
endmodule