// Alfredo Vasconcelos de Andrade - Turma 1 - 120210139
// Roteiro 5 Questão 2

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
  
  //definição da quantidade de bits e variaveis
  parameter NBITS_COUNT = 4;
  logic [NBITS_COUNT-1:0] Data_in, Count;
  logic reset, load;
  
  // atribuição das variaveis aos switch's
  always_comb reset <= SWI[0];
  always_comb load <= SWI[3];
	
  //definição das representações do numeros no display
  parameter NUMERO_1 = 'b00000110;
  parameter NUMERO_2 = 'b01011011;
  parameter NUMERO_4 = 'b01100110;
  parameter NUMERO_8 = 'b01111111;

  always_ff @(posedge clk_2) begin
    //função do reset
    if(reset) Count <= 0;

	  //atribuição do valor inicial
    else if(load) Count <= 1;
	  
    //retorna ao valor inicial
    else if(Count[NBITS_COUNT-1]) Count <= 1;

	  else Count <= Count << 1; 
  end
  
  //atribuição do clock ao led 0
  always_comb LED[0] <= clk_2;      

  always_comb begin
    //atribuição da saida ao led
    LED[7:4] <= Count;
    //atribuição da saida no display
    if(Count == 1) SEG <= NUMERO_1;
    else if(Count == 2) SEG <= NUMERO_2;
    else if(Count == 4) SEG <= NUMERO_4;
    else if(Count == 8) SEG <= NUMERO_8;
    else SEG <= 0;
  end
  
endmodule
