`timescale 1ns / 1ps

module HA(A,B,Sum,Cout);

//define I/O signals
input[7:0] A;
input[7:0] B;
output[7:0] Sum;
output Cout;

//define module behavior
assign Sum = A + B;  //verilog's add operator
assign Cout = A & B; //bitwise and

endmodule