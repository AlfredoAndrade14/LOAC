// Alfredo Vasconcelos de Andrade - Turma 1 - 120210139
// Roteiro 5 Questão 3

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
  logic reset, data_in, data_out;
  
  //atribuição das variaveis aos switch's
  always_comb reset <= SWI[0];
  always_comb data_in <= SWI[1];
	
  //definição dos estados da maquina
  enum logic [3 : 0] {B0, B1, B2, B3} state;

  always_ff @ (posedge clk_2)
    //função do reset
    if (reset) begin 
      data_out <= 0;
      state <= B0;
    end

    else
		unique case (state)
      //caso receba o bit menos significante correto vai para o proximo estado
      //caso contrario ficara nesse estado
			B0:
				if (data_in) state <= B1;

				else state <= B0;
      //caso receba o segundo bit correto vai para o proximo estado
      //caso contrario voltara ao primeiro estado
			B1:
				if (data_in == 0) state <= B2;

				else state <= B0;
      //caso receba o terceiro bit correto vai para o proximo estado
      //caso contrario voltara ao primeiro estado
      B2:
				if (data_in) state <= B3;

				else state <= B0;
      //caso receba o ultimo bit correto 
      //caso contrario voltara ao primeiro estado
      B3:
				if (data_in) data_out <= 1;

				else state <= B0;    
		endcase

  //atribuição do clock ao led 0
  always_comb LED[0] <= clk_2;  

  //atribuição da saida ao led    
  always_comb LED[7] <= data_out;
  
endmodule