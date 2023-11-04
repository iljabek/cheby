interface t_noout_inter;
  logic [31:0] reg0;
  logic [31:0] reg1;
  modport master(input reg0, reg1);
  modport slave(output reg0, reg1);
endinterface


module noout
  (
    input   wire rst_n_i,
    input   wire clk_i,
    input   wire wb_cyc_i,
    input   wire wb_stb_i,
    input   wire [2:2] wb_adr_i,
    input   wire [3:0] wb_sel_i,
    input   wire wb_we_i,
    input   wire [31:0] wb_dat_i,
    output  wire wb_ack_o,
    output  wire wb_err_o,
    output  wire wb_rty_o,
    output  wire wb_stall_o,
    output  reg [31:0] wb_dat_o,
    // Wires and registers
    t_noout_inter.master noout_inter
  );
  wire rd_req_int;
  wire wr_req_int;
  reg rd_ack_int;
  reg wr_ack_int;
  wire wb_en;
  wire ack_int;
  reg wb_rip;
  reg wb_wip;
  reg rd_ack_d0;
  reg [31:0] rd_dat_d0;
  reg wr_req_d0;
  reg [2:2] wr_adr_d0;

  // WB decode signals
  always @(wb_sel_i)
      ;
  assign wb_en = wb_cyc_i & wb_stb_i;

  always @(posedge(clk_i) or negedge(rst_n_i))
  begin
    if (!rst_n_i)
      wb_rip <= 1'b0;
    else
      wb_rip <= (wb_rip | (wb_en & ~wb_we_i)) & ~rd_ack_int;
  end
  assign rd_req_int = (wb_en & ~wb_we_i) & ~wb_rip;

  always @(posedge(clk_i) or negedge(rst_n_i))
  begin
    if (!rst_n_i)
      wb_wip <= 1'b0;
    else
      wb_wip <= (wb_wip | (wb_en & wb_we_i)) & ~wr_ack_int;
  end
  assign wr_req_int = (wb_en & wb_we_i) & ~wb_wip;

  assign ack_int = rd_ack_int | wr_ack_int;
  assign wb_ack_o = ack_int;
  assign wb_stall_o = ~ack_int & wb_en;
  assign wb_rty_o = 1'b0;
  assign wb_err_o = 1'b0;

  // pipelining for wr-in+rd-out
  always @(posedge(clk_i) or negedge(rst_n_i))
  begin
    if (!rst_n_i)
      begin
        rd_ack_int <= 1'b0;
        wr_req_d0 <= 1'b0;
      end
    else
      begin
        rd_ack_int <= rd_ack_d0;
        wb_dat_o <= rd_dat_d0;
        wr_req_d0 <= wr_req_int;
        wr_adr_d0 <= wb_adr_i;
      end
  end

  // Register reg0

  // Register reg1

  // Process for write requests.
  always @(wr_adr_d0, wr_req_d0)
      case (wr_adr_d0[2:2])
      1'b0:
        // Reg reg0
        wr_ack_int <= wr_req_d0;
      1'b1:
        // Reg reg1
        wr_ack_int <= wr_req_d0;
      default:
        wr_ack_int <= wr_req_d0;
      endcase

  // Process for read requests.
  always @(wb_adr_i, rd_req_int, noout_inter.reg0, noout_inter.reg1)
      begin
        // By default ack read requests
        rd_dat_d0 <= {32{1'bx}};
        case (wb_adr_i[2:2])
        1'b0:
          begin
            // Reg reg0
            rd_ack_d0 <= rd_req_int;
            rd_dat_d0 <= noout_inter.reg0;
          end
        1'b1:
          begin
            // Reg reg1
            rd_ack_d0 <= rd_req_int;
            rd_dat_d0 <= noout_inter.reg1;
          end
        default:
          rd_ack_d0 <= rd_req_int;
        endcase
      end
endmodule
