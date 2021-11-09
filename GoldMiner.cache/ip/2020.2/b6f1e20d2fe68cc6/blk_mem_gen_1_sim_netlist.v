// Copyright 1986-2020 Xilinx, Inc. All Rights Reserved.
// --------------------------------------------------------------------------------
// Tool Version: Vivado v.2020.2 (lin64) Build 3064766 Wed Nov 18 09:12:47 MST 2020
// Date        : Tue Nov  9 15:58:16 2021
// Host        : rsws13.kaust.edu.sa running 64-bit Ubuntu 18.04.6 LTS
// Command     : write_verilog -force -mode funcsim -rename_top decalper_eb_ot_sdeen_pot_pi_dehcac_xnilix -prefix
//               decalper_eb_ot_sdeen_pot_pi_dehcac_xnilix_ blk_mem_gen_1_sim_netlist.v
// Design      : blk_mem_gen_1
// Purpose     : This verilog netlist is a functional simulation representation of the design and should not be modified
//               or synthesized. This netlist cannot be used for SDF annotated simulation.
// Device      : xc7a100tcsg324-1
// --------------------------------------------------------------------------------
`timescale 1 ps / 1 ps

(* CHECK_LICENSE_TYPE = "blk_mem_gen_1,blk_mem_gen_v8_4_4,{}" *) (* downgradeipidentifiedwarnings = "yes" *) (* x_core_info = "blk_mem_gen_v8_4_4,Vivado 2020.2" *) 
(* NotValidForBitStream *)
module decalper_eb_ot_sdeen_pot_pi_dehcac_xnilix
   (clka,
    addra,
    douta);
  (* x_interface_info = "xilinx.com:interface:bram:1.0 BRAM_PORTA CLK" *) (* x_interface_parameter = "XIL_INTERFACENAME BRAM_PORTA, MEM_SIZE 8192, MEM_WIDTH 32, MEM_ECC NONE, MASTER_TYPE OTHER, READ_LATENCY 1" *) input clka;
  (* x_interface_info = "xilinx.com:interface:bram:1.0 BRAM_PORTA ADDR" *) input [10:0]addra;
  (* x_interface_info = "xilinx.com:interface:bram:1.0 BRAM_PORTA DOUT" *) output [7:0]douta;

  wire [10:0]addra;
  wire clka;
  wire [7:0]douta;
  wire NLW_U0_dbiterr_UNCONNECTED;
  wire NLW_U0_rsta_busy_UNCONNECTED;
  wire NLW_U0_rstb_busy_UNCONNECTED;
  wire NLW_U0_s_axi_arready_UNCONNECTED;
  wire NLW_U0_s_axi_awready_UNCONNECTED;
  wire NLW_U0_s_axi_bvalid_UNCONNECTED;
  wire NLW_U0_s_axi_dbiterr_UNCONNECTED;
  wire NLW_U0_s_axi_rlast_UNCONNECTED;
  wire NLW_U0_s_axi_rvalid_UNCONNECTED;
  wire NLW_U0_s_axi_sbiterr_UNCONNECTED;
  wire NLW_U0_s_axi_wready_UNCONNECTED;
  wire NLW_U0_sbiterr_UNCONNECTED;
  wire [7:0]NLW_U0_doutb_UNCONNECTED;
  wire [10:0]NLW_U0_rdaddrecc_UNCONNECTED;
  wire [3:0]NLW_U0_s_axi_bid_UNCONNECTED;
  wire [1:0]NLW_U0_s_axi_bresp_UNCONNECTED;
  wire [10:0]NLW_U0_s_axi_rdaddrecc_UNCONNECTED;
  wire [7:0]NLW_U0_s_axi_rdata_UNCONNECTED;
  wire [3:0]NLW_U0_s_axi_rid_UNCONNECTED;
  wire [1:0]NLW_U0_s_axi_rresp_UNCONNECTED;

  (* C_ADDRA_WIDTH = "11" *) 
  (* C_ADDRB_WIDTH = "11" *) 
  (* C_ALGORITHM = "1" *) 
  (* C_AXI_ID_WIDTH = "4" *) 
  (* C_AXI_SLAVE_TYPE = "0" *) 
  (* C_AXI_TYPE = "1" *) 
  (* C_BYTE_SIZE = "9" *) 
  (* C_COMMON_CLK = "0" *) 
  (* C_COUNT_18K_BRAM = "1" *) 
  (* C_COUNT_36K_BRAM = "0" *) 
  (* C_CTRL_ECC_ALGO = "NONE" *) 
  (* C_DEFAULT_DATA = "0" *) 
  (* C_DISABLE_WARN_BHV_COLL = "0" *) 
  (* C_DISABLE_WARN_BHV_RANGE = "0" *) 
  (* C_ELABORATION_DIR = "./" *) 
  (* C_ENABLE_32BIT_ADDRESS = "0" *) 
  (* C_EN_DEEPSLEEP_PIN = "0" *) 
  (* C_EN_ECC_PIPE = "0" *) 
  (* C_EN_RDADDRA_CHG = "0" *) 
  (* C_EN_RDADDRB_CHG = "0" *) 
  (* C_EN_SAFETY_CKT = "0" *) 
  (* C_EN_SHUTDOWN_PIN = "0" *) 
  (* C_EN_SLEEP_PIN = "0" *) 
  (* C_EST_POWER_SUMMARY = "Estimated Power for IP     :     1.2196 mW" *) 
  (* C_FAMILY = "artix7" *) 
  (* C_HAS_AXI_ID = "0" *) 
  (* C_HAS_ENA = "0" *) 
  (* C_HAS_ENB = "0" *) 
  (* C_HAS_INJECTERR = "0" *) 
  (* C_HAS_MEM_OUTPUT_REGS_A = "1" *) 
  (* C_HAS_MEM_OUTPUT_REGS_B = "0" *) 
  (* C_HAS_MUX_OUTPUT_REGS_A = "0" *) 
  (* C_HAS_MUX_OUTPUT_REGS_B = "0" *) 
  (* C_HAS_REGCEA = "0" *) 
  (* C_HAS_REGCEB = "0" *) 
  (* C_HAS_RSTA = "0" *) 
  (* C_HAS_RSTB = "0" *) 
  (* C_HAS_SOFTECC_INPUT_REGS_A = "0" *) 
  (* C_HAS_SOFTECC_OUTPUT_REGS_B = "0" *) 
  (* C_INITA_VAL = "0" *) 
  (* C_INITB_VAL = "0" *) 
  (* C_INIT_FILE = "blk_mem_gen_1.mem" *) 
  (* C_INIT_FILE_NAME = "blk_mem_gen_1.mif" *) 
  (* C_INTERFACE_TYPE = "0" *) 
  (* C_LOAD_INIT_FILE = "1" *) 
  (* C_MEM_TYPE = "3" *) 
  (* C_MUX_PIPELINE_STAGES = "0" *) 
  (* C_PRIM_TYPE = "1" *) 
  (* C_READ_DEPTH_A = "1600" *) 
  (* C_READ_DEPTH_B = "1600" *) 
  (* C_READ_LATENCY_A = "1" *) 
  (* C_READ_LATENCY_B = "1" *) 
  (* C_READ_WIDTH_A = "8" *) 
  (* C_READ_WIDTH_B = "8" *) 
  (* C_RSTRAM_A = "0" *) 
  (* C_RSTRAM_B = "0" *) 
  (* C_RST_PRIORITY_A = "CE" *) 
  (* C_RST_PRIORITY_B = "CE" *) 
  (* C_SIM_COLLISION_CHECK = "ALL" *) 
  (* C_USE_BRAM_BLOCK = "0" *) 
  (* C_USE_BYTE_WEA = "0" *) 
  (* C_USE_BYTE_WEB = "0" *) 
  (* C_USE_DEFAULT_DATA = "0" *) 
  (* C_USE_ECC = "0" *) 
  (* C_USE_SOFTECC = "0" *) 
  (* C_USE_URAM = "0" *) 
  (* C_WEA_WIDTH = "1" *) 
  (* C_WEB_WIDTH = "1" *) 
  (* C_WRITE_DEPTH_A = "1600" *) 
  (* C_WRITE_DEPTH_B = "1600" *) 
  (* C_WRITE_MODE_A = "WRITE_FIRST" *) 
  (* C_WRITE_MODE_B = "WRITE_FIRST" *) 
  (* C_WRITE_WIDTH_A = "8" *) 
  (* C_WRITE_WIDTH_B = "8" *) 
  (* C_XDEVICEFAMILY = "artix7" *) 
  (* downgradeipidentifiedwarnings = "yes" *) 
  (* is_du_within_envelope = "true" *) 
  decalper_eb_ot_sdeen_pot_pi_dehcac_xnilix_blk_mem_gen_v8_4_4 U0
       (.addra(addra),
        .addrb({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0}),
        .clka(clka),
        .clkb(1'b0),
        .dbiterr(NLW_U0_dbiterr_UNCONNECTED),
        .deepsleep(1'b0),
        .dina({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0}),
        .dinb({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0}),
        .douta(douta),
        .doutb(NLW_U0_doutb_UNCONNECTED[7:0]),
        .eccpipece(1'b0),
        .ena(1'b0),
        .enb(1'b0),
        .injectdbiterr(1'b0),
        .injectsbiterr(1'b0),
        .rdaddrecc(NLW_U0_rdaddrecc_UNCONNECTED[10:0]),
        .regcea(1'b0),
        .regceb(1'b0),
        .rsta(1'b0),
        .rsta_busy(NLW_U0_rsta_busy_UNCONNECTED),
        .rstb(1'b0),
        .rstb_busy(NLW_U0_rstb_busy_UNCONNECTED),
        .s_aclk(1'b0),
        .s_aresetn(1'b0),
        .s_axi_araddr({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0}),
        .s_axi_arburst({1'b0,1'b0}),
        .s_axi_arid({1'b0,1'b0,1'b0,1'b0}),
        .s_axi_arlen({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0}),
        .s_axi_arready(NLW_U0_s_axi_arready_UNCONNECTED),
        .s_axi_arsize({1'b0,1'b0,1'b0}),
        .s_axi_arvalid(1'b0),
        .s_axi_awaddr({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0}),
        .s_axi_awburst({1'b0,1'b0}),
        .s_axi_awid({1'b0,1'b0,1'b0,1'b0}),
        .s_axi_awlen({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0}),
        .s_axi_awready(NLW_U0_s_axi_awready_UNCONNECTED),
        .s_axi_awsize({1'b0,1'b0,1'b0}),
        .s_axi_awvalid(1'b0),
        .s_axi_bid(NLW_U0_s_axi_bid_UNCONNECTED[3:0]),
        .s_axi_bready(1'b0),
        .s_axi_bresp(NLW_U0_s_axi_bresp_UNCONNECTED[1:0]),
        .s_axi_bvalid(NLW_U0_s_axi_bvalid_UNCONNECTED),
        .s_axi_dbiterr(NLW_U0_s_axi_dbiterr_UNCONNECTED),
        .s_axi_injectdbiterr(1'b0),
        .s_axi_injectsbiterr(1'b0),
        .s_axi_rdaddrecc(NLW_U0_s_axi_rdaddrecc_UNCONNECTED[10:0]),
        .s_axi_rdata(NLW_U0_s_axi_rdata_UNCONNECTED[7:0]),
        .s_axi_rid(NLW_U0_s_axi_rid_UNCONNECTED[3:0]),
        .s_axi_rlast(NLW_U0_s_axi_rlast_UNCONNECTED),
        .s_axi_rready(1'b0),
        .s_axi_rresp(NLW_U0_s_axi_rresp_UNCONNECTED[1:0]),
        .s_axi_rvalid(NLW_U0_s_axi_rvalid_UNCONNECTED),
        .s_axi_sbiterr(NLW_U0_s_axi_sbiterr_UNCONNECTED),
        .s_axi_wdata({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0}),
        .s_axi_wlast(1'b0),
        .s_axi_wready(NLW_U0_s_axi_wready_UNCONNECTED),
        .s_axi_wstrb(1'b0),
        .s_axi_wvalid(1'b0),
        .sbiterr(NLW_U0_sbiterr_UNCONNECTED),
        .shutdown(1'b0),
        .sleep(1'b0),
        .wea(1'b0),
        .web(1'b0));
endmodule
`pragma protect begin_protected
`pragma protect version = 1
`pragma protect encrypt_agent = "XILINX"
`pragma protect encrypt_agent_info = "Xilinx Encryption Tool 2020.2"
`pragma protect key_keyowner="Cadence Design Systems.", key_keyname="cds_rsa_key", key_method="rsa"
`pragma protect encoding = (enctype="BASE64", line_length=76, bytes=64)
`pragma protect key_block
QGLtnqZzRetDH6gCWT4Js6wuLlZfrNx/VJp3sfR2NF+cxypO5AxN0oDKLJJtmdrtE/ueNDg+Qf7Z
TqBNRojORA==

