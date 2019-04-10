#!/bin/sh

GHDL=${GHDL:-ghdl}
GHDL_FLAGS=--std=08
CHEBY=${CHEBY:-../../proto/cheby.py}

set -e

build_infra()
{
 $GHDL -a $GHDL_FLAGS wishbone_pkg.vhd
 $GHDL -a $GHDL_FLAGS wbgen2_pkg.vhd
 $GHDL -a $GHDL_FLAGS axi4_tb_pkg.vhdl
 $GHDL -a $GHDL_FLAGS wb_tb_pkg.vhdl
 $GHDL -a $GHDL_FLAGS cernbe_tb_pkg.vhdl
 $GHDL -a $GHDL_FLAGS dpssram.vhdl
 $GHDL -a $GHDL_FLAGS block1_axi4.vhdl
 $GHDL -a $GHDL_FLAGS block1_wb.vhdl
}

build_axi4()
{
 echo "## Testing AXI4"

 sed -e '/bus:/s/xxx/axi4-lite-32/' -e '/name:/s/NAME/axi4/' < all1_xxx.cheby > all1_axi4.cheby
 $CHEBY --gen-hdl=all1_axi4.vhdl -i all1_axi4.cheby
 $GHDL -a $GHDL_FLAGS all1_axi4.vhdl
 $GHDL -a $GHDL_FLAGS all1_axi4_tb.vhdl
 $GHDL --elab-run $GHDL_FLAGS all1_axi4_tb --assert-level=error --wave=all1_axi4_tb.ghw
}

build_wb()
{
 echo "## Testing WB"

 # Simple test.
 # TODO: check strobe
 #       check wire + strobe read
  sed -e '/bus:/s/BUS/wb-32-be/' -e '/name:/s/NAME/wb/' < reg2_xxx.cheby > reg2_wb.cheby
 $CHEBY --gen-hdl=reg2_wb.vhdl -i reg2_wb.cheby
 $GHDL -a $GHDL_FLAGS reg2_wb.vhdl
 $GHDL -a $GHDL_FLAGS reg2_wb_tb.vhdl
 $GHDL --elab-run $GHDL_FLAGS --std=08 reg2_wb_tb --stop-time=1us

  sed -e '/bus:/s/xxx/wb-32-be/' -e '/name:/s/NAME/wb/' < all1_xxx.cheby > all1_wb.cheby
 $CHEBY --gen-hdl=all1_wb.vhdl -i all1_wb.cheby
 $GHDL -a $GHDL_FLAGS all1_wb.vhdl
 $GHDL -a $GHDL_FLAGS all1_wb_tb.vhdl
 $GHDL --elab-run $GHDL_FLAGS all1_wb_tb --assert-level=error --wave=all1_wb_tb.ghw
}

build_cernbe()
{
 echo "## Testing CERN-BE"

 sed -e '/bus:/s/xxx/cern-be-vme-32/' -e '/name:/s/NAME/cernbe/' < all1_xxx.cheby > all1_cernbe.cheby
 $CHEBY --gen-hdl=all1_cernbe.vhdl -i all1_cernbe.cheby
 $GHDL -a $GHDL_FLAGS all1_cernbe.vhdl
 $GHDL -a $GHDL_FLAGS all1_cernbe_tb.vhdl
 $GHDL --elab-run $GHDL_FLAGS all1_cernbe_tb --assert-level=error --wave=all1_cernbe_tb.ghw
}

build_infra
build_wb
build_axi4
build_cernbe

echo "SUCCESS"
