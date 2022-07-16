// Alfredo Vasconcelos de Andrade - Turma 1 - 120210139
// Roteiro 5 Questão 1

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
  logic reset, load, count_up, counter_on;
  
  // atribuição das variaveis aos switch's
  always_comb reset <= SWI[0];
  always_comb count_up <= SWI[1]; 
  always_comb Data_in <= SWI[7:4];
  always_comb load <= SWI[3];
  always_comb counter_on <= SWI[2];  

  //definição das representações do numeros no display
  parameter NUMERO_0 = 'b00111111;
  parameter NUMERO_1 = 'b00000110;
  parameter NUMERO_2 = 'b01011011;
  parameter NUMERO_3 = 'b01001111;
  parameter NUMERO_4 = 'b01100110;
  parameter NUMERO_5 = 'b01101101;
  parameter NUMERO_6 = 'b01111101;
  parameter NUMERO_7 = 'b00000111;
  parameter NUMERO_8 = 'b01111111;
  parameter NUMERO_9 = 'b01101111;
  parameter LETRA_A = 'b01110111;
  parameter LETRA_B = 'b01111100;
  parameter LETRA_C = 'b00111001;
  parameter LETRA_D = 'b01011110;
  parameter LETRA_E = 'b01111001;
  parameter LETRA_F = 'b01110001;
	
  always_ff @(posedge reset or posedge clk_2) begin
    //função do reset
    if(reset) Count <= 0;

    //atribuição do valor de entrada caso o load seja acionado
	  else if (load) Count <= Data_in;
	  
    //inicio da contagem
    else if (counter_on) begin
      //contagem crescente caso o switch 1 esteja acionado
      if(count_up)Count <= Count + 1;
      
      //contagem decrescente caso o switch 1 esteja deligado
      else Count <= Count -1;     		   
	  end
  end

  //atribuição do clock ao led 0
  always_comb LED[0] <= clk_2;    

  //atribuição de led para indicar contagem crescente o decrescente
  always_comb LED[1] <= count_up;  

  always_comb begin
    //atribuição da saida ao led
    LED[7:4] <= Count;
    //atribuição da saida no display
    if(Count == 0) SEG <= NUMERO_0;
    else if(Count == 1) SEG <= NUMERO_1;
    else if(Count == 2) SEG <= NUMERO_2;
    else if(Count == 3) SEG <= NUMERO_3;
    else if(Count == 4) SEG <= NUMERO_4;
    else if(Count == 5) SEG <= NUMERO_5;
    else if(Count == 6) SEG <= NUMERO_6;
    else if(Count == 7) SEG <= NUMERO_7;
    else if(Count == 8) SEG <= NUMERO_8;
    else if(Count == 9) SEG <= NUMERO_9;
    else if(Count == 10) SEG <= LETRA_A;
    else if(Count == 11) SEG <= LETRA_B;
    else if(Count == 12) SEG <= LETRA_C;
    else if(Count == 13) SEG <= LETRA_D;
    else if(Count == 14) SEG <= LETRA_E;
    else SEG <= LETRA_F;
  end
  
endmodule