`pragma protect key_keyowner="Synopsys", key_keyname="SNPS-VCS-RSA-2", key_method="rsa"
`pragma protect encoding = (enctype="BASE64", line_length=76, bytes=128)
`pragma protect key_block
B6Ger3hRvfjHkaJ+W8639Kl3TzC9TogLuklOXEiMNdc4Im+DjEUzxb3DKlzu0VW3zxZqjJ3+wsW/
LnRmPCESi5Y9eRJaLFXg79EMfoj4X+nTdHAP6yCfltBADKegZ12gpnB/8ey5yn2KA74LUtPC7jna
iyjqSfsWLGnz6UdXzwk=

`pragma protect key_keyowner="Aldec", key_keyname="ALDEC15_001", key_method="rsa"
`pragma protect encoding = (enctype="BASE64", line_length=76, bytes=256)
`pragma protect key_block
BX+DxgMPRyZbYojCUR9Sk8Lq+3ZigBz4yMFHQkmurfdfDzyTPJCE827eGiPyTenK1QPVhEtf9g06
0BFXq/0COPuU1BWJwdkz1c4dE6/exDwhvEh+hPx3vRY6z8fDEf6aGVIXrHDvrmddehe7yMSIpo+k
aXHR06EEdfHCFY4TggYwhcJVXjkE+ApsVuyfmEfPmYjo8hCWyQyBsUWIOY03q1+MvUjjsmTwgs9g
fh5MY9ToaLfoJxPKdCpsqrBX4LJ+VDGFlAqIcqHTE2jCmPiToZAFXB7fzf1wDjFCBlJyFVDBGi0i
m+CouLSb7X1mvVhdDZgNrZDJMV688Bu3o54vew==

