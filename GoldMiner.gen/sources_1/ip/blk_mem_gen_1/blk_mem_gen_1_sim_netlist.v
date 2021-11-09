// Copyright 1986-2020 Xilinx, Inc. All Rights Reserved.
// --------------------------------------------------------------------------------
// Tool Version: Vivado v.2020.2 (lin64) Build 3064766 Wed Nov 18 09:12:47 MST 2020
// Date        : Tue Nov  9 15:58:17 2021
// Host        : rsws13.kaust.edu.sa running 64-bit Ubuntu 18.04.6 LTS
// Command     : write_verilog -force -mode funcsim
//               /home/xinj/Desktop/GoldMiner/GoldMiner.gen/sources_1/ip/blk_mem_gen_1/blk_mem_gen_1_sim_netlist.v
// Design      : blk_mem_gen_1
// Purpose     : This verilog netlist is a functional simulation representation of the design and should not be modified
//               or synthesized. This netlist cannot be used for SDF annotated simulation.
// Device      : xc7a100tcsg324-1
// --------------------------------------------------------------------------------
`timescale 1 ps / 1 ps

(* CHECK_LICENSE_TYPE = "blk_mem_gen_1,blk_mem_gen_v8_4_4,{}" *) (* downgradeipidentifiedwarnings = "yes" *) (* x_core_info = "blk_mem_gen_v8_4_4,Vivado 2020.2" *) 
(* NotValidForBitStream *)
module blk_mem_gen_1
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
  blk_mem_gen_1_blk_mem_gen_v8_4_4 U0
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
`pragma protect encoding = (enctype = "BASE64", line_length = 76, bytes = 17744)
`pragma protect data_block
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
U5t3ybRMXsJsDiP5ivBbXSA=
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
