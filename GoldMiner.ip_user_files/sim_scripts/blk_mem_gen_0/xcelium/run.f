-makelib xcelium_lib/xpm -sv \
  "/sw/workstations/apps/linux-ubuntu18.04-ivybridge/xilinx/2020.2/gcc-7.5.0/egagsozgixafjmnittzgqtr2zi55uxhw/Vivado/2020.2/data/ip/xpm/xpm_memory/hdl/xpm_memory.sv" \
-endlib
-makelib xcelium_lib/xpm \
  "/sw/workstations/apps/linux-ubuntu18.04-ivybridge/xilinx/2020.2/gcc-7.5.0/egagsozgixafjmnittzgqtr2zi55uxhw/Vivado/2020.2/data/ip/xpm/xpm_VCOMP.vhd" \
-endlib
-makelib xcelium_lib/blk_mem_gen_v8_4_4 \
  "../../../ipstatic/simulation/blk_mem_gen_v8_4.v" \
-endlib
-makelib xcelium_lib/xil_defaultlib \
  "../../../../GoldMiner.gen/sources_1/ip/blk_mem_gen_0/sim/blk_mem_gen_0.v" \
-endlib
-makelib xcelium_lib/xil_defaultlib \
  glbl.v
-endlib

