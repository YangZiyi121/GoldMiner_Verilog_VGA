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
    wire [7:0] W_rom_data;
    /* pixal clock instance */
    clk_wiz_0 pixClkIns (.clk_in1(clk), .clk_out1(clkout));
    
    /* store background image instance */
    //for testing, comment this instance
    blk_mem_gen_0 rom (.clka(clkout), .addra(R_rom_addr), .douta(W_rom_data));
    
    /* vga-out instance */
    vga_out vgainst (.clk(clkout), .rst(rst), .draw_r(pix_r_or), .draw_g(pix_g_or), .draw_b(pix_b_or),                  
    .pix_r(pix_r), .pix_g(pix_g), .pix_b(pix_b), .hsync(hsync), .vsync(vsync), .curr_x(curr_x), .curr_y(curr_y)); 
    
    /* get background figure instance*/
    //for testing, comment this instance
    bkg_figure bkg (.clk(clkout), .rst(rst), .curr_x(curr_x), .curr_y(curr_y), .addr(R_rom_addr));
    
    /* get hook moving positions*/
    hook_moving moveHook(.clk(clkout), .blkpos_x_out(blk_out_x), .blkpos_y_out(blk_out_y));
    
    /* drawcon instance*/ 
    //for testing, delete comment W_rom_data , use the second row   
    drawcon drawEnvironment (.W_rom_data(W_rom_data), .blkpos_x(blk_out_x), .blkpos_y(blk_out_y),.draw_x(curr_x), .draw_y(curr_y), .draw_r(pix_r_or), .draw_g(pix_g_or), .draw_b(pix_b_or));
    //drawcon drawEnvironment ( .blkpos_x(blk_out_x), .blkpos_y(blk_out_y),.draw_x(curr_x), .draw_y(curr_y), .draw_r(pix_r_or), .draw_g(pix_g_or), .draw_b(pix_b_or));  
endmodule
