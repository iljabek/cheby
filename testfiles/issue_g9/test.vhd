-- Do not edit.  Generated by cheby 1.6.dev0 using these options:
--  -i test.cheby --hdl vhdl --gen-hdl test.vhd
-- Generated on Sat Aug 26 11:37:32 2023 by stefan


library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use work.wishbone_pkg.all;
use work.cheby_pkg.all;

entity wb_ram_io_group_regs is
  port (
    rst_n_i              : in    std_logic;
    clk_i                : in    std_logic;
    wb_i                 : in    t_wishbone_slave_in;
    wb_o                 : out   t_wishbone_slave_out;

    -- RAM port for rams_0_ram_bank
    rams_0_ram_bank_adr_i : in    std_logic_vector(8 downto 0);
    rams_0_ram_bank_data_rd_i : in    std_logic;
    rams_0_ram_bank_data_dat_o : out   std_logic_vector(31 downto 0);

    -- RAM port for rams_1_ram_bank
    rams_1_ram_bank_adr_i : in    std_logic_vector(8 downto 0);
    rams_1_ram_bank_data_rd_i : in    std_logic;
    rams_1_ram_bank_data_dat_o : out   std_logic_vector(31 downto 0);

    -- RAM port for rams_2_ram_bank
    rams_2_ram_bank_adr_i : in    std_logic_vector(8 downto 0);
    rams_2_ram_bank_data_rd_i : in    std_logic;
    rams_2_ram_bank_data_dat_o : out   std_logic_vector(31 downto 0);

    -- RAM port for rams_3_ram_bank
    rams_3_ram_bank_adr_i : in    std_logic_vector(8 downto 0);
    rams_3_ram_bank_data_rd_i : in    std_logic;
    rams_3_ram_bank_data_dat_o : out   std_logic_vector(31 downto 0);

    -- RAM port for rams_4_ram_bank
    rams_4_ram_bank_adr_i : in    std_logic_vector(8 downto 0);
    rams_4_ram_bank_data_rd_i : in    std_logic;
    rams_4_ram_bank_data_dat_o : out   std_logic_vector(31 downto 0);

    -- RAM port for rams_5_ram_bank
    rams_5_ram_bank_adr_i : in    std_logic_vector(8 downto 0);
    rams_5_ram_bank_data_rd_i : in    std_logic;
    rams_5_ram_bank_data_dat_o : out   std_logic_vector(31 downto 0);

    -- RAM port for rams_6_ram_bank
    rams_6_ram_bank_adr_i : in    std_logic_vector(8 downto 0);
    rams_6_ram_bank_data_rd_i : in    std_logic;
    rams_6_ram_bank_data_dat_o : out   std_logic_vector(31 downto 0);

    -- RAM port for rams_7_ram_bank
    rams_7_ram_bank_adr_i : in    std_logic_vector(8 downto 0);
    rams_7_ram_bank_data_rd_i : in    std_logic;
    rams_7_ram_bank_data_dat_o : out   std_logic_vector(31 downto 0)
  );
end wb_ram_io_group_regs;

