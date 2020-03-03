`timescale 1ns / 1ps

// Module definition
module FlipFlop (clk,reset,d,q);
// Define the input and output signals
input clk, reset;
input[7:0] d;
output reg [7:0]q;
wire clk;

// Define the D Flip flop modules ' behaviour
always @(posedge clk)
begin
    if(reset==1'b1) 
        q <= 0; 
    else
        q <= d;
end
endmodule // FlipFlop