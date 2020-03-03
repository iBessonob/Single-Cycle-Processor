`timescale 1ns / 1ps

module data_path #(
    parameter PC_W = 8, // Program Counter
    parameter INS_W = 32, // Instruction Width
    parameter RF_ADDRESS = 5, // Register File Address
    parameter DATA_W = 32, // Data WriteData
    parameter DM_ADDRESS = 9, // Data Memory Address
    parameter ALU_CC_W = 4 // ALU Control Code Width
    )(
    input clk , // CLK in Datapath figure
    input reset , // Reset in Datapath figure
    input reg_write , // RegWrite in Datapath figure
    input mem2reg , // MemtoReg in Datapath figure
    input alu_src , // ALUSrc in Datapath figure
    input mem_write , // MemWrite in Datapath Figure
    input mem_read , // MemRead in Datapath Figure
    input [ ALU_CC_W-1:0] alu_cc , // ALUCC in Datapath Figure
    output [6:0] opcode , // opcode in Datapath Figure
    output [6:0] funct7 , // Funct7 in Datapath Figure
    output [2:0] funct3 , // Func3 in Datapath Figure
    output [ DATA_W-1:0] alu_result // Datapath_Result in Datapath Figure
   // output [DATA_W-1:0] reg_file [DATA_W-1:0]
);

/*
all the wires
*/
wire[PC_W-1:0] PC;
wire[PC_W-1:0] PCPlus4;
wire[INS_W-1:0] Instruction;
wire[RF_ADDRESS-1:0] rg_rd_addr1;
wire[RF_ADDRESS-1:0] rg_rd_addr2;
wire[RF_ADDRESS-1:0] rg_wrt_addr;
wire[DATA_W-1:0] Reg1;
wire[DATA_W-1:0] Reg2;
wire[DATA_W-1:0] ExtImm;
wire[DATA_W-1:0] SrcB;
wire[DATA_W-1:0] DataMem_read;
wire[DATA_W-1:0] WriteBack_Data;
wire carry,zero,overflow; //useless???

/*
Flip Flop and Instruction Memory IO Ports
*/
HA h(PC,8'b00000100,PCPlus4,carry);
FlipFlop ff(clk,reset,PCPlus4,PC);

//assign pc = PC; //temporary, delete later
InstMem im(PC,Instruction);
assign opcode = Instruction[6:0];
assign funct3 = Instruction[14:12];
assign funct7 = Instruction[31:25];

/*Register and ImmGen IO Ports*/ 
assign rg_rd_addr1 = Instruction[19:15];
assign rg_rd_addr2 = Instruction[24:20];
assign rg_wrt_addr = Instruction[11:7];                                                   
RegFile rg(clk,
    reset,
    reg_write,
    rg_wrt_addr,
    rg_rd_addr1,
    rg_rd_addr2,
    WriteBack_Data, 
    Reg1,
     Reg2);
ImmGen ig(Instruction,ExtImm);
Mux_2_To_1 b(alu_src,Reg2,ExtImm,SrcB); //Reg2, ExtImm original order
                     //0     1
/*ALU IO Ports*/
alu_32 alu(Reg1,SrcB,alu_cc,alu_result,carry,zero,overflow);


assign ext_imm = ExtImm;

/*Data Memory IO ports and Selector*/
Data_mem dm(mem_read,mem_write,alu_result[DM_ADDRESS-1:0],Reg2,DataMem_read);
Mux_2_To_1 wb(mem2reg,alu_result,DataMem_read,WriteBack_Data); //DataMem_read, ALU_Result original order 
                           //0          1

endmodule // Datapath