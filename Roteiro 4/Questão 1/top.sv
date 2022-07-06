// Alfredo Vasconcelos de Andrade - Turma 1 - 120210139
// Roteiro 4 Questão 1

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
    parameter NBITS_DATA = 4;
    logic [NBITS_DATA-1:0] data_inParallel, data_out;
    logic reset;
    logic selecao;
    logic data_inSerial;
    
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

    //atribuição do clock ao led 0
    always_comb LED[0] <= clk_2;  
    //atribuição da saida ao led
    always_comb LED[7:4] <= data_out;

    // atribuição das variaveis aos switch's
    always_comb reset <= SWI[0];
    always_comb data_inSerial <= SWI[1];
    always_comb selecao <= SWI[2];
    always_comb data_inParallel <= SWI[7:4];
    
    always_ff @(posedge reset or posedge clk_2) begin
    
      //caso o switch de rset seja ativado
      if(reset) begin
        data_out <= 0;
      end
      else begin
        //varivel de seleção caso 1, seleciona o registrador paralelo
        if(selecao) begin
          data_out <= data_inParallel;
        end
        //varivel de seleção caso 0, seleciona o registrador serial
        else begin
          data_out[3] <= data_inSerial;
          data_out[2] <= data_out[3];
          data_out[1] <= data_out[2];
          data_out[0] <= data_out[1];
        end

        //atribuição da saida no display
        if(data_out == 0) SEG <= NUMERO_0;
        else if(data_out == 1) SEG <= NUMERO_1;
        else if(data_out == 2) SEG <= NUMERO_2;
        else if(data_out == 3) SEG <= NUMERO_3;
        else if(data_out == 4) SEG <= NUMERO_4;
        else if(data_out == 5) SEG <= NUMERO_5;
        else if(data_out == 6) SEG <= NUMERO_6;
        else if(data_out == 7) SEG <= NUMERO_7;
        else if(data_out == 8) SEG <= NUMERO_8;
        else if(data_out == 9) SEG <= NUMERO_9;
        else if(data_out == 10) SEG <= LETRA_A;
        else if(data_out == 11) SEG <= LETRA_B;
        else if(data_out == 12) SEG <= LETRA_C;
        else if(data_out == 13) SEG <= LETRA_D;
        else if(data_out == 14) SEG <= LETRA_E;
        else if(data_out == 15) SEG <= LETRA_F;
      end
    end
endmodule