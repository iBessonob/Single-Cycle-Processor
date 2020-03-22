`timescale 1ns / 1ps

module tb_Controller();
reg [1:0] tb_ALUOp;
wire [6:0] tb_Funct7;
wire [2:0] tb_Funct3;
wire [3:0] tb_Operation;

ALUController instant(
    .ALUOp(tb_ALUOp),
    .Funct7(tb_Funct7),
    .Funct3(tb_Funct3),
    .Operation(tb_Operation)
);

initial
begin
    tb_ALUOp = 7'b0110011;
    #20;
    tb_ALUOp = 7'b0010011;
    #20;
    tb_ALUOp = 7'b0000011;
    #20;
    tb_ALUOp = 7'b0100011;
    #20;
end
endmodule
