`timescale 1ns / 1ps
// Module definition
module RegFile (
clk, 
reset, 
rg_wrt_en,
rg_wrt_addr ,
rg_rd_addr1 ,
rg_rd_addr2 ,
rg_wrt_data ,
rg_rd_data1 ,
rg_rd_data2 
);
// Define the input and output signals
input clk, reset, rg_wrt_en;
input [4:0]rg_rd_addr1;
input [4:0]rg_rd_addr2;
input [4:0]rg_wrt_addr;
input [31:0]rg_wrt_data;
output [31:0] rg_rd_data1;
output [31:0] rg_rd_data2;
reg [31:0] rfc[31:0];
wire clk;

//if write enable==1, write new pos values on edge
always @(posedge clk or  posedge reset)begin  //IT BOILS DOWN TO POSITIVE EDGE OR POSEDGE RESET posedge clk or  posedge reset
    if(reset==1'b1)begin  //basically check rst @ falling/rising edge
                for(integer i = 0; i < 32; i = i+1)begin
                    rfc[i] <= 0;
                end
         end
    else if(reset==1'b0 && rg_wrt_en==1'b1) //write new values on positive edge fixed :)
            rfc[rg_wrt_addr] <= rg_wrt_data;
    //WARNING: if rst @neg edge, and wrt enable is true, inadvertently write REGARDLESS OF CLK!!!!!!!
        
            
    //rg_rd_data1 = rfc[rg_rd_addr1];//does this count as being independent of reset or clock???
    //rg_rd_data2 = rfc[rg_rd_addr2];//can both addresses read from the same place? (possible test case) :)
end

assign rg_rd_data1 = rfc[rg_rd_addr1];
assign rg_rd_data2 = rfc[rg_rd_addr2]; 

endmodule // RegFile