`timescale 1ns / 1ps

module Data_mem(MemRead,MemWrite,addr,write_data,read_data);
    //parameter addr_length = 9;
    //parameter 
    input[8:0] addr;
    input[31:0] write_data;
    input MemRead,MemWrite;
    output reg [31:0]read_data;
    
    reg[31:0] mem [127:0];
 integer i;
 
 initial //executes only once
 //WARNING: DEFAULT INITIALIZE TO ZERO
 //OTHERWISE YOU WILL READ XXXXXX's!!!!!!!!
 begin
   read_data = 0;
 for(i=0;i<128;i=i+1)
   mem[i] = i;
 end
 
 
    always@(*)begin
        if(MemWrite)
            mem[addr] = write_data;
        if(MemRead)
            read_data = mem[addr];
    end
endmodule
