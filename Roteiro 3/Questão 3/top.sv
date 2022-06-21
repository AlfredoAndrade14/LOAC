// Alfredo Vasconcelos de Andrade - Turma 1 - 120210139
// Roteiro 3 Questão 3

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
  logic [2:0] valA; //Valor A
  // atribuição das entradas
  always_comb valA <= SWI[7:5];

  // Declaração da variável usada como entrada
  logic [2:0] valB; //Valor B
  // atribuição das entradas
  always_comb valB <= SWI[2:0];

  // Declaração da variável usada como entrada
  logic [1:0] seletor; //Seletor
  // atribuição das entradas
  always_comb seletor <= SWI[4:3];

  //definição das representações do numeros no display
  parameter NUMERO_0 = 'b00111111;
  parameter NUMERO_1 = 'b00000110;
  parameter NUMERO_2 = 'b01011011;
  parameter NUMERO_3 = 'b01001111;
  parameter NUMERO_n1 = 'b10000110;
  parameter NUMERO_n2 = 'b11011011;
  parameter NUMERO_n3 = 'b11001111;
  parameter NUMERO_n4 = 'b11100110;
  logic [2:0] resultado;
  
  always_comb begin
    LED[7:0] <= 'b00000000;
    SEG[7:0] <= 'b00000000;

    /*Seletor da operação AND realiza a operação
      e atribui ao led o resultado da operação
    */
    if(seletor == 'b00) begin
      resultado <= valA & valB;
      LED[2:0] <= resultado;
    end

    /*Seletor da operação OR realiza a operação
      e atribui ao led o resultado da operação
    */
    else if(seletor == 'b01) begin
      resultado <= valA | valB;
      LED[2:0] <= resultado;
    end
    
    /*Seletor da operação de Soma realiza a operação
      atribui ao led o resultado da operação, verifica
      os casos de underflow e overflow, caso aconteça
      liga o LED 7
    */
    else if(seletor == 'b10) begin
      resultado <= valA + valB;
      if(valA >= 4 && valB >= 4) LED[7] <= 1;
      else if(valA == 3 && valB < 4 && valB > 0) LED[7] <= 1;
      else if(valB == 3 && valA < 4 && valA > 0) LED[7] <= 1;
      else if(valA == 2 && valB == 2) LED[7] <= 1;
      else LED[7] <= 0;
      LED[2:0] <= resultado;
    end

    /*Seletor da operação de Subtração realiza a operação
      atribui ao led o resultado da operação, verifica
      os casos de underflow e overflow, caso aconteça
      liga o LED 7
    */
    else begin
     resultado <= valA - valB;
     if(valA == 4 && valB < 4 && valB > 0) LED[7] <= 1;
     else if(valA == 5 && valB <= 3 && valB > 1) LED[7] <= 1;
     else if(valA == 6 && valB == 3 && valB > 2) LED[7] <= 1;
     else if(valA == 3 && valB >= 4) LED[7] <= 1;
     else if(valA == 2 && valB >= 4 && valB < 6) LED[7] <= 1;
     else if(valA == 1 && valB >= 4 && valB < 5) LED[7] <= 1;
     else LED[7] <= 0;
     LED[2:0] <= resultado;
    end

    /* Verifica se houve underflow ou overflow, caso não tenha
      acontecido coloca no display o numero em decimal
    */
    if(LED[7] == 0) begin
      if(resultado == 'b000) SEG <= NUMERO_0;
      else if(resultado == 'b001) SEG <= NUMERO_1;
      else if(resultado == 'b010) SEG <= NUMERO_2;
      else if(resultado == 'b011) SEG <= NUMERO_3;
      else if(resultado == 'b111) SEG <= NUMERO_n1;
      else if(resultado == 'b110) SEG <= NUMERO_n2;
      else if(resultado == 'b101) SEG <= NUMERO_n3;
      else if(resultado == 'b100) SEG <= NUMERO_n4;
    end
    else SEG <= 0;
  end

endmodule