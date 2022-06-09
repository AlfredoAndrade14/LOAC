// Alfredo Vasconcelos de Andrade - Turma 1 - 120210139
// Roteiro 3 Questão 1

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
  logic [1:0] sensorAgua; //volume de água
  // atribuição das entradas
  always_comb sensorAgua <= SWI[1:0];

  // Letra A no led de 7 segmentos
  parameter LETRA_A = 'b01110111;
  
  // Letra n no led de 7 segmentos
  parameter LETRA_N = 'b01010100;
  
  // Letra b no led de 7 segmentos
  parameter LETRA_B = 'b01111100;
  
  // Letra d no led de 7 segmentos
  parameter LETRA_D = 'b01011110;
  
  always_comb begin
    /* Verifica a entrada dos switch e coloca 
    no led a saida esperada para a entrada
    */
    if(sensorAgua == 'b00) SEG <= LETRA_A;
    else if(sensorAgua == 'b01) SEG <= LETRA_N;
    else if(sensorAgua == 'b10) SEG <= LETRA_B;
    else SEG <= LETRA_D;
  end

endmodule