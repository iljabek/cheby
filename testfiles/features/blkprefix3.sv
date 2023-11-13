
module blkprefix3
  (
    input   wire rst_n_i,
    input   wire clk_i,
    input   wire wb_cyc_i,
    input   wire wb_stb_i,
    input   wire [3:2] wb_adr_i,
    input   wire [3:0] wb_sel_i,
    input   wire wb_we_i,
    input   wire [31:0] wb_dat_i,
    output  wire wb_ack_o,
    output  wire wb_err_o,
    output  wire wb_rty_o,
    output  wire wb_stall_o,
    output  reg [31:0] wb_dat_o,

    // REG r2
    output  wire [2:0] b1_r2_f1_o,
    output  wire b1_r2_f2_o,

    // REG r3
    output  wire [2:0] b1_r3_f1_o,
    output  wire b1_r3_f2_o,

    // REG r3
    output  wire [2:0] b2_r3_f1_o
  );
  wire rd_req_int;
  wire wr_req_int;
  reg rd_ack_int;
  reg wr_ack_int;
  wire wb_en;
  wire ack_int;
  reg wb_rip;
  reg wb_wip;
  reg [2:0] b1_r2_f1_reg;
  reg b1_r2_f2_reg;
  reg b1_r2_wreq;
  reg b1_r2_wack;
  reg [2:0] b1_b11_r3_f1_reg;
  reg b1_b11_r3_f2_reg;
  reg b1_r3_wreq;
  reg b1_r3_wack;
  reg [2:0] b2_r3_f1_reg;
  reg b2_r3_wreq;
  reg b2_r3_wack;
  reg rd_ack_d0;
  reg [31:0] rd_dat_d0;
  reg wr_req_d0;
  reg [3:2] wr_adr_d0;
  reg [31:0] wr_dat_d0;

  // WB decode signals
  always @(wb_sel_i)
  ;
  assign wb_en = wb_cyc_i & wb_stb_i;

  always @(posedge(clk_i))
  begin
    if (!rst_n_i)
      wb_rip <= 1'b0;
    else
      wb_rip <= (wb_rip | (wb_en & ~wb_we_i)) & ~rd_ack_int;
  end
  assign rd_req_int = (wb_en & ~wb_we_i) & ~wb_rip;

  always @(posedge(clk_i))
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
  always @(posedge(clk_i))
  begin
    if (!rst_n_i)
      begin
        rd_ack_int <= 1'b0;
        wb_dat_o <= 32'b00000000000000000000000000000000;
        wr_req_d0 <= 1'b0;
        wr_adr_d0 <= 2'b00;
        wr_dat_d0 <= 32'b00000000000000000000000000000000;
      end
    else
      begin
        rd_ack_int <= rd_ack_d0;
        wb_dat_o <= rd_dat_d0;
        wr_req_d0 <= wr_req_int;
        wr_adr_d0 <= wb_adr_i;
        wr_dat_d0 <= wb_dat_i;
      end
  end

  // Register b1_r2
  assign b1_r2_f1_o = b1_r2_f1_reg;
  assign b1_r2_f2_o = b1_r2_f2_reg;
  always @(posedge(clk_i))
  begin
    if (!rst_n_i)
      begin
        b1_r2_f1_reg <= 3'b000;
        b1_r2_f2_reg <= 1'b0;
        b1_r2_wack <= 1'b0;
      end
    else
      begin
        if (b1_r2_wreq == 1'b1)
          begin
            b1_r2_f1_reg <= wr_dat_d0[2:0];
            b1_r2_f2_reg <= wr_dat_d0[4];
          end
        b1_r2_wack <= b1_r2_wreq;
      end
  end

  // Register b1_r3
  assign b1_r3_f1_o = b1_b11_r3_f1_reg;
  assign b1_r3_f2_o = b1_b11_r3_f2_reg;
  always @(posedge(clk_i))
  begin
    if (!rst_n_i)
      begin
        b1_b11_r3_f1_reg <= 3'b000;
        b1_b11_r3_f2_reg <= 1'b0;
        b1_r3_wack <= 1'b0;
      end
    else
      begin
        if (b1_r3_wreq == 1'b1)
          begin
            b1_b11_r3_f1_reg <= wr_dat_d0[2:0];
            b1_b11_r3_f2_reg <= wr_dat_d0[4];
          end
        b1_r3_wack <= b1_r3_wreq;
      end
  end

  // Register b2_r3
  assign b2_r3_f1_o = b2_r3_f1_reg;
  always @(posedge(clk_i))
  begin
    if (!rst_n_i)
      begin
        b2_r3_f1_reg <= 3'b000;
        b2_r3_wack <= 1'b0;
      end
    else
      begin
        if (b2_r3_wreq == 1'b1)
          b2_r3_f1_reg <= wr_dat_d0[2:0];
        b2_r3_wack <= b2_r3_wreq;
      end
  end

  // Process for write requests.
  always @(wr_adr_d0, wr_req_d0, b1_r2_wack, b1_r3_wack, b2_r3_wack)
  begin
    b1_r2_wreq <= 1'b0;
    b1_r3_wreq <= 1'b0;
    b2_r3_wreq <= 1'b0;
    case (wr_adr_d0[3:2])
    2'b00:
      begin
        // Reg b1_r2
        b1_r2_wreq <= wr_req_d0;
        wr_ack_int <= b1_r2_wack;
      end
    2'b01:
      begin
        // Reg b1_r3
        b1_r3_wreq <= wr_req_d0;
        wr_ack_int <= b1_r3_wack;
      end
    2'b10:
      begin
        // Reg b2_r3
        b2_r3_wreq <= wr_req_d0;
        wr_ack_int <= b2_r3_wack;
      end
    default:
      wr_ack_int <= wr_req_d0;
    endcase
  end

  // Process for read requests.
  always @(wb_adr_i, rd_req_int, b1_r2_f1_reg, b1_r2_f2_reg, b1_b11_r3_f1_reg, b1_b11_r3_f2_reg, b2_r3_f1_reg)
  begin
    // By default ack read requests
    rd_dat_d0 <= {32{1'bx}};
    case (wb_adr_i[3:2])
    2'b00:
      begin
        // Reg b1_r2
        rd_ack_d0 <= rd_req_int;
        rd_dat_d0[2:0] <= b1_r2_f1_reg;
        rd_dat_d0[3] <= 1'b0;
        rd_dat_d0[4] <= b1_r2_f2_reg;
        rd_dat_d0[31:5] <= 27'b0;
      end
    2'b01:
      begin
        // Reg b1_r3
        rd_ack_d0 <= rd_req_int;
        rd_dat_d0[2:0] <= b1_b11_r3_f1_reg;
        rd_dat_d0[3] <= 1'b0;
        rd_dat_d0[4] <= b1_b11_r3_f2_reg;
        rd_dat_d0[31:5] <= 27'b0;
      end
    2'b10:
      begin
        // Reg b2_r3
        rd_ack_d0 <= rd_req_int;
        rd_dat_d0[2:0] <= b2_r3_f1_reg;
        rd_dat_d0[31:3] <= 29'b0;
      end
    default:
      rd_ack_d0 <= rd_req_int;
    endcase
  end
endmodule