`pragma protect key_keyowner="ATRENTA", key_keyname="ATR-SG-2015-RSA-3", key_method="rsa"
`pragma protect encoding = (enctype="BASE64", line_length=76, bytes=256)
`pragma protect key_block
DaIU/Ddc8USbZ2mURzujJDWDH1JbHl5tFVOOQ2aVaUPIA71yyE38OXVLEtF8rNmujYH30nEeQ+FV
LVJ16aaHw+iiuaqorTM3K5KLohVlN+WlcEtSXHuPNHjw8ddqtzpaX7pH1zqZH+YmfCL5oaNLqDH4
rkBnUl0/Gm/hzSwKjYhXGQFYQ+gGP99OjXakzrAqZzp/Iq4gt+Z5902/JV9thd/isHQImJ0QyK8M
EKM579iPAfXGes2mbiNYHcvDmSPYmW1zlhOE++N1EKeea7j/msnKeyhlC+hGE4Xfn4TVvqgQexCT
rp/wS/MosY6WH1aKFQlFH2hEppA7KXUaQlvG+w==

`pragma protect key_keyowner="Mentor Graphics Corporation", key_keyname="MGC-VELOCE-RSA", key_method="rsa"
`pragma protect encoding = (enctype="BASE64", line_length=76, bytes=128)
`pragma protect key_block
XmWoAt4X8hrCJ5yTyug4ajJW5UhfkLNibzjihWzZ4Cr9hQSvWZoTc8rjGsLPbz6Le+/9iI5KxecS
eR0wiAO+G2IkwhZgVBeZdKoFnlnTVAyLjk9wMAFXNyJZM6b1NDbfXlPcUsC6JePvPlwwdWknkSsC
r3KvgkWAS+O3xvRmaNw=

