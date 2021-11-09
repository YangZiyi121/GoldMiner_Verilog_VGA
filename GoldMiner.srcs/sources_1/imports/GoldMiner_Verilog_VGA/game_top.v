`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/31/2021 08:37:18 PM
// Design Name: 
// Module Name: game_top
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module game_top(
    input clk,rst,
    output  [3:0] pix_r,
    output  [3:0] pix_g,
    output  [3:0] pix_b,
    output hsync,
    output vsync
    );
    wire [10:0]curr_x;
    wire [9:0]curr_y;
    wire [3:0] pix_r_or,  pix_g_or,  pix_b_or;
    wire [10:0]blk_out_x;
    wire [9:0] blk_out_y;
    wire clkout;
    reg [1:0] counterColumn = 2'd0;
    reg [1:0] counterRow = 2'd0;
    reg clkdraw = 1'b0;
    wire [16:0] R_rom_addr;
    wire [10:0] R_rom_addr_gold0, R_rom_addr_gold1;
    wire [7:0] W_rom_data;
    wire [7:0] W_rom_data_gold0,W_rom_data_gold1;
    wire [10:0] x9,x8,x7,x6,x5,x4,x3,x2,x1,x0;
    wire [9:0] y9,y8,y7,y6,y5,y4,y3,y2,y1,y0;
    
    /* pixal clock instance */
    clk_wiz_0 pixClkIns (.clk_in1(clk), .clk_out1(clkout));
    
    /* store background image instance */
    //for testing, comment this instance
    blk_mem_gen_0 rom (.clka(clkout), .addra(R_rom_addr), .douta(W_rom_data));
    blk_mem_gen_1 rom_gold0 (.clka(clkout), .addra(R_rom_addr_gold0), .douta(W_rom_data_gold0));
    blk_mem_gen_1 rom_gold1 (.clka(clkout), .addra(R_rom_addr_gold1), .douta(W_rom_data_gold1));
    
    /* vga-out instance */
    vga_out vgainst (.clk(clkout), .rst(rst), .draw_r(pix_r_or), .draw_g(pix_g_or), .draw_b(pix_b_or),                  
    .pix_r(pix_r), .pix_g(pix_g), .pix_b(pix_b), .hsync(hsync), .vsync(vsync), .curr_x(curr_x), .curr_y(curr_y)); 
    
    /* get background figure instance*/
    //for testing, comment this instance
    bkg_figure bkg (.clk(clkout), .rst(rst), .curr_x(curr_x), .curr_y(curr_y), .addr(R_rom_addr));
    
    goldpositions gold_blk (.clk(clkout), .rst(rst), .curr_x(curr_x), .curr_y(curr_y),
    .addr0(R_rom_addr_gold0), .addr1(R_rom_addr_gold1),
    .x9(x9), .x8(x8), .x7(x7), .x6(x6), .x5(x5), .x4(x4), .x3(x3), .x2(x2), .x1(x1), .x0(x0),
    .y9(y9), .y8(y8), .y7(y7), .y6(y6), .y5(y5), .y4(y4), .y3(y3), .y2(y2), .y1(y1), .y0(y0));
    
    /* get hook moving positions*/
    hook_moving moveHook(.clk(clkout), .blkpos_x_out(blk_out_x), .blkpos_y_out(blk_out_y));
    
    /* drawcon instance*/ 
    //for testing, comment W_rom_data , use the second row   
    drawcon drawEnvironment (.W_rom_data(W_rom_data), .W_rom_data_gold0(W_rom_data_gold0),.W_rom_data_gold1(W_rom_data_gold1),
 .blkpos_x(blk_out_x), .blkpos_y(blk_out_y),.draw_x(curr_x), .draw_y(curr_y), .draw_r(pix_r_or), .draw_g(pix_g_or), .draw_b(pix_b_or), 
    .x9(x9), .x8(x8), .x7(x7), .x6(x6), .x5(x5), .x4(x4), .x3(x3), .x2(x2), .x1(x1), .x0(x0),
    .y9(y9), .y8(y8), .y7(y7), .y6(y6), .y5(y5), .y4(y4), .y3(y3), .y2(y2), .y1(y1), .y0(y0));
//    drawcon drawEnvironment (.W_rom_data_gold0(W_rom_data_gold0),.W_rom_data_gold1(W_rom_data_gold1),
//     .blkpos_x(blk_out_x), .blkpos_y(blk_out_y),.draw_x(curr_x), .draw_y(curr_y), 
//     .draw_r(pix_r_or), .draw_g(pix_g_or), .draw_b(pix_b_or),
//        .x9(x9), .x8(x8), .x7(x7), .x6(x6), .x5(x5), .x4(x4), .x3(x3), .x2(x2), .x1(x1), .x0(x0),
//        .y9(y9), .y8(y8), .y7(y7), .y6(y6), .y5(y5), .y4(y4), .y3(y3), .y2(y2), .y1(y1), .y0(y0));
    
    
     
endmodule
