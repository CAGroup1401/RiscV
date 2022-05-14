
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
        //add
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
        halted1=1'b0;
        end

        //subtract
    if(inst[14:12]==3'h0 and inst[31:25]==32 )begin
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
        data_rd=data1-data2;
        halted1=1'b0;
        end

        //Shift Left (Logical) 
            if(inst[14:12]==1 and inst[31:25]==3'h0 )begin
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
        data_rd=data1<<data2;
        halted1=1'b0;
        end

        //Set Less Than 
        if(inst[14:12]==2 and inst[31:25]==3'h0 )begin
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
            if(data1<data2)begin
                 data_rd=1;
            end
            else data_rd=0;
       
        halted1=1'b0;
        end

        //Set Less Than Unsigned
         if(inst[14:12]==3 and inst[31:25]==3'h0 )begin
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

            data1=Unsigned(data1);
            data2=Unsigned(data2);
            if(data1<data2)begin
                 data_rd=1;
            end
            else data_rd=0;
       
        halted1=1'b0;
        end

        //eXclusive OR
          if(inst[14:12]==4 and inst[31:25]==3'h0 )begin
            wire [4:0] data1,data2,data_rd;
            wire halted1=1'b0;
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

             data_rd=data1^data2;
       
        end

    //Shift Right Logical
       if(inst[14:12]==5 and inst[31:25]==3'h0 )begin
            wire [4:0] data1,data2,data_rd;
            wire halted1=1'b0;
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

             data_rd=data1>>data2;
       
        end

        //Shift Right Arithmetic
          if(inst[14:12]==5 and inst[31:25]==32 )begin
            wire [4:0] data1,data2,data_rd;
            wire halted1=1'b0;
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

             data_rd=data1>>>data2;
       
        end

    //OR
          if(inst[14:12]==6 and inst[31:25]==0 )begin
            wire [4:0] data1,data2,data_rd;
            wire halted1=1'b0;
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

             data_rd=data1 | data2;
       
        end

        //AND
        if(inst[14:12]==7 and inst[31:25]==0 )begin
            wire [4:0] data1,data2,data_rd;
            wire halted1=1'b0;
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

             data_rd=data1 & data2;
       
        end

    end

     //I instructions:
      if(inst[6:0]==2'h13)begin
          //ADD Imm
             if(inst[14:12]==1'b0 )begin
            wire [4:0] data1,data_rd;
            wire halted1=1'b0;
            regfile regFile(
              .rs1_data(data1),
              .rs2_data(),
              .rs1_num(inst[19:15]),
             .rs2_num(),
             .rd_num(inst[11:7]),
             .rd_data(data_rd),
              .rd_we(1),
             .clk(clk),
              .rst_b(rst_b),
              .halted(halted1)
            );

             data_rd=data1 + inst[31:20];
       
        end

      end

endmodule