`pragma protect key_keyowner="Mentor Graphics Corporation", key_keyname="MGC-VERIF-SIM-RSA-2", key_method="rsa"
`pragma protect encoding = (enctype="BASE64", line_length=76, bytes=256)
`pragma protect key_block
Hw3Y+rShKrXiUViyNU1/O2qv6TgheLHBnFMj1i9MUGrHYqh9pLfLYUgWR7S2vj4jv4S+Ks0BpP4p
dKEqVAFmTCfQNEUHaVcFPkOHgig6L4mhLY6HUUKJoRgiQepgLi/W3V+ZZPQSQFkB3CU4MsJzhXvR
yLcpDriZy8cnAHD87Zi5DrNGBzj3kigJeM0du6lCQbxtF5aEdoaNP+YTnIFtcqYhoYnswQlYt0sV
HKgFA8VzqzL5WYnpH7+1IKmFkJBHkyqHCa9wPK0qCKnxkuDj70YzPVqQ+cocdKU+/gNdpCOdZlci
F2HTxrgfrXndJru3TiDqu4UavqAe0MNuFp3t0w==

`pragma protect key_keyowner="Real Intent", key_keyname="RI-RSA-KEY-1", key_method="rsa"
`pragma protect encoding = (enctype="BASE64", line_length=76, bytes=256)
`pragma protect key_block
XPVggoWL6aXz+MpODTOZhEUQDa0vfEnUDaYeEHXm2vGyqKJujN2c/FFAFBeBYdJATLsIsQ+BqoPc
pBbcFYXDBfOtFIW2dH6Y1OoD65KyJ/hAq8coa21kFgq4hFat5vzZ2iIfkCpTUr4vDZO7Xne8cZO9
WsHffoTCt5rS59wWm2b8I5R8Eh2TUbQg3RCyrcnD66cvcEnlXe1CNMQ4/loVJpA4IBinBf820Wjc
vw2fZbGI0jXC+ACSHOviH63Xwmn+aRV5Ppkup7IYoon/ieKapRQeASu3TTY37xSBXiInSdtMTzJ6
+4GfO4eSHVriCk/sWbuTBzfRzoSShrnHjzz5LA==

