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
    input [10:0] hitted_x,
    input [9:0] hitted_y,
    input [7:0] W_rom_data, //for testing, comment this statement
    input [7:0] W_rom_data_gold0, W_rom_data_gold1, W_rom_data_diamond0, W_rom_data_stone0,
    input [10:0] draw_x,
    input [9:0] draw_y,
    input [10:0] blkpos_x,
    input [9:0] blkpos_y,
    input [10:0] x9,x8,x7,x6,x5,x4,x3,x2,x1,x0,
    input [9:0] y9,y8,y7,y6,y5,y4,y3,y2,y1,y0,
    output reg [3:0] draw_r,
    output reg [3:0] draw_g,
    output reg [3:0] draw_b
    );
    reg [3:0] bg_r, bg_g, bg_b;
    reg [3:0] blk_r, blk_g, blk_b;
    reg [3:0] gold_r , gold_g , gold_b;
    reg [3:0] rope_r, rope_g, rope_b;
    //Draw border and background
    always @ *
    begin
    if (draw_x < 11'd10 | draw_x > 11'd1269 | draw_y < 10'd10 | draw_y > 10'd789)
        begin
            bg_r =  4'b1111;
            bg_g =  4'b1111;
            bg_b =  4'b1111;
        end
    else 
        begin
            bg_r = W_rom_data[7:5]*2;
            bg_g = W_rom_data[4:2]*2;
            bg_b = W_rom_data[1:0]*4;
  /*for testing, use the below ones*/
//            bg_r <=  4'b0000;
//            bg_g <=  4'b0000;
//            bg_b <=  4'b0000;
        end
    end

    //Draw Hook
    always @*
    begin
    if (draw_x >=blkpos_x & draw_x<=blkpos_x+11'd32 & draw_y >=blkpos_y & draw_y<=blkpos_y+10'd32)
        begin
            blk_r = 4'b1111;
            blk_g = 4'b1111;
            blk_b = 4'b1111;
        end
    else 
        begin
            blk_r = 4'b0000;
            blk_g = 4'b0000;
            blk_b = 4'b0000;
        end
    end
    
   //Draw gold
   always @*begin 
   if (draw_x >= x0 & draw_x<= x0 + 11'd59 & draw_y>=y0 & draw_y<= y0 + 10'd59)
         begin
             gold_r = W_rom_data_gold0[7:5]*2;
             gold_g = W_rom_data_gold0[4:2]*2;
             gold_b = W_rom_data_gold0[1:0]*4;
         end
   else if (draw_x >= x1 & draw_x<= x1 + 11'd59 & draw_y>=y1 & draw_y<= y1 + 10'd59)
            begin
               gold_r = W_rom_data_gold1[7:5]*2;
               gold_g = W_rom_data_gold1[4:2]*2;
               gold_b = W_rom_data_gold1[1:0]*4;
            end
   else if (draw_x >= x2 & draw_x<= x2 + 11'd39 & draw_y>=y2 & draw_y<= y2 + 10'd39)
            begin
               gold_r = W_rom_data_diamond0[7:5]*2;
               gold_g = W_rom_data_diamond0[4:2]*2;
               gold_b = W_rom_data_diamond0[1:0]*4;
            end  
   else if (draw_x >= x3 & draw_x<= x3 + 11'd79 & draw_y>=y3 & draw_y<= y3 + 10'd79)
            begin
               gold_r = W_rom_data_stone0[7:5]*2;
               gold_g = W_rom_data_stone0[4:2]*2;
               gold_b = W_rom_data_stone0[1:0]*4;
            end                 
   else begin
            gold_r = 4'b0000;
            gold_g = 4'b0000;
            gold_b = 4'b0000;
        end     
   end  
    
    //Draw Rope
    // parameter signed x_left = 10'd560, x_right = 10'd710;

    // reg signed [9:0] x_2, y_2
   parameter signed x_1 = 15'd635, y_1 = 15'd167; //position of miner, 15 bits to prevent overflow of ((y_0-y_1)*(x_2-x_1)) == ((x_0 - x_1)*(y_2-y_1))
   parameter signed r = 15'd10; //rope width
   reg signed [15:0] x_2, y_2,x_0,y_0;
   always @*
   begin
   x_2 = $signed({1'b0,blkpos_x+15'd16});
   y_2 = $signed({1'b0,blkpos_y});
   x_0 = $signed({1'b0,draw_x});
   y_0 = $signed({1'b0,draw_y});
   if (x_0>x_2 & x_0< x_1 & y_0 <= y_2) // In the left of miner
   begin
    if( ( (y_0-y_1)*(x_2-x_1) - (x_0 - x_1)*(y_2-y_1) )<=0  &  ( (y_0-y_1)*(x_2-x_1) - (x_0 - x_1-r)*(y_2-y_1) )>=0) // Between two lines
       begin
            rope_r = 4'b0000;
            rope_g = 4'b1111;
            rope_b = 4'b1111;
       end
       else
        begin
            rope_r = 4'b0000;
            rope_g = 4'b0000;
            rope_b = 4'b0000;
        end
   end
   else if ((x_0<x_2 & x_0> x_1 & y_0 <= y_2)) // In the right of miner
   begin
    if( ( (y_0-y_1)*(x_2-x_1) - (x_0 - x_1)*(y_2-y_1) )>=0  &  ( (y_0-y_1)*(x_2-x_1) - (x_0 - x_1 + r)*(y_2-y_1) )<=0) // Between two lines
       begin
            rope_r = 4'b0000;
            rope_g = 4'b1111;
            rope_b = 4'b1111;
       end
       else
        begin
            rope_r = 4'b0000;
            rope_g = 4'b0000;
            rope_b = 4'b0000;
        end
   end
   else // Outside the region
        begin
            rope_r = 4'b0000;
            rope_g = 4'b0000;
            rope_b = 4'b0000;
        end
  end
  
//  end
    //Assign Output
    always @*
    begin
        // draw gold
        if (gold_r > 4'b0000 | gold_g > 4'b0000 | gold_b > 4'b0000)
        begin
            draw_r = gold_r;
            draw_g = gold_g;
            draw_b = gold_b;
        end
        // draw hook
        else if (blk_r > 4'b0000 | blk_g > 4'b0000 | blk_b > 4'b0000)
        begin
            draw_r = blk_r;
            draw_g = blk_g;
            draw_b = blk_b;
        end
        // draw rope
        else if (rope_r > 4'b0000 | rope_g > 4'b0000 | rope_b > 4'b0000)
        begin
            draw_r = rope_r;
            draw_g = rope_g;
            draw_b = rope_b;
        end
        // draw backgroung
        else
        begin
            draw_r = bg_r;
            draw_g = bg_g;
            draw_b = bg_b;
        end
    end

    
endmodule
