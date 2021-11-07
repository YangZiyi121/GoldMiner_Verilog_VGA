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
    input [7:0] W_rom_data_gold0, W_rom_data_gold1,
    input [10:0] draw_x,
    input [9:0] draw_y,
    input [10:0] blkpos_x,
    input [9:0] blkpos_y,
    input [10:0] x9,x8,x7,x6,x5,x4,x3,x2,x1,x0,
    input [9:0] y9,y8,y7,y6,y5,y4,y3,y2,y1,y0,
    output [3:0] draw_r,
    output [3:0] draw_g,
    output [3:0] draw_b
    );
    
    reg [3:0] bg_r, bg_g, bg_b;
    reg [3:0] blk_r, blk_g, blk_b;
    reg [3:0] gold_r, gold_g, gold_b;

     
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
            blk_b <= 4'b1111;
        end
    else 
        begin
            blk_r <= 4'b0000;
            blk_g <= 4'b0000;
            blk_b <= 4'b0000;
        end
    end
    
   //Draw gold
   always @*begin
   if (draw_x >= x0 & draw_x<= x0 + 11'd39 & draw_y>=y0 & draw_y<= y0 + 10'd39)
       begin
           gold_r <= W_rom_data_gold0[7:5]*2;
           gold_g <= W_rom_data_gold0[4:2]*2;
           gold_b <= W_rom_data_gold0[1:0]*4;
       end
   else if (draw_x >= x1 & draw_x <= x1 + 11'd39 & draw_y >= y1 & draw_y<= y1 + 10'd39) 
        begin
           gold_r <= W_rom_data_gold1[7:5]*2;
           gold_g <= W_rom_data_gold1[4:2]*2;
           gold_b <= W_rom_data_gold1[1:0]*4;
       end     
   else 
        begin
            gold_r <= 4'b0000;
            gold_g <= 4'b0000;
            gold_b <= 4'b0000;
        end
    end      
  
    //Assign Output
    assign draw_r = (gold_r > 4'b0000 | gold_g > 4'b0000 | gold_b > 4'b0000)? gold_r :(blk_r > 4'b0000 | blk_g > 4'b0000 | blk_b > 4'b0000)? blk_r : bg_r;
    assign draw_g = (gold_r > 4'b0000 | gold_g > 4'b0000 | gold_b > 4'b0000)? gold_g :(blk_r > 4'b0000 | blk_g > 4'b0000 | blk_b > 4'b0000)? blk_g : bg_g;
    assign draw_b = (gold_r > 4'b0000 | gold_g > 4'b0000 | gold_b > 4'b0000)? gold_b :(blk_r > 4'b0000 | blk_g > 4'b0000 | blk_b > 4'b0000)? blk_b : bg_b;

    
endmodule