`pragma protect key_keyowner="Xilinx", key_keyname="xilinxt_2020_08", key_method="rsa"
`pragma protect encoding = (enctype="BASE64", line_length=76, bytes=256)
`pragma protect key_block
L78XuiswVcgO2gtebzL7SA9BC/jJGAM0v6S9pzmyqL+QYzRneiYeGyDmsW33jEVVSTuNjTXkBLY7
yTOKQruatwe4V0OLi6174saSAmPgerSV1GyLP7KhmusLV/N61avC9TPam+tekhKeE0tds4EnJ3et
4JdLh+SE4Z4pcuqCjB5MFneIYKKWDx7siU6oesAQtoSJOesfMchX63MhOjOHFP/ch+1gHv3T45hg
IGF7V7TrdREVE4f9631tlVJ1o2Dypsmo/76Itz5WCGlTMjAnWXN8IXxKN+PZ3dyt1wjrZm2P/td+
xiGszFnSLrRvw/HferwtSmRx8q0fiHZ88roGTw==

`pragma protect key_keyowner="Metrics Technologies Inc.", key_keyname="DSim", key_method="rsa"
`pragma protect encoding = (enctype="BASE64", line_length=76, bytes=256)
`pragma protect key_block
kDX5kq2QEe25429T6vQqBCFvV1McKTJRYfK99ymVNK2GGvGLXSzgwJHwB2fj9rM0wme3zYYY0vQR
x+9F4L7KLlOVY6qY3LB59uDzyXBI3mMZaS905HXHJkdZHWtQWpfHhl27LqL+8FSluaD6F+KFfYOV
CwIOVuCIp/XjxFXpNBik7YiPt4kHOlDA97IXNLnYUn/g1csGqeNWce4UTne50ggWvLYGbTFGmTjT
N67TpUiGRVRCSv8Tax72GWFIMFZk3Tlp68ZUSQEybZMWX1U9XdMdtxfvNGhf8mi5jQJ2SupSzKu4
T/+53IN9T8aLePAiGBKKG1ZBj4y1ZyYA7XYvjw==

