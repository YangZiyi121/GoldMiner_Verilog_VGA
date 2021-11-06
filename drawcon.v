`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/01/2021 10:41:32 AM
// Design Name: 
// Module Name: drawcon
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


module drawcon(
    input [7:0] W_rom_data, //for testing, comment this statement
    input [10:0] draw_x,
    input [9:0] draw_y,
    input [10:0] blkpos_x,
    input [9:0] blkpos_y,
    output [3:0] draw_r,
    output [3:0] draw_g,
    output [3:0] draw_b
    );
    
    reg [3:0] bg_r, bg_g, bg_b;
    reg [3:0] blk_r, blk_g, blk_b;
    
    //Draw border and background
    always @ *
    begin
    if (draw_x < 11'd10 | draw_x > 11'd1269 | draw_y < 10'd10 | draw_y > 10'd789)
        begin
            bg_r <=  4'b1111;
            bg_g <=  4'b1111;
            bg_b <=  4'b1111;
        end
    else 
        begin
            bg_r <= W_rom_data[7:5]*2;
            bg_g <= W_rom_data[4:2]*2;
            bg_b <= W_rom_data[1:0]*4;
  /*for testing, use the below ones*/
//            bg_r <=  4'b0000;
//            bg_g <=  4'b0000;
//            bg_b <=  4'b0000;
        end
    end

    //Draw block
    always @*
    begin
    if (draw_x >=blkpos_x & draw_x<=blkpos_x+11'd32 & draw_y >=blkpos_y & draw_y<=blkpos_y+10'd32)
        begin
            blk_r <= 4'b1111;
            blk_g <= 4'b1111;
            blk_b <= 4'b0000;
        end
    else 
        begin
            blk_r <= 4'b0000;
            blk_g <= 4'b0000;
            blk_b <= 4'b0000;
        end
    end
    
    //Assign Output
    assign draw_r = (blk_r > 4'b0000 | blk_g > 4'b0000 | blk_b > 4'b0000)? blk_r : bg_r;
    assign draw_g = (blk_r > 4'b0000 | blk_g > 4'b0000 | blk_b > 4'b0000)? blk_g : bg_g;
    assign draw_b = (blk_r > 4'b0000 | blk_g > 4'b0000 | blk_b > 4'b0000)? blk_b : bg_b;

    
endmodule
