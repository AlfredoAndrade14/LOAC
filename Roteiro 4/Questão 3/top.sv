// Alfredo Vasconcelos de Andrade - Turma 1 - 120210139
// Roteiro 4 Questão 3

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
    parameter ADDR_WIDTH = 2;
    parameter DATA_WIDTH = 4;
    logic [ADDR_WIDTH-1:0] addr;
    logic [DATA_WIDTH-1:0] data_out;
    always_comb addr <= SWI[3:2];

    //atribuição do endereço acessado ao led1
    always_comb LED[2:1] <= addr;

    always_comb begin
      case(addr)
        //escrita na memoria endereço 00
        0: begin
          data_out <= 'b0110;
          //atribuição da saida no display
          SEG <= 'b01111101;
        end
        //escrita na memoria endereço 01
        1: begin
          data_out <= 'b1100;
          //atribuição da saida no display
          SEG <= 'b00111001;
        end
        //escrita na memoria endereço 10
        2: begin
          data_out <= 'b1001;
          //atribuição da saida no display
          SEG <= 'b01101111;
        end
        //escrita na memoria no endereço 11
        3: begin 
          data_out <= 'b0101;
          //atribuição da saida no display
          SEG <= 'b01101101;
        end
      endcase
    end

    //atribuição do led para mostrar o dado armazenado
    always_comb LED[7:4] <= data_out;

endmodule