`pragma protect data_method = "AES128-CBC"
`pragma protect encoding = (enctype = "BASE64", line_length = 76, bytes = 17760)
`pragma protect data_block
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
`pragma protect end_protected
`ifndef GLBL
`define GLBL
`timescale  1 ps / 1 ps

module glbl ();

    parameter ROC_WIDTH = 100000;
    parameter TOC_WIDTH = 0;
    parameter GRES_WIDTH = 10000;
    parameter GRES_START = 10000;

//--------   STARTUP Globals --------------
    wire GSR;
    wire GTS;
    wire GWE;
    wire PRLD;
    wire GRESTORE;
    tri1 p_up_tmp;
    tri (weak1, strong0) PLL_LOCKG = p_up_tmp;

    wire PROGB_GLBL;
    wire CCLKO_GLBL;
    wire FCSBO_GLBL;
    wire [3:0] DO_GLBL;
    wire [3:0] DI_GLBL;
   
    reg GSR_int;
    reg GTS_int;
    reg PRLD_int;
    reg GRESTORE_int;

//--------   JTAG Globals --------------
    wire JTAG_TDO_GLBL;
    wire JTAG_TCK_GLBL;
    wire JTAG_TDI_GLBL;
    wire JTAG_TMS_GLBL;
    wire JTAG_TRST_GLBL;

    reg JTAG_CAPTURE_GLBL;
    reg JTAG_RESET_GLBL;
    reg JTAG_SHIFT_GLBL;
    reg JTAG_UPDATE_GLBL;
    reg JTAG_RUNTEST_GLBL;

    reg JTAG_SEL1_GLBL = 0;
    reg JTAG_SEL2_GLBL = 0 ;
    reg JTAG_SEL3_GLBL = 0;
    reg JTAG_SEL4_GLBL = 0;

    reg JTAG_USER_TDO1_GLBL = 1'bz;
    reg JTAG_USER_TDO2_GLBL = 1'bz;
    reg JTAG_USER_TDO3_GLBL = 1'bz;
    reg JTAG_USER_TDO4_GLBL = 1'bz;

    assign (strong1, weak0) GSR = GSR_int;
    assign (strong1, weak0) GTS = GTS_int;
    assign (weak1, weak0) PRLD = PRLD_int;
    assign (strong1, weak0) GRESTORE = GRESTORE_int;

    initial begin
	GSR_int = 1'b1;
	PRLD_int = 1'b1;
	#(ROC_WIDTH)
	GSR_int = 1'b0;
	PRLD_int = 1'b0;
    end

    initial begin
	GTS_int = 1'b1;
	#(TOC_WIDTH)
	GTS_int = 1'b0;
    end

    initial begin 
	GRESTORE_int = 1'b0;
	#(GRES_START);
	GRESTORE_int = 1'b1;
	#(GRES_WIDTH);
	GRESTORE_int = 1'b0;
    end

endmodule
`endif