architecture syn of wb_ram_io_group_regs is
  signal adr_int                        : std_logic_vector(14 downto 2);
  signal rd_req_int                     : std_logic;
  signal wr_req_int                     : std_logic;
  signal rd_ack_int                     : std_logic;
  signal wr_ack_int                     : std_logic;
  signal wb_en                          : std_logic;
  signal ack_int                        : std_logic;
  signal wb_rip                         : std_logic;
  signal wb_wip                         : std_logic;
  signal rams_0_ram_bank_data_int_dato  : std_logic_vector(31 downto 0);
  signal rams_0_ram_bank_data_ext_dat   : std_logic_vector(31 downto 0);
  signal rams_0_ram_bank_data_rreq      : std_logic;
  signal rams_0_ram_bank_data_rack      : std_logic;
  signal rams_0_ram_bank_data_int_wr    : std_logic;
  signal rams_1_ram_bank_data_int_dato  : std_logic_vector(31 downto 0);
  signal rams_1_ram_bank_data_ext_dat   : std_logic_vector(31 downto 0);
  signal rams_1_ram_bank_data_rreq      : std_logic;
  signal rams_1_ram_bank_data_rack      : std_logic;
  signal rams_1_ram_bank_data_int_wr    : std_logic;
  signal rams_2_ram_bank_data_int_dato  : std_logic_vector(31 downto 0);
  signal rams_2_ram_bank_data_ext_dat   : std_logic_vector(31 downto 0);
  signal rams_2_ram_bank_data_rreq      : std_logic;
  signal rams_2_ram_bank_data_rack      : std_logic;
  signal rams_2_ram_bank_data_int_wr    : std_logic;
  signal rams_3_ram_bank_data_int_dato  : std_logic_vector(31 downto 0);
  signal rams_3_ram_bank_data_ext_dat   : std_logic_vector(31 downto 0);
  signal rams_3_ram_bank_data_rreq      : std_logic;
  signal rams_3_ram_bank_data_rack      : std_logic;
  signal rams_3_ram_bank_data_int_wr    : std_logic;
  signal rams_4_ram_bank_data_int_dato  : std_logic_vector(31 downto 0);
  signal rams_4_ram_bank_data_ext_dat   : std_logic_vector(31 downto 0);
  signal rams_4_ram_bank_data_rreq      : std_logic;
  signal rams_4_ram_bank_data_rack      : std_logic;
  signal rams_4_ram_bank_data_int_wr    : std_logic;
  signal rams_5_ram_bank_data_int_dato  : std_logic_vector(31 downto 0);
  signal rams_5_ram_bank_data_ext_dat   : std_logic_vector(31 downto 0);
  signal rams_5_ram_bank_data_rreq      : std_logic;
  signal rams_5_ram_bank_data_rack      : std_logic;
  signal rams_5_ram_bank_data_int_wr    : std_logic;
  signal rams_6_ram_bank_data_int_dato  : std_logic_vector(31 downto 0);
  signal rams_6_ram_bank_data_ext_dat   : std_logic_vector(31 downto 0);
  signal rams_6_ram_bank_data_rreq      : std_logic;
  signal rams_6_ram_bank_data_rack      : std_logic;
  signal rams_6_ram_bank_data_int_wr    : std_logic;
  signal rams_7_ram_bank_data_int_dato  : std_logic_vector(31 downto 0);
  signal rams_7_ram_bank_data_ext_dat   : std_logic_vector(31 downto 0);
  signal rams_7_ram_bank_data_rreq      : std_logic;
  signal rams_7_ram_bank_data_rack      : std_logic;
  signal rams_7_ram_bank_data_int_wr    : std_logic;
  signal rd_ack_d0                      : std_logic;
  signal rd_dat_d0                      : std_logic_vector(31 downto 0);
  signal wr_req_d0                      : std_logic;
  signal wr_adr_d0                      : std_logic_vector(14 downto 2);
  signal wr_dat_d0                      : std_logic_vector(31 downto 0);
  signal wr_sel_d0                      : std_logic_vector(3 downto 0);
  signal rams_0_ram_bank_wr             : std_logic;
  signal rams_0_ram_bank_wreq           : std_logic;
  signal rams_0_ram_bank_adr_int        : std_logic_vector(8 downto 0);
  signal rams_1_ram_bank_wr             : std_logic;
  signal rams_1_ram_bank_wreq           : std_logic;
  signal rams_1_ram_bank_adr_int        : std_logic_vector(8 downto 0);
  signal rams_2_ram_bank_wr             : std_logic;
  signal rams_2_ram_bank_wreq           : std_logic;
  signal rams_2_ram_bank_adr_int        : std_logic_vector(8 downto 0);
  signal rams_3_ram_bank_wr             : std_logic;
  signal rams_3_ram_bank_wreq           : std_logic;
  signal rams_3_ram_bank_adr_int        : std_logic_vector(8 downto 0);
  signal rams_4_ram_bank_wr             : std_logic;
  signal rams_4_ram_bank_wreq           : std_logic;
  signal rams_4_ram_bank_adr_int        : std_logic_vector(8 downto 0);
  signal rams_5_ram_bank_wr             : std_logic;
  signal rams_5_ram_bank_wreq           : std_logic;
  signal rams_5_ram_bank_adr_int        : std_logic_vector(8 downto 0);
  signal rams_6_ram_bank_wr             : std_logic;
  signal rams_6_ram_bank_wreq           : std_logic;
  signal rams_6_ram_bank_adr_int        : std_logic_vector(8 downto 0);
  signal rams_7_ram_bank_wr             : std_logic;
  signal rams_7_ram_bank_wreq           : std_logic;
  signal rams_7_ram_bank_adr_int        : std_logic_vector(8 downto 0);
