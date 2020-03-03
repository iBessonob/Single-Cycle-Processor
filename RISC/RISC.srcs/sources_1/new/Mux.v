`timescale 1ns / 1ps
// Module definition
//                   0   1
module Mux_2_To_1 (S,D0,D1,Y);
// Define the input and output signals
input S;
input [31:0]D0;
input [31:0]D1;
output [31:0]Y;
// Define the MUX2 :1 modules behaviour
assign Y = (S == 1'b0) ? D0:
           D1;

           
endmodule // MUX2 :1