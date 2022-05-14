
module riscv_core(
    inst_addr,
    inst,
    mem_addr,
    mem_data_out,
    mem_data_in,
    mem_write_en,
    halted,
    clk,
    rst_b
);
    output  [31:0] inst_addr;
    input   [31:0] inst;
    output  [31:0] mem_addr;
    input   [7:0]  mem_data_out[0:3];
    output  [7:0]  mem_data_in[0:3];
    output         mem_write_en;
    output reg     halted;
    input          clk;
    input          rst_b;




    //R instructions:
    
    if(inst[6:0]==2'h33)begin
        if(inst[14:12]==3'h0 and inst[31:25]==3'h0 )begin
            wire [4:0] data1,data2,data_rd;
            wire halted1;
            regfile regFile(
              .rs1_data(data1),
              .rs2_data(data2),
              .rs1_num(inst[19:15]),
             .rs2_num(inst[24:20]),
             .rd_num(inst[11:7]),
             .rd_data(data_rd),
              .rd_we(1),
             .clk(clk),
              .rst_b(rst_b),
              .halted(halted1)
);
        data_rd=data1+data2;
        halted1=1'b1;
        end
    end

endmodule