begin

  -- WB decode signals
  adr_int <= wb_i.adr(14 downto 2);
  wb_en <= wb_i.cyc and wb_i.stb;

  process (clk_i) begin
    if rising_edge(clk_i) then
      if rst_n_i = '0' then
        wb_rip <= '0';
      else
        wb_rip <= (wb_rip or (wb_en and not wb_i.we)) and not rd_ack_int;
      end if;
    end if;
  end process;
  rd_req_int <= (wb_en and not wb_i.we) and not wb_rip;

  process (clk_i) begin
    if rising_edge(clk_i) then
      if rst_n_i = '0' then
        wb_wip <= '0';
      else
        wb_wip <= (wb_wip or (wb_en and wb_i.we)) and not wr_ack_int;
      end if;
    end if;
  end process;
  wr_req_int <= (wb_en and wb_i.we) and not wb_wip;

  ack_int <= rd_ack_int or wr_ack_int;
  wb_o.ack <= ack_int;
  wb_o.stall <= not ack_int and wb_en;
  wb_o.rty <= '0';
  wb_o.err <= '0';

  -- pipelining for wr-in+rd-out
  process (clk_i) begin
    if rising_edge(clk_i) then
      if rst_n_i = '0' then
        rd_ack_int <= '0';
        wr_req_d0 <= '0';
      else
        rd_ack_int <= rd_ack_d0;
        wb_o.dat <= rd_dat_d0;
        wr_req_d0 <= wr_req_int;
        wr_adr_d0 <= adr_int;
        wr_dat_d0 <= wb_i.dat;
        wr_sel_d0 <= wb_i.sel;
      end if;
    end if;
  end process;

  -- Memory rams_0_ram_bank
  process (adr_int, wr_adr_d0, rams_0_ram_bank_wr) begin
    if rams_0_ram_bank_wr = '1' then
      rams_0_ram_bank_adr_int <= wr_adr_d0(10 downto 2);
    else
      rams_0_ram_bank_adr_int <= adr_int(10 downto 2);
    end if;
  end process;
  rams_0_ram_bank_wreq <= rams_0_ram_bank_data_int_wr;
  rams_0_ram_bank_wr <= rams_0_ram_bank_wreq;
  rams_0_ram_bank_data_raminst: cheby_dpssram
    generic map (
      g_data_width         => 32,
      g_size               => 512,
      g_addr_width         => 9,
      g_dual_clock         => '0',
      g_use_bwsel          => '1'
    )
    port map (
      clk_a_i              => clk_i,
      clk_b_i              => clk_i,
      addr_a_i             => rams_0_ram_bank_adr_int,
      bwsel_a_i            => wr_sel_d0,
      data_a_i             => wr_dat_d0,
      data_a_o             => rams_0_ram_bank_data_int_dato,
      rd_a_i               => rams_0_ram_bank_data_rreq,
      wr_a_i               => rams_0_ram_bank_data_int_wr,
      addr_b_i             => rams_0_ram_bank_adr_i,
      bwsel_b_i            => (others => '1'),
      data_b_i             => rams_0_ram_bank_data_ext_dat,
      data_b_o             => rams_0_ram_bank_data_dat_o,
      rd_b_i               => rams_0_ram_bank_data_rd_i,
      wr_b_i               => '0'
    );
  
  process (clk_i) begin
    if rising_edge(clk_i) then
      if rst_n_i = '0' then
        rams_0_ram_bank_data_rack <= '0';
      else
        rams_0_ram_bank_data_rack <= rams_0_ram_bank_data_rreq;
      end if;
    end if;
  end process;

  -- Memory rams_1_ram_bank
  process (adr_int, wr_adr_d0, rams_1_ram_bank_wr) begin
    if rams_1_ram_bank_wr = '1' then
      rams_1_ram_bank_adr_int <= wr_adr_d0(10 downto 2);
    else
      rams_1_ram_bank_adr_int <= adr_int(10 downto 2);
    end if;
  end process;
  rams_1_ram_bank_wreq <= rams_1_ram_bank_data_int_wr;
  rams_1_ram_bank_wr <= rams_1_ram_bank_wreq;
  rams_1_ram_bank_data_raminst: cheby_dpssram
    generic map (
      g_data_width         => 32,
      g_size               => 512,
      g_addr_width         => 9,
      g_dual_clock         => '0',
      g_use_bwsel          => '1'
    )
    port map (
      clk_a_i              => clk_i,
      clk_b_i              => clk_i,
      addr_a_i             => rams_1_ram_bank_adr_int,
      bwsel_a_i            => wr_sel_d0,
      data_a_i             => wr_dat_d0,
      data_a_o             => rams_1_ram_bank_data_int_dato,
      rd_a_i               => rams_1_ram_bank_data_rreq,
      wr_a_i               => rams_1_ram_bank_data_int_wr,
      addr_b_i             => rams_1_ram_bank_adr_i,
      bwsel_b_i            => (others => '1'),
      data_b_i             => rams_1_ram_bank_data_ext_dat,
      data_b_o             => rams_1_ram_bank_data_dat_o,
      rd_b_i               => rams_1_ram_bank_data_rd_i,
      wr_b_i               => '0'
    );
  
  process (clk_i) begin
    if rising_edge(clk_i) then
      if rst_n_i = '0' then
        rams_1_ram_bank_data_rack <= '0';
      else
        rams_1_ram_bank_data_rack <= rams_1_ram_bank_data_rreq;
      end if;
    end if;
  end process;

  -- Memory rams_2_ram_bank
  process (adr_int, wr_adr_d0, rams_2_ram_bank_wr) begin
    if rams_2_ram_bank_wr = '1' then
      rams_2_ram_bank_adr_int <= wr_adr_d0(10 downto 2);
    else
      rams_2_ram_bank_adr_int <= adr_int(10 downto 2);
    end if;
  end process;
  rams_2_ram_bank_wreq <= rams_2_ram_bank_data_int_wr;
  rams_2_ram_bank_wr <= rams_2_ram_bank_wreq;
  rams_2_ram_bank_data_raminst: cheby_dpssram
    generic map (
      g_data_width         => 32,
      g_size               => 512,
      g_addr_width         => 9,
      g_dual_clock         => '0',
      g_use_bwsel          => '1'
    )
    port map (
      clk_a_i              => clk_i,
      clk_b_i              => clk_i,
      addr_a_i             => rams_2_ram_bank_adr_int,
      bwsel_a_i            => wr_sel_d0,
      data_a_i             => wr_dat_d0,
      data_a_o             => rams_2_ram_bank_data_int_dato,
      rd_a_i               => rams_2_ram_bank_data_rreq,
      wr_a_i               => rams_2_ram_bank_data_int_wr,
      addr_b_i             => rams_2_ram_bank_adr_i,
      bwsel_b_i            => (others => '1'),
      data_b_i             => rams_2_ram_bank_data_ext_dat,
      data_b_o             => rams_2_ram_bank_data_dat_o,
      rd_b_i               => rams_2_ram_bank_data_rd_i,
      wr_b_i               => '0'
    );
  
  process (clk_i) begin
    if rising_edge(clk_i) then
      if rst_n_i = '0' then
        rams_2_ram_bank_data_rack <= '0';
      else
        rams_2_ram_bank_data_rack <= rams_2_ram_bank_data_rreq;
      end if;
    end if;
  end process;

  -- Memory rams_3_ram_bank
  process (adr_int, wr_adr_d0, rams_3_ram_bank_wr) begin
    if rams_3_ram_bank_wr = '1' then
      rams_3_ram_bank_adr_int <= wr_adr_d0(10 downto 2);
    else
      rams_3_ram_bank_adr_int <= adr_int(10 downto 2);
    end if;
  end process;
  rams_3_ram_bank_wreq <= rams_3_ram_bank_data_int_wr;
  rams_3_ram_bank_wr <= rams_3_ram_bank_wreq;
  rams_3_ram_bank_data_raminst: cheby_dpssram
    generic map (
      g_data_width         => 32,
      g_size               => 512,
      g_addr_width         => 9,
      g_dual_clock         => '0',
      g_use_bwsel          => '1'
    )
    port map (
      clk_a_i              => clk_i,
      clk_b_i              => clk_i,
      addr_a_i             => rams_3_ram_bank_adr_int,
      bwsel_a_i            => wr_sel_d0,
      data_a_i             => wr_dat_d0,
      data_a_o             => rams_3_ram_bank_data_int_dato,
      rd_a_i               => rams_3_ram_bank_data_rreq,
      wr_a_i               => rams_3_ram_bank_data_int_wr,
      addr_b_i             => rams_3_ram_bank_adr_i,
      bwsel_b_i            => (others => '1'),
      data_b_i             => rams_3_ram_bank_data_ext_dat,
      data_b_o             => rams_3_ram_bank_data_dat_o,
      rd_b_i               => rams_3_ram_bank_data_rd_i,
      wr_b_i               => '0'
    );
  
  process (clk_i) begin
    if rising_edge(clk_i) then
      if rst_n_i = '0' then
        rams_3_ram_bank_data_rack <= '0';
      else
        rams_3_ram_bank_data_rack <= rams_3_ram_bank_data_rreq;
      end if;
    end if;
  end process;

  -- Memory rams_4_ram_bank
  process (adr_int, wr_adr_d0, rams_4_ram_bank_wr) begin
    if rams_4_ram_bank_wr = '1' then
      rams_4_ram_bank_adr_int <= wr_adr_d0(10 downto 2);
    else
      rams_4_ram_bank_adr_int <= adr_int(10 downto 2);
    end if;
  end process;
  rams_4_ram_bank_wreq <= rams_4_ram_bank_data_int_wr;
  rams_4_ram_bank_wr <= rams_4_ram_bank_wreq;
  rams_4_ram_bank_data_raminst: cheby_dpssram
    generic map (
      g_data_width         => 32,
      g_size               => 512,
      g_addr_width         => 9,
      g_dual_clock         => '0',
      g_use_bwsel          => '1'
    )
    port map (
      clk_a_i              => clk_i,
      clk_b_i              => clk_i,
      addr_a_i             => rams_4_ram_bank_adr_int,
      bwsel_a_i            => wr_sel_d0,
      data_a_i             => wr_dat_d0,
      data_a_o             => rams_4_ram_bank_data_int_dato,
      rd_a_i               => rams_4_ram_bank_data_rreq,
      wr_a_i               => rams_4_ram_bank_data_int_wr,
      addr_b_i             => rams_4_ram_bank_adr_i,
      bwsel_b_i            => (others => '1'),
      data_b_i             => rams_4_ram_bank_data_ext_dat,
      data_b_o             => rams_4_ram_bank_data_dat_o,
      rd_b_i               => rams_4_ram_bank_data_rd_i,
      wr_b_i               => '0'
    );
  
  process (clk_i) begin
    if rising_edge(clk_i) then
      if rst_n_i = '0' then
        rams_4_ram_bank_data_rack <= '0';
      else
        rams_4_ram_bank_data_rack <= rams_4_ram_bank_data_rreq;
      end if;
    end if;
  end process;

  -- Memory rams_5_ram_bank
  process (adr_int, wr_adr_d0, rams_5_ram_bank_wr) begin
    if rams_5_ram_bank_wr = '1' then
      rams_5_ram_bank_adr_int <= wr_adr_d0(10 downto 2);
    else
      rams_5_ram_bank_adr_int <= adr_int(10 downto 2);
    end if;
  end process;
  rams_5_ram_bank_wreq <= rams_5_ram_bank_data_int_wr;
  rams_5_ram_bank_wr <= rams_5_ram_bank_wreq;
  rams_5_ram_bank_data_raminst: cheby_dpssram
    generic map (
      g_data_width         => 32,
      g_size               => 512,
      g_addr_width         => 9,
      g_dual_clock         => '0',
      g_use_bwsel          => '1'
    )
    port map (
      clk_a_i              => clk_i,
      clk_b_i              => clk_i,
      addr_a_i             => rams_5_ram_bank_adr_int,
      bwsel_a_i            => wr_sel_d0,
      data_a_i             => wr_dat_d0,
      data_a_o             => rams_5_ram_bank_data_int_dato,
      rd_a_i               => rams_5_ram_bank_data_rreq,
      wr_a_i               => rams_5_ram_bank_data_int_wr,
      addr_b_i             => rams_5_ram_bank_adr_i,
      bwsel_b_i            => (others => '1'),
      data_b_i             => rams_5_ram_bank_data_ext_dat,
      data_b_o             => rams_5_ram_bank_data_dat_o,
      rd_b_i               => rams_5_ram_bank_data_rd_i,
      wr_b_i               => '0'
    );
  
  process (clk_i) begin
    if rising_edge(clk_i) then
      if rst_n_i = '0' then
        rams_5_ram_bank_data_rack <= '0';
      else
        rams_5_ram_bank_data_rack <= rams_5_ram_bank_data_rreq;
      end if;
    end if;
  end process;

  -- Memory rams_6_ram_bank
  process (adr_int, wr_adr_d0, rams_6_ram_bank_wr) begin
    if rams_6_ram_bank_wr = '1' then
      rams_6_ram_bank_adr_int <= wr_adr_d0(10 downto 2);
    else
      rams_6_ram_bank_adr_int <= adr_int(10 downto 2);
    end if;
  end process;
  rams_6_ram_bank_wreq <= rams_6_ram_bank_data_int_wr;
  rams_6_ram_bank_wr <= rams_6_ram_bank_wreq;
  rams_6_ram_bank_data_raminst: cheby_dpssram
    generic map (
      g_data_width         => 32,
      g_size               => 512,
      g_addr_width         => 9,
      g_dual_clock         => '0',
      g_use_bwsel          => '1'
    )
    port map (
      clk_a_i              => clk_i,
      clk_b_i              => clk_i,
      addr_a_i             => rams_6_ram_bank_adr_int,
      bwsel_a_i            => wr_sel_d0,
      data_a_i             => wr_dat_d0,
      data_a_o             => rams_6_ram_bank_data_int_dato,
      rd_a_i               => rams_6_ram_bank_data_rreq,
      wr_a_i               => rams_6_ram_bank_data_int_wr,
      addr_b_i             => rams_6_ram_bank_adr_i,
      bwsel_b_i            => (others => '1'),
      data_b_i             => rams_6_ram_bank_data_ext_dat,
      data_b_o             => rams_6_ram_bank_data_dat_o,
      rd_b_i               => rams_6_ram_bank_data_rd_i,
      wr_b_i               => '0'
    );
  
  process (clk_i) begin
    if rising_edge(clk_i) then
      if rst_n_i = '0' then
        rams_6_ram_bank_data_rack <= '0';
      else
        rams_6_ram_bank_data_rack <= rams_6_ram_bank_data_rreq;
      end if;
    end if;
  end process;

  -- Memory rams_7_ram_bank
  process (adr_int, wr_adr_d0, rams_7_ram_bank_wr) begin
    if rams_7_ram_bank_wr = '1' then
      rams_7_ram_bank_adr_int <= wr_adr_d0(10 downto 2);
    else
      rams_7_ram_bank_adr_int <= adr_int(10 downto 2);
    end if;
  end process;
  rams_7_ram_bank_wreq <= rams_7_ram_bank_data_int_wr;
  rams_7_ram_bank_wr <= rams_7_ram_bank_wreq;
  rams_7_ram_bank_data_raminst: cheby_dpssram
    generic map (
      g_data_width         => 32,
      g_size               => 512,
      g_addr_width         => 9,
      g_dual_clock         => '0',
      g_use_bwsel          => '1'
    )
    port map (
      clk_a_i              => clk_i,
      clk_b_i              => clk_i,
      addr_a_i             => rams_7_ram_bank_adr_int,
      bwsel_a_i            => wr_sel_d0,
      data_a_i             => wr_dat_d0,
      data_a_o             => rams_7_ram_bank_data_int_dato,
      rd_a_i               => rams_7_ram_bank_data_rreq,
      wr_a_i               => rams_7_ram_bank_data_int_wr,
      addr_b_i             => rams_7_ram_bank_adr_i,
      bwsel_b_i            => (others => '1'),
      data_b_i             => rams_7_ram_bank_data_ext_dat,
      data_b_o             => rams_7_ram_bank_data_dat_o,
      rd_b_i               => rams_7_ram_bank_data_rd_i,
      wr_b_i               => '0'
    );
  
  process (clk_i) begin
    if rising_edge(clk_i) then
      if rst_n_i = '0' then
        rams_7_ram_bank_data_rack <= '0';
      else
        rams_7_ram_bank_data_rack <= rams_7_ram_bank_data_rreq;
      end if;
    end if;
  end process;

  -- Process for write requests.
  process (wr_adr_d0, wr_req_d0) begin
    rams_0_ram_bank_data_int_wr <= '0';
    rams_1_ram_bank_data_int_wr <= '0';
    rams_2_ram_bank_data_int_wr <= '0';
    rams_3_ram_bank_data_int_wr <= '0';
    rams_4_ram_bank_data_int_wr <= '0';
    rams_5_ram_bank_data_int_wr <= '0';
    rams_6_ram_bank_data_int_wr <= '0';
    rams_7_ram_bank_data_int_wr <= '0';
    case wr_adr_d0(14 downto 11) is
    when "0000" =>
      -- Memory rams_0_ram_bank
      rams_0_ram_bank_data_int_wr <= wr_req_d0;
      wr_ack_int <= wr_req_d0;
    when "0010" =>
      -- Memory rams_1_ram_bank
      rams_1_ram_bank_data_int_wr <= wr_req_d0;
      wr_ack_int <= wr_req_d0;
    when "0100" =>
      -- Memory rams_2_ram_bank
      rams_2_ram_bank_data_int_wr <= wr_req_d0;
      wr_ack_int <= wr_req_d0;
    when "0110" =>
      -- Memory rams_3_ram_bank
      rams_3_ram_bank_data_int_wr <= wr_req_d0;
      wr_ack_int <= wr_req_d0;
    when "1000" =>
      -- Memory rams_4_ram_bank
      rams_4_ram_bank_data_int_wr <= wr_req_d0;
      wr_ack_int <= wr_req_d0;
    when "1010" =>
      -- Memory rams_5_ram_bank
      rams_5_ram_bank_data_int_wr <= wr_req_d0;
      wr_ack_int <= wr_req_d0;
    when "1100" =>
      -- Memory rams_6_ram_bank
      rams_6_ram_bank_data_int_wr <= wr_req_d0;
      wr_ack_int <= wr_req_d0;
    when "1110" =>
      -- Memory rams_7_ram_bank
      rams_7_ram_bank_data_int_wr <= wr_req_d0;
      wr_ack_int <= wr_req_d0;
    when others =>
      wr_ack_int <= wr_req_d0;
    end case;
  end process;

  -- Process for read requests.
  process (adr_int, rams_0_ram_bank_data_int_dato, rd_req_int,
           rams_0_ram_bank_data_rack, rams_1_ram_bank_data_int_dato,
           rams_1_ram_bank_data_rack, rams_2_ram_bank_data_int_dato,
           rams_2_ram_bank_data_rack, rams_3_ram_bank_data_int_dato,
           rams_3_ram_bank_data_rack, rams_4_ram_bank_data_int_dato,
           rams_4_ram_bank_data_rack, rams_5_ram_bank_data_int_dato,
           rams_5_ram_bank_data_rack, rams_6_ram_bank_data_int_dato,
           rams_6_ram_bank_data_rack, rams_7_ram_bank_data_int_dato,
           rams_7_ram_bank_data_rack) begin
    -- By default ack read requests
    rd_dat_d0 <= (others => 'X');
    rams_0_ram_bank_data_rreq <= '0';
    rams_1_ram_bank_data_rreq <= '0';
    rams_2_ram_bank_data_rreq <= '0';
    rams_3_ram_bank_data_rreq <= '0';
    rams_4_ram_bank_data_rreq <= '0';
    rams_5_ram_bank_data_rreq <= '0';
    rams_6_ram_bank_data_rreq <= '0';
    rams_7_ram_bank_data_rreq <= '0';
    case adr_int(14 downto 11) is
    when "0000" =>
      -- Memory rams_0_ram_bank
      rd_dat_d0 <= rams_0_ram_bank_data_int_dato;
      rams_0_ram_bank_data_rreq <= rd_req_int;
      rd_ack_d0 <= rams_0_ram_bank_data_rack;
    when "0010" =>
      -- Memory rams_1_ram_bank
      rd_dat_d0 <= rams_1_ram_bank_data_int_dato;
      rams_1_ram_bank_data_rreq <= rd_req_int;
      rd_ack_d0 <= rams_1_ram_bank_data_rack;
    when "0100" =>
      -- Memory rams_2_ram_bank
      rd_dat_d0 <= rams_2_ram_bank_data_int_dato;
      rams_2_ram_bank_data_rreq <= rd_req_int;
      rd_ack_d0 <= rams_2_ram_bank_data_rack;
    when "0110" =>
      -- Memory rams_3_ram_bank
      rd_dat_d0 <= rams_3_ram_bank_data_int_dato;
      rams_3_ram_bank_data_rreq <= rd_req_int;
      rd_ack_d0 <= rams_3_ram_bank_data_rack;
    when "1000" =>
      -- Memory rams_4_ram_bank
      rd_dat_d0 <= rams_4_ram_bank_data_int_dato;
      rams_4_ram_bank_data_rreq <= rd_req_int;
      rd_ack_d0 <= rams_4_ram_bank_data_rack;
    when "1010" =>
      -- Memory rams_5_ram_bank
      rd_dat_d0 <= rams_5_ram_bank_data_int_dato;
      rams_5_ram_bank_data_rreq <= rd_req_int;
      rd_ack_d0 <= rams_5_ram_bank_data_rack;
    when "1100" =>
      -- Memory rams_6_ram_bank
      rd_dat_d0 <= rams_6_ram_bank_data_int_dato;
      rams_6_ram_bank_data_rreq <= rd_req_int;
      rd_ack_d0 <= rams_6_ram_bank_data_rack;
    when "1110" =>
      -- Memory rams_7_ram_bank
      rd_dat_d0 <= rams_7_ram_bank_data_int_dato;
      rams_7_ram_bank_data_rreq <= rd_req_int;
      rd_ack_d0 <= rams_7_ram_bank_data_rack;
    when others =>
      rd_ack_d0 <= rd_req_int;
    end case;
  end process;
end syn;
