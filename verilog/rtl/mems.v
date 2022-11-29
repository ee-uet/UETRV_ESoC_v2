
module dmem_ext(
  input  [9:0]  RW0_addr,
  input         RW0_clk,
  input  [31:0] RW0_wdata,
  output [31:0] RW0_rdata,
  input         RW0_en,
  input         RW0_wmode,
  input  [3:0]  RW0_wmask
);
`ifdef RANDOMIZE_REG_INIT
  reg [31:0] _RAND_0;
`endif // RANDOMIZE_REG_INIT
  wire [8:0] mem_0_0_addr0;
  wire  mem_0_0_clk0;
  wire [31:0] mem_0_0_din0;
  wire [31:0] mem_0_0_dout0;
  wire  mem_0_0_csb0;
  wire  mem_0_0_web0;
  wire [3:0] mem_0_0_wmask0;
  wire  mem_0_0_clk1;
  wire  mem_0_0_csb1;
  wire [8:0] mem_0_0_addr1;
  wire [8:0] mem_1_0_addr0;
  wire  mem_1_0_clk0;
  wire [31:0] mem_1_0_din0;
  wire [31:0] mem_1_0_dout0;
  wire  mem_1_0_csb0;
  wire  mem_1_0_web0;
  wire [3:0] mem_1_0_wmask0;
  wire  mem_1_0_clk1;
  wire  mem_1_0_csb1;
  wire [8:0] mem_1_0_addr1;
  wire  RW0_addr_sel = RW0_addr[9];
  reg  RW0_addr_sel_reg;
  wire [31:0] RW0_rdata_0_0 = mem_0_0_dout0;
  wire [31:0] RW0_rdata_0 = RW0_rdata_0_0;
  wire [31:0] RW0_rdata_1_0 = mem_1_0_dout0;
  wire [31:0] RW0_rdata_1 = RW0_rdata_1_0;
  wire  _GEN_0 = ~RW0_addr_sel;
  wire  _GEN_1 = RW0_en & ~RW0_addr_sel;
  wire  _GEN_2 = ~RW0_addr_sel;
  wire  _GEN_3 = RW0_wmode & ~RW0_addr_sel;
  wire  _GEN_4 = RW0_wmask[1];
  wire  _GEN_5 = RW0_wmask[0];
  wire  _GEN_6 = RW0_wmask[2];
  wire [1:0] _GEN_7 = {RW0_wmask[1],RW0_wmask[0]};
  wire  _GEN_8 = RW0_wmask[3];
  wire [2:0] _GEN_9 = {RW0_wmask[2],RW0_wmask[1],RW0_wmask[0]};
  wire  _GEN_10 = RW0_en & RW0_addr_sel;
  wire  _GEN_11 = RW0_wmode & RW0_addr_sel;
  wire  _GEN_12 = RW0_wmask[1];
  wire  _GEN_13 = RW0_wmask[0];
  wire  _GEN_14 = RW0_wmask[2];
  wire [1:0] _GEN_15 = {RW0_wmask[1],RW0_wmask[0]};
  wire  _GEN_16 = RW0_wmask[3];
  wire [2:0] _GEN_17 = {RW0_wmask[2],RW0_wmask[1],RW0_wmask[0]};
  sky130_sram_2kbyte_1rw1r_32x512_8 mem_0_0 (
    .addr0(mem_0_0_addr0),
    .clk0(mem_0_0_clk0),
    .din0(mem_0_0_din0),
    .dout0(mem_0_0_dout0),
    .csb0(mem_0_0_csb0),
    .web0(mem_0_0_web0),
    .wmask0(mem_0_0_wmask0),
    .clk1(mem_0_0_clk1),
    .csb1(mem_0_0_csb1),
    .addr1(mem_0_0_addr1)
  );
  sky130_sram_2kbyte_1rw1r_32x512_8 mem_1_0 (
    .addr0(mem_1_0_addr0),
    .clk0(mem_1_0_clk0),
    .din0(mem_1_0_din0),
    .dout0(mem_1_0_dout0),
    .csb0(mem_1_0_csb0),
    .web0(mem_1_0_web0),
    .wmask0(mem_1_0_wmask0),
    .clk1(mem_1_0_clk1),
    .csb1(mem_1_0_csb1),
    .addr1(mem_1_0_addr1)
  );
  assign RW0_rdata = ~RW0_addr_sel_reg ? RW0_rdata_0_0 : RW0_addr_sel_reg ? RW0_rdata_1_0 : 32'h0;
  assign mem_0_0_addr0 = RW0_addr[8:0];
  assign mem_0_0_clk0 = RW0_clk;
  assign mem_0_0_din0 = RW0_wdata;
  assign mem_0_0_csb0 = ~(RW0_en & ~RW0_addr_sel);
  assign mem_0_0_web0 = ~(RW0_wmode & ~RW0_addr_sel);
  assign mem_0_0_wmask0 = {RW0_wmask[3],_GEN_9};
  assign mem_0_0_clk1 = 1'h0;
  assign mem_0_0_csb1 = 1'h0;
  assign mem_0_0_addr1 = 9'h0;
  assign mem_1_0_addr0 = RW0_addr[8:0];
  assign mem_1_0_clk0 = RW0_clk;
  assign mem_1_0_din0 = RW0_wdata;
  assign mem_1_0_csb0 = ~(RW0_en & RW0_addr_sel);
  assign mem_1_0_web0 = ~(RW0_wmode & RW0_addr_sel);
  assign mem_1_0_wmask0 = {RW0_wmask[3],_GEN_9};
  assign mem_1_0_clk1 = 1'h0;
  assign mem_1_0_csb1 = 1'h0;
  assign mem_1_0_addr1 = 9'h0;
  always @(posedge RW0_clk) begin
    if (RW0_en) begin
      RW0_addr_sel_reg <= RW0_addr_sel;
    end
  end
