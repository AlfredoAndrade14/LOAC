// Alfredo Vasconcelos de Andrade - Turma 1 - 120210139
// Roteiro 4 Questão 2

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
    
    //definição da quantidade de bits e variaveis
    logic reset;
    parameter ADDR_WIDTH = 2;
    parameter DATA_WIDTH = 4;
    logic [ADDR_WIDTH-1:0] addr;
    logic [DATA_WIDTH-1:0] wdata;
    logic [DATA_WIDTH-1:0] rdata;
    logic [DATA_WIDTH-1:0] mem [2**ADDR_WIDTH-1:0];
    logic wr_en;
    integer i;

    // atribuição das variaveis aos switch's
    always_comb reset <= SWI[0];
    always_comb wr_en <= SWI[1];
    always_comb addr <= SWI[3:2];
    always_comb wdata <= SWI[7:4];

    always_ff @(posedge clk_2) begin
        //reset que zera a memoria
        if(reset) begin
            mem[0] <= 0;
            mem[1] <= 0;
            mem[2] <= 0;
            mem[3] <= 0;
        end

        //seletor entre leitura ou escrita na mémoria
        if(wr_en) mem[addr] <= wdata;
        else rdata <= mem[addr];
    
        //atribuição da saida no display
        if(rdata == 0) SEG <= NUMERO_0;
        else if(rdata == 1) SEG <= NUMERO_1;
        else if(rdata == 2) SEG <= NUMERO_2;
        else if(rdata == 3) SEG <= NUMERO_3;
        else if(rdata == 4) SEG <= NUMERO_4;
        else if(rdata == 5) SEG <= NUMERO_5;
        else if(rdata == 6) SEG <= NUMERO_6;
        else if(rdata == 7) SEG <= NUMERO_7;
        else if(rdata == 8) SEG <= NUMERO_8;
        else if(rdata == 9) SEG <= NUMERO_9;
        else if(rdata == 10) SEG <= LETRA_A;
        else if(rdata == 11) SEG <= LETRA_B;
        else if(rdata == 12) SEG <= LETRA_C;
        else if(rdata == 13) SEG <= LETRA_D;
        else if(rdata == 14) SEG <= LETRA_E;
        else if(rdata == 15) SEG <= LETRA_F;
    end

    //atribuição do clock ao led 0
    always_comb LED[0] <= clk_2;

    //atribuição do seletor de ler ou escrver ao led
    always_comb LED[1] <= wr_en;

    //atribuição do endereço acessado ao led1
    always_comb LED[3:2] <= addr;

    //atribuição do led para mostrar o dado armazenado
    always_comb LED[7:4] <= rdata;

endmodule