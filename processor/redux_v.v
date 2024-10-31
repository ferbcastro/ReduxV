module redux_v (input clock, input reset);
    wire [7:0] saida_rb, saida_ra, imm_com_sinal, imm_sem_sinal, atual_pc, novo_pc;
    wire [7:0] saida_ram, saida_alu;
    wire [1:0] rb, ra;
    wire [3:0] opcode;
    wire [7:0] instrucao;
    // Sinais de controle
    wire [3:0] fonte_alu;
    wire [2:0] fonte_pc;
    wire escreve_reg, escreve_ram, fonte_reg, usa_imediato, zero;

    contador_de_programa pc(.next_pc(novo_pc), 
                            .clk(clock),
                            .r(reset),
                            .curr_pc(atual_pc));
    
    next_pc proximo_pc(.pcsrc(fonte_pc), 
                       .brzr_pc(saida_rb),
                       .brzi_pc(atual_pc + imm_sem_sinal), 
                       .ji_pc(atual_pc + imm_com_sinal),
                       .std_pc(atual_pc + 8'H1),
                       .zero(zero), 
                       .new_pc(novo_pc));
    
    memoria_instrucoes ci(.position(atual_pc),
                          .instruction(instrucao));
    
    banco_registradores regs(.dado(fonte_reg == 1'b1 ? saida_ram : saida_alu),
                             .ra(usa_imediato == 1'b0 ? ra : 2'b0),
                             .rb(rb),
                             .clk(clock),
                             .r(reset),
                             .rw(escreve_reg),
                             .s_ra(saida_ra),
                             .s_rb(saida_rb));
    
    ula alu(.s_ra(saida_ra),
            .s_rb(usa_imediato ? (imm_com_sinal) : (saida_rb)),
            .op(fonte_alu),
            .s(saida_alu),
            .zero(zero));
    
    decoder decod(.opcode(opcode),
                  .ulasrc(fonte_alu),
                  .pcsrc(fonte_pc),
                  .imm(usa_imediato),
                  .regsrc(fonte_reg),
                  .mw(escreve_ram),
                  .rw(escreve_reg));

    memoria_dados ram(.position(saida_rb),
                      .data_in(saida_ra),
                      .clk(clock),
                      .r(reset),
                      .mw(escreve_ram),
                      .data_out(saida_ram));

    assign ra = instrucao[3:2];
    assign rb = instrucao[1:0];
    assign opcode = instrucao[7:4];
    assign imm_com_sinal = {{4{ra[1]}}, ra, rb};
    assign imm_sem_sinal = {4'b0, ra, rb};
endmodule