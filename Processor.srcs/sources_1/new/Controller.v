`timescale 1ns / 1ps
// Module definition
module Controller (Opcode ,ALUSrc , MemtoReg , RegWrite , MemRead , MemWrite ,ALUOp);

// Define the input and output signals
input[6:0] Opcode;
output ALUSrc, MemtoReg, RegWrite, MemRead, MemWrite;
output reg [1:0] ALUOp;

// Define the Controller modules behavior 
assign ALUSrc = (Opcode == 7'b0110011) ? 1'b0 : 1'b1;
assign MemtoReg = (Opcode == 7'b000011) ? 1'b1 : 1'b0;
assign RegWrite = (Opcode == 7'b0100011) ? 1'b0 : 1'b1;
assign MemRead = (Opcode == 7'b000011) ? 1'b1 : 1'b0;
assign MemWrite = (Opcode == 7'b0100011) ? 1'b1 : 1'b0;

always @(*)
    case(Opcode)
        7'b0110011:
            ALUOp = 2'b10; 
        7'b0010011:
            ALUOp = 2'b00;   
        7'b0000011:
            ALUOp = 2'b01;  
        7'b0100011:
            ALUOp = 2'b01;  
        default:
            ALUOp = 2'b01;
            //$display ("Opcode failed to match above: ",Opcode) 
    endcase
endmodule // Controller
