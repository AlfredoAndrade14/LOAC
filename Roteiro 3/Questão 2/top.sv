// Alfredo Vasconcelos de Andrade - Turma 1 - 120210139
// Roteiro 3 Questão 2

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
  logic [1:0] informacaoA; //Informação A
  // atribuição das entradas
  always_comb informacaoA <= SWI[4:3];

  // Declaração da variável usada como entrada
  logic [1:0] informacaoB; //Informação B
  // atribuição das entradas
  always_comb informacaoB <= SWI[6:5];

  always_comb begin
  // Seletor de qual informação sera transmitida
  if(SWI[7] == 0) LED[7:6] <= SWI[4:3];
  else LED[7:6] <= SWI[6:5];

  end

endmodule