// Register and memory initialization
`ifdef RANDOMIZE_GARBAGE_ASSIGN
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_INVALID_ASSIGN
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_REG_INIT
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_MEM_INIT
`define RANDOMIZE
`endif
`ifndef RANDOM
`define RANDOM $random
`endif
`ifdef RANDOMIZE_MEM_INIT
  integer initvar;
`endif
`ifndef SYNTHESIS
`ifdef FIRRTL_BEFORE_INITIAL
`FIRRTL_BEFORE_INITIAL
`endif
initial begin
  `ifdef RANDOMIZE
    `ifdef INIT_RANDOM
      `INIT_RANDOM
    `endif
    `ifndef VERILATOR
      `ifdef RANDOMIZE_DELAY
        #`RANDOMIZE_DELAY begin end
      `else
        #0.002 begin end
      `endif
    `endif
`ifdef RANDOMIZE_REG_INIT
  _RAND_0 = {1{`RANDOM}};
  RW0_addr_sel_reg = _RAND_0[0:0];
`endif // RANDOMIZE_REG_INIT
  `endif // RANDOMIZE
end // initial
`ifdef FIRRTL_AFTER_INITIAL
`FIRRTL_AFTER_INITIAL
`endif
`endif // SYNTHESIS
endmodule
module imem_ext(
  input  [9:0]  RW0_addr,
  input         RW0_clk,
  input  [31:0] RW0_wdata,
  output [31:0] RW0_rdata,
  input         RW0_en,
  input         RW0_wmode
);
`ifdef RANDOMIZE_REG_INIT
  reg [31:0] _RAND_0;
`endif // RANDOMIZE_REG_INIT
  wire [8:0] mem_0_0_addr0;
  wire  mem_0_0_clk0;
  wire [31:0] mem_0_0_din0;
  wire [31:0] mem_0_0_dout0;
  wire  mem_0_0_csb0;
  wire  mem_0_0_web0;
  wire [3:0] mem_0_0_wmask0;
  wire  mem_0_0_clk1;
  wire  mem_0_0_csb1;
  wire [8:0] mem_0_0_addr1;
  wire [8:0] mem_1_0_addr0;
  wire  mem_1_0_clk0;
  wire [31:0] mem_1_0_din0;
  wire [31:0] mem_1_0_dout0;
  wire  mem_1_0_csb0;
  wire  mem_1_0_web0;
  wire [3:0] mem_1_0_wmask0;
  wire  mem_1_0_clk1;
  wire  mem_1_0_csb1;
  wire [8:0] mem_1_0_addr1;
  wire  RW0_addr_sel = RW0_addr[9];
  reg  RW0_addr_sel_reg;
  wire [31:0] RW0_rdata_0_0 = mem_0_0_dout0;
  wire [31:0] RW0_rdata_0 = RW0_rdata_0_0;
  wire [31:0] RW0_rdata_1_0 = mem_1_0_dout0;
  wire [31:0] RW0_rdata_1 = RW0_rdata_1_0;
  wire  _GEN_0 = ~RW0_addr_sel;
  wire  _GEN_1 = RW0_en & ~RW0_addr_sel;
  wire  _GEN_2 = ~RW0_addr_sel;
  wire  _GEN_3 = RW0_wmode & ~RW0_addr_sel;
  wire  _GEN_4 = RW0_en & RW0_addr_sel;
  wire  _GEN_5 = RW0_wmode & RW0_addr_sel;
  sky130_sram_2kbyte_1rw1r_32x512_8 mem_0_0 (
    .addr0(mem_0_0_addr0),
    .clk0(mem_0_0_clk0),
    .din0(mem_0_0_din0),
    .dout0(mem_0_0_dout0),
    .csb0(mem_0_0_csb0),
    .web0(mem_0_0_web0),
    .wmask0(mem_0_0_wmask0),
    .clk1(mem_0_0_clk1),
    .csb1(mem_0_0_csb1),
    .addr1(mem_0_0_addr1)
  );
  sky130_sram_2kbyte_1rw1r_32x512_8 mem_1_0 (
    .addr0(mem_1_0_addr0),
    .clk0(mem_1_0_clk0),
    .din0(mem_1_0_din0),
    .dout0(mem_1_0_dout0),
    .csb0(mem_1_0_csb0),
    .web0(mem_1_0_web0),
    .wmask0(mem_1_0_wmask0),
    .clk1(mem_1_0_clk1),
    .csb1(mem_1_0_csb1),
    .addr1(mem_1_0_addr1)
  );
  assign RW0_rdata = ~RW0_addr_sel_reg ? RW0_rdata_0_0 : RW0_addr_sel_reg ? RW0_rdata_1_0 : 32'h0;
  assign mem_0_0_addr0 = RW0_addr[8:0];
  assign mem_0_0_clk0 = RW0_clk;
  assign mem_0_0_din0 = RW0_wdata;
  assign mem_0_0_csb0 = ~(RW0_en & ~RW0_addr_sel);
  assign mem_0_0_web0 = ~(RW0_wmode & ~RW0_addr_sel);
  assign mem_0_0_wmask0 = 4'hf;
  assign mem_0_0_clk1 = 1'h0;
  assign mem_0_0_csb1 = 1'h0;
  assign mem_0_0_addr1 = 9'h0;
  assign mem_1_0_addr0 = RW0_addr[8:0];
  assign mem_1_0_clk0 = RW0_clk;
  assign mem_1_0_din0 = RW0_wdata;
  assign mem_1_0_csb0 = ~(RW0_en & RW0_addr_sel);
  assign mem_1_0_web0 = ~(RW0_wmode & RW0_addr_sel);
  assign mem_1_0_wmask0 = 4'hf;
  assign mem_1_0_clk1 = 1'h0;
  assign mem_1_0_csb1 = 1'h0;
  assign mem_1_0_addr1 = 9'h0;
  always @(posedge RW0_clk) begin
    if (RW0_en) begin
      RW0_addr_sel_reg <= RW0_addr_sel;
    end
  end
// Register and memory initialization
`ifdef RANDOMIZE_GARBAGE_ASSIGN
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_INVALID_ASSIGN
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_REG_INIT
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_MEM_INIT
`define RANDOMIZE
`endif
`ifndef RANDOM
`define RANDOM $random
`endif
`ifdef RANDOMIZE_MEM_INIT
  integer initvar;
`endif
`ifndef SYNTHESIS
`ifdef FIRRTL_BEFORE_INITIAL
`FIRRTL_BEFORE_INITIAL
`endif
initial begin
  `ifdef RANDOMIZE
    `ifdef INIT_RANDOM
      `INIT_RANDOM
    `endif
    `ifndef VERILATOR
      `ifdef RANDOMIZE_DELAY
        #`RANDOMIZE_DELAY begin end
      `else
        #0.002 begin end
      `endif
    `endif
`ifdef RANDOMIZE_REG_INIT
  _RAND_0 = {1{`RANDOM}};
  RW0_addr_sel_reg = _RAND_0[0:0];
`endif // RANDOMIZE_REG_INIT
  `endif // RANDOMIZE
end // initial
`ifdef FIRRTL_AFTER_INITIAL
`FIRRTL_AFTER_INITIAL
`endif
`endif // SYNTHESIS
endmodule
module imem(
  input  [9:0]  RW0_addr,
  input         RW0_clk,
  input         RW0_wmode,
  input  [31:0] RW0_wdata,
  output [31:0] RW0_rdata
);
  wire [9:0] imem_ext_RW0_addr;
  wire  imem_ext_RW0_en;
  wire  imem_ext_RW0_clk;
  wire  imem_ext_RW0_wmode;
  wire [31:0] imem_ext_RW0_wdata;
  wire [31:0] imem_ext_RW0_rdata;
  imem_ext imem_ext (
    .RW0_addr(imem_ext_RW0_addr),
    .RW0_en(imem_ext_RW0_en),
    .RW0_clk(imem_ext_RW0_clk),
    .RW0_wmode(imem_ext_RW0_wmode),
    .RW0_wdata(imem_ext_RW0_wdata),
    .RW0_rdata(imem_ext_RW0_rdata)
  );
  assign imem_ext_RW0_clk = RW0_clk;
  assign imem_ext_RW0_en = 1'h1;
  assign imem_ext_RW0_addr = RW0_addr;
  assign RW0_rdata = imem_ext_RW0_rdata;
  assign imem_ext_RW0_wmode = RW0_wmode;
  assign imem_ext_RW0_wdata = RW0_wdata;
endmodule
module dmem(
  input  [9:0] RW0_addr,
  input        RW0_clk,
  input        RW0_wmode,
  input  [7:0] RW0_wdata_0,
  input  [7:0] RW0_wdata_1,
  input  [7:0] RW0_wdata_2,
  input  [7:0] RW0_wdata_3,
  output [7:0] RW0_rdata_0,
  output [7:0] RW0_rdata_1,
  output [7:0] RW0_rdata_2,
  output [7:0] RW0_rdata_3,
  input        RW0_wmask_0,
  input        RW0_wmask_1,
  input        RW0_wmask_2,
  input        RW0_wmask_3
);
  wire [9:0] dmem_ext_RW0_addr;
  wire  dmem_ext_RW0_en;
  wire  dmem_ext_RW0_clk;
  wire  dmem_ext_RW0_wmode;
  wire [31:0] dmem_ext_RW0_wdata;
  wire [31:0] dmem_ext_RW0_rdata;
  wire [3:0] dmem_ext_RW0_wmask;
  wire [15:0] _GEN_0 = {RW0_wdata_3,RW0_wdata_2};
  wire [15:0] _GEN_1 = {RW0_wdata_1,RW0_wdata_0};
  wire [1:0] _GEN_2 = {RW0_wmask_3,RW0_wmask_2};
  wire [1:0] _GEN_3 = {RW0_wmask_1,RW0_wmask_0};
  dmem_ext dmem_ext (
    .RW0_addr(dmem_ext_RW0_addr),
    .RW0_en(dmem_ext_RW0_en),
    .RW0_clk(dmem_ext_RW0_clk),
    .RW0_wmode(dmem_ext_RW0_wmode),
    .RW0_wdata(dmem_ext_RW0_wdata),
    .RW0_rdata(dmem_ext_RW0_rdata),
    .RW0_wmask(dmem_ext_RW0_wmask)
  );
  assign dmem_ext_RW0_clk = RW0_clk;
  assign dmem_ext_RW0_en = 1'h1;
  assign dmem_ext_RW0_addr = RW0_addr;
  assign RW0_rdata_0 = dmem_ext_RW0_rdata[7:0];
  assign RW0_rdata_1 = dmem_ext_RW0_rdata[15:8];
  assign RW0_rdata_2 = dmem_ext_RW0_rdata[23:16];
  assign RW0_rdata_3 = dmem_ext_RW0_rdata[31:24];
  assign dmem_ext_RW0_wmode = RW0_wmode;
  assign dmem_ext_RW0_wdata = {_GEN_0,_GEN_1};
  assign dmem_ext_RW0_wmask = {_GEN_2,_GEN_3};
endmodule
module IMem(
  input         clock,
  input  [31:0] io_imem_addr,
  output [31:0] io_imem_rdata,
  input  [31:0] io_imem_wdata,
  input         io_wr_en
);
  wire [9:0] imem_RW0_addr; // @[memory.scala 32:25]
  wire  imem_RW0_clk; // @[memory.scala 32:25]
  wire  imem_RW0_wmode; // @[memory.scala 32:25]
  wire [31:0] imem_RW0_wdata; // @[memory.scala 32:25]
  wire [31:0] imem_RW0_rdata; // @[memory.scala 32:25]
  wire [29:0] inst_address = io_imem_addr[31:2]; // @[memory.scala 34:35]
  imem imem ( // @[memory.scala 32:25]
    .RW0_addr(imem_RW0_addr),
    .RW0_clk(imem_RW0_clk),
    .RW0_wmode(imem_RW0_wmode),
    .RW0_wdata(imem_RW0_wdata),
    .RW0_rdata(imem_RW0_rdata)
  );
  assign io_imem_rdata = imem_RW0_rdata; // @[memory.scala 41:17]
  assign imem_RW0_addr = inst_address[9:0]; // @[memory.scala 38:9]
  assign imem_RW0_wmode = io_wr_en; // @[memory.scala 37:19 32:25 38:9]
  assign imem_RW0_clk = clock; // @[memory.scala 37:19 38:9]
  assign imem_RW0_wdata = io_imem_wdata; // @[memory.scala 37:19 38:24]
endmodule
module DMem(
  input         clock,
  input  [11:0] io_dmem_addr,
  input  [31:0] io_dmem_wdata,
  output [31:0] io_dmem_rdata,
  input         io_wr_en,
  input  [3:0]  io_st_type
);
`ifdef RANDOMIZE_REG_INIT
  reg [31:0] _RAND_0;
`endif // RANDOMIZE_REG_INIT
  wire [9:0] dmem_RW0_addr; // @[memory.scala 59:25]
  wire  dmem_RW0_clk; // @[memory.scala 59:25]
  wire  dmem_RW0_wmode; // @[memory.scala 59:25]
  wire [7:0] dmem_RW0_wdata_0; // @[memory.scala 59:25]
  wire [7:0] dmem_RW0_wdata_1; // @[memory.scala 59:25]
  wire [7:0] dmem_RW0_wdata_2; // @[memory.scala 59:25]
  wire [7:0] dmem_RW0_wdata_3; // @[memory.scala 59:25]
  wire [7:0] dmem_RW0_rdata_0; // @[memory.scala 59:25]
  wire [7:0] dmem_RW0_rdata_1; // @[memory.scala 59:25]
  wire [7:0] dmem_RW0_rdata_2; // @[memory.scala 59:25]
  wire [7:0] dmem_RW0_rdata_3; // @[memory.scala 59:25]
  wire  dmem_RW0_wmask_0; // @[memory.scala 59:25]
  wire  dmem_RW0_wmask_1; // @[memory.scala 59:25]
  wire  dmem_RW0_wmask_2; // @[memory.scala 59:25]
  wire  dmem_RW0_wmask_3; // @[memory.scala 59:25]
  wire [1:0] mask_shift = io_dmem_addr[1:0]; // @[memory.scala 63:32]
  wire [4:0] data_shift = {mask_shift, 3'h0}; // @[memory.scala 64:31]
  wire [3:0] _wmask_T_4 = {io_st_type[2:0],io_st_type[3]}; // @[memory.scala 66:36]
  wire [3:0] _wmask_T_5 = mask_shift[0] ? _wmask_T_4 : io_st_type; // @[memory.scala 66:36]
  wire [3:0] _wmask_T_8 = {_wmask_T_5[1:0],_wmask_T_5[3:2]}; // @[memory.scala 66:36]
  wire [3:0] wmask = mask_shift[1] ? _wmask_T_8 : _wmask_T_5; // @[memory.scala 66:36]
  wire [3:0] _T_1 = io_wr_en ? 4'hf : 4'h0; // @[Bitwise.scala 74:12]
  wire [3:0] _T_2 = wmask & _T_1; // @[memory.scala 68:31]
  wire [31:0] _wdata_T_7 = {io_dmem_wdata[30:0],io_dmem_wdata[31]}; // @[memory.scala 70:39]
  wire [31:0] _wdata_T_8 = data_shift[0] ? _wdata_T_7 : io_dmem_wdata; // @[memory.scala 70:39]
  wire [31:0] _wdata_T_11 = {_wdata_T_8[29:0],_wdata_T_8[31:30]}; // @[memory.scala 70:39]
  wire [31:0] _wdata_T_12 = data_shift[1] ? _wdata_T_11 : _wdata_T_8; // @[memory.scala 70:39]
  wire [31:0] _wdata_T_15 = {_wdata_T_12[27:0],_wdata_T_12[31:28]}; // @[memory.scala 70:39]
  wire [31:0] _wdata_T_16 = data_shift[2] ? _wdata_T_15 : _wdata_T_12; // @[memory.scala 70:39]
  wire [31:0] _wdata_T_19 = {_wdata_T_16[23:0],_wdata_T_16[31:24]}; // @[memory.scala 70:39]
  wire [31:0] _wdata_T_20 = data_shift[3] ? _wdata_T_19 : _wdata_T_16; // @[memory.scala 70:39]
  wire [31:0] _wdata_T_23 = {_wdata_T_20[15:0],_wdata_T_20[31:16]}; // @[memory.scala 70:39]
  wire [31:0] wdata = data_shift[4] ? _wdata_T_23 : _wdata_T_20; // @[memory.scala 70:39]
  reg [4:0] old_data_shift; // @[memory.scala 80:27]
  wire [31:0] _io_dmem_rdata_T = {dmem_RW0_rdata_3,dmem_RW0_rdata_2,dmem_RW0_rdata_1,dmem_RW0_rdata_0}; // @[memory.scala 83:31]
  wire [31:0] _io_dmem_rdata_T_8 = {_io_dmem_rdata_T[0],_io_dmem_rdata_T[31:1]}; // @[memory.scala 83:49]
  wire [31:0] _io_dmem_rdata_T_9 = old_data_shift[0] ? _io_dmem_rdata_T_8 : _io_dmem_rdata_T; // @[memory.scala 83:49]
  wire [31:0] _io_dmem_rdata_T_12 = {_io_dmem_rdata_T_9[1:0],_io_dmem_rdata_T_9[31:2]}; // @[memory.scala 83:49]
  wire [31:0] _io_dmem_rdata_T_13 = old_data_shift[1] ? _io_dmem_rdata_T_12 : _io_dmem_rdata_T_9; // @[memory.scala 83:49]
  wire [31:0] _io_dmem_rdata_T_16 = {_io_dmem_rdata_T_13[3:0],_io_dmem_rdata_T_13[31:4]}; // @[memory.scala 83:49]
  wire [31:0] _io_dmem_rdata_T_17 = old_data_shift[2] ? _io_dmem_rdata_T_16 : _io_dmem_rdata_T_13; // @[memory.scala 83:49]
  wire [31:0] _io_dmem_rdata_T_20 = {_io_dmem_rdata_T_17[7:0],_io_dmem_rdata_T_17[31:8]}; // @[memory.scala 83:49]
  wire [31:0] _io_dmem_rdata_T_21 = old_data_shift[3] ? _io_dmem_rdata_T_20 : _io_dmem_rdata_T_17; // @[memory.scala 83:49]
  wire [31:0] _io_dmem_rdata_T_24 = {_io_dmem_rdata_T_21[15:0],_io_dmem_rdata_T_21[31:16]}; // @[memory.scala 83:49]
  dmem dmem ( // @[memory.scala 59:25]
    .RW0_addr(dmem_RW0_addr),
    .RW0_clk(dmem_RW0_clk),
    .RW0_wmode(dmem_RW0_wmode),
    .RW0_wdata_0(dmem_RW0_wdata_0),
    .RW0_wdata_1(dmem_RW0_wdata_1),
    .RW0_wdata_2(dmem_RW0_wdata_2),
    .RW0_wdata_3(dmem_RW0_wdata_3),
    .RW0_rdata_0(dmem_RW0_rdata_0),
    .RW0_rdata_1(dmem_RW0_rdata_1),
    .RW0_rdata_2(dmem_RW0_rdata_2),
    .RW0_rdata_3(dmem_RW0_rdata_3),
    .RW0_wmask_0(dmem_RW0_wmask_0),
    .RW0_wmask_1(dmem_RW0_wmask_1),
    .RW0_wmask_2(dmem_RW0_wmask_2),
    .RW0_wmask_3(dmem_RW0_wmask_3)
  );
  assign io_dmem_rdata = old_data_shift[4] ? _io_dmem_rdata_T_24 : _io_dmem_rdata_T_21; // @[memory.scala 83:49]
  assign dmem_RW0_addr = io_dmem_addr[11:2]; // @[memory.scala 61:27]
  assign dmem_RW0_wmode = io_wr_en; // @[memory.scala 76:19 59:25]
  assign dmem_RW0_clk = clock; // @[memory.scala 76:19]
  assign dmem_RW0_wdata_0 = wdata[7:0]; // @[memory.scala 73:26]
  assign dmem_RW0_wdata_1 = wdata[15:8]; // @[memory.scala 73:26]
  assign dmem_RW0_wdata_2 = wdata[23:16]; // @[memory.scala 73:26]
  assign dmem_RW0_wdata_3 = wdata[31:24]; // @[memory.scala 73:26]
  assign dmem_RW0_wmask_0 = _T_2[0]; // @[memory.scala 68:62]
  assign dmem_RW0_wmask_1 = _T_2[1]; // @[memory.scala 68:62]
  assign dmem_RW0_wmask_2 = _T_2[2]; // @[memory.scala 68:62]
  assign dmem_RW0_wmask_3 = _T_2[3]; // @[memory.scala 68:62]
  always @(posedge clock) begin
    old_data_shift <= {mask_shift, 3'h0}; // @[memory.scala 64:31]
  end
// Register and memory initialization
`ifdef RANDOMIZE_GARBAGE_ASSIGN
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_INVALID_ASSIGN
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_REG_INIT
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_MEM_INIT
`define RANDOMIZE
`endif
`ifndef RANDOM
`define RANDOM $random
`endif
`ifdef RANDOMIZE_MEM_INIT
  integer initvar;
`endif
`ifndef SYNTHESIS
`ifdef FIRRTL_BEFORE_INITIAL
`FIRRTL_BEFORE_INITIAL
`endif
initial begin
  `ifdef RANDOMIZE
    `ifdef INIT_RANDOM
      `INIT_RANDOM
    `endif
    `ifndef VERILATOR
      `ifdef RANDOMIZE_DELAY
        #`RANDOMIZE_DELAY begin end
      `else
        #0.002 begin end
      `endif
    `endif
`ifdef RANDOMIZE_REG_INIT
  _RAND_0 = {1{`RANDOM}};
  old_data_shift = _RAND_0[4:0];
`endif // RANDOMIZE_REG_INIT
  `endif // RANDOMIZE
end // initial
`ifdef FIRRTL_AFTER_INITIAL
`FIRRTL_AFTER_INITIAL
`endif
`endif // SYNTHESIS
endmodule
