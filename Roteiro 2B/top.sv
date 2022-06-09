// Alfredo Vasconcelos de Andrade - Turma 1 - 120210139
// Roteiro 2B (Projeto de Circuitos Básicos - FPGA)

parameter divide_by=100000000;  // divisor do clock de referência
// A frequencia do clock de referencia é 50 MHz.
// A frequencia de clk_2 será de  50 MHz / divide_by

parameter NBITS_INSTR = 32;
parameter NBITS_TOP = 8, NREGS_TOP = 32, NBITS_LCD = 64;
module top(input  logic clk_2,
           input  logic [NBITS_TOP-1:0] SWI,
           output logic [NBITS_TOP-1:0] LED,
           output logic [NBITS_TOP-1:0] SEG,
           output logic [NBITS_LCD-1:0] lcd_a, lcd_b,
           output logic [NBITS_INSTR-1:0] lcd_instruction,
           output logic [NBITS_TOP-1:0] lcd_registrador [0:NREGS_TOP-1],
           output logic [NBITS_TOP-1:0] lcd_pc, lcd_SrcA, lcd_SrcB,
             lcd_ALUResult, lcd_Result, lcd_WriteData, lcd_ReadData, 
           output logic lcd_MemWrite, lcd_Branch, lcd_MemtoReg, lcd_RegWrite);
  
  // Declaração da variável usada como entrada
  logic [2:0] sistemaCofre; //sitema do cofre com os botões
  // atribuição das entradas
  always_comb sistemaCofre <= SWI[2:0];

  always_comb begin
    /* Problema 1 – Agência Bancária
    atribuição ao LED 1 o valor 0 ou 1 dependendo do resultado
    das operações condicionais quando for atribuido 1 é quando
    as condições de abertura da porta não foram atendidas
    */
    //LED[1] <= (SWI[0] & !SWI[1]) | (SWI[0] & SWI[2]); 
    if(sistemaCofre == 'b001) LED[1] <= 1;
    else if(sistemaCofre == 'b101) LED[1] <= 1;
    else if(sistemaCofre == 'b111) LED[1] <= 1;
    else LED[1] <= 0;

    /* Problema 2 - Estufa
    atribuição aos LED 6(Aquecedor) e 7(Resfriador) e ao
    segmento 7(LED vermelho) o resultado da operação entre
    os Switch 0, 1 que representam respectivamente os 
    sensores T1 e T2 
    */
    LED[6] <= !(SWI[6] | SWI[7]); //Aquecedor
    
    LED[7] <= SWI[6] & SWI[7]; //Resfriador

    SEG[7] <= !SWI[6] & SWI[7]; //LED Vermelho
  end

endmodule