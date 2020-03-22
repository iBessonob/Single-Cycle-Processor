`timescale 1ns / 1ps
module processor(input clk , reset ,output [31:0] Result);
// Define the input and output signals

//wires leaving datapath
wire [2:0] Funct3;
wire [6:0] Funct7;
wire [6:0] Opcode;

//wires leaving controller
wire RegWrite, ALUSrc,MemRead,MemWrite,MemtoReg;
wire [1:0] ALUOp;

//wire leaving ALUController
wire [3:0] Operation;

Controller c(Opcode,ALUSrc,MemtoReg,RegWrite,MemRead,MemWrite,ALUOp);
ALUController ac(ALUOp,Funct7,Funct3,Operation);
data_path dp(clk,reset,RegWrite,MemtoReg,ALUSrc,MemWrite,MemRead,Operation,Opcode,Funct7,Funct3,Result);
endmodule // processor
