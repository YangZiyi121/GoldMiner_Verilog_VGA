timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/01/2021 10:41:32 AM
// Design Name: GoldMiner
// Module Name: drawcon
// Project Name: GoldMiner
// Target Devices: 
// Tool Versions: 
// Description: 
// This module output the RGB data to be drawn on current drawing pixel
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
    input [7:0] W_rom_data,W_rom_data_end, 
    input [7:0] W_rom_data_gold0, W_rom_data_gold1, W_rom_data_gold2, W_rom_data_gold3, W_rom_data_gold4,
     W_rom_data_diamond5,W_rom_data_diamond6, W_rom_data_stone7, W_rom_data_stone8, W_rom_data_stone9,
     W_rom_data_hook,
    input [10:0] draw_x,
    input [9:0] draw_y,
    input [10:0] blkpos_x,
    input [9:0] blkpos_y,
    input [10:0] x9,x8,x7,x6,x5,x4,x3,x2,x1,x0,
    input [9:0] y9,y8,y7,y6,y5,y4,y3,y2,y1,y0,
    input done_game,
    output reg [3:0] draw_r,
    output reg [3:0] draw_g,
    output reg [3:0] draw_b
    );
    reg [3:0] bg_r, bg_g, bg_b;
    reg [3:0] bg_r_end, bg_g_end, bg_b_end;
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
        end
    end
    //Draw border and end-background
    always @ *
    begin
    if (done_game == 1) begin
    if (draw_x < 11'd10 | draw_x > 11'd1269 | draw_y < 10'd10 | draw_y > 10'd789)
        begin
            bg_r_end =  4'b1111;
            bg_g_end =  4'b1111;
            bg_b_end =  4'b1111;
        end
    else 
        begin
            bg_r_end = W_rom_data_end[7:5]*2;
            bg_g_end = W_rom_data_end[4:2]*2;
            bg_b_end = W_rom_data_end[1:0]*4;
        end
    end
    end
    //Draw Hook
    always @*
    begin
    if (draw_x >=blkpos_x & draw_x<=blkpos_x+11'd32 & draw_y >=blkpos_y & draw_y<=blkpos_y+10'd32)
        begin
        if (W_rom_data_hook == 8'b11111111)
        begin
            blk_r = 4'b0000;
            blk_g = 4'b0000;
            blk_b = 4'b0000;
        end
        else 
        begin
            blk_r =  W_rom_data_hook[7:5]*2;
            blk_g =  W_rom_data_hook[4:2]*2;
            blk_b =  W_rom_data_hook[1:0]*4;
        end
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
   else if (draw_x >= x2 & draw_x<= x2 + 11'd59 & draw_y>=y2 & draw_y<= y2 + 10'd59)
            begin
               gold_r = W_rom_data_gold2[7:5]*2;
               gold_g = W_rom_data_gold2[4:2]*2;
               gold_b = W_rom_data_gold2[1:0]*4;
            end  
   else if (draw_x >= x3 & draw_x<= x3 + 11'd59 & draw_y>=y3 & draw_y<= y3 + 10'd59)
            begin
               gold_r = W_rom_data_gold3[7:5]*2;
               gold_g = W_rom_data_gold3[4:2]*2;
               gold_b = W_rom_data_gold3[1:0]*4;
            end    
  else if (draw_x >= x4 & draw_x<= x4 + 11'd59 & draw_y>=y4 & draw_y<= y4 + 10'd59)
            begin
               gold_r = W_rom_data_gold4[7:5]*2;
               gold_g = W_rom_data_gold4[4:2]*2;
               gold_b = W_rom_data_gold4[1:0]*4;
            end    
  else if (draw_x >= x5 & draw_x<= x5 + 11'd39 & draw_y>=y5 & draw_y<= y5 + 10'd39)
            begin
               gold_r = W_rom_data_diamond5[7:5]*2;
               gold_g = W_rom_data_diamond5[4:2]*2;
               gold_b = W_rom_data_diamond5[1:0]*4;
            end  
    
 else if (draw_x >= x6 & draw_x<= x6 + 11'd39 & draw_y>=y6 & draw_y<= y6 + 10'd39)
            begin
               gold_r = W_rom_data_diamond6[7:5]*2;
               gold_g = W_rom_data_diamond6[4:2]*2;
               gold_b = W_rom_data_diamond6[1:0]*4;
            end   
            
 else if (draw_x >= x7 & draw_x<= x7 + 11'd79 & draw_y>=y7 & draw_y<= y7 + 10'd79)
            begin
               gold_r =  W_rom_data_stone7[7:5]*2;
               gold_g =  W_rom_data_stone7[4:2]*2;
               gold_b =  W_rom_data_stone7[1:0]*4;
            end  
                       
 else if (draw_x >= x8 & draw_x<= x8 + 11'd79 & draw_y>=y8 & draw_y<= y8 + 10'd79)
            begin
               gold_r =  W_rom_data_stone8[7:5]*2;
               gold_g =  W_rom_data_stone8[4:2]*2;
               gold_b =  W_rom_data_stone8[1:0]*4;
            end    
             
else if (draw_x >= x9 & draw_x<= x9 + 11'd79 & draw_y>=y9 & draw_y<= y9 + 10'd79)
            begin
               gold_r =  W_rom_data_stone9[7:5]*2;
               gold_g =  W_rom_data_stone9[4:2]*2;
               gold_b =  W_rom_data_stone9[1:0]*4;
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
   parameter signed r = 15'd7; //rope width
   reg signed [15:0] x_2, y_2,x_0,y_0;
   always @*
   begin
   x_2 = $signed({1'b0,blkpos_x+15'd10});
   y_2 = $signed({1'b0,blkpos_y});
   x_0 = $signed({1'b0,draw_x});
   y_0 = $signed({1'b0,draw_y});
   if (x_0>x_2 & x_0< x_1 & y_0 <= y_2) // In the left of miner
   begin
    if( ( (y_0-y_1)*(x_2-x_1) - (x_0 - x_1)*(y_2-y_1) )<=0  &  ( (y_0-y_1)*(x_2-x_1) - (x_0 - x_1-r)*(y_2-y_1) )>=0) // Between two lines
       begin
            rope_r = 4'b1001;
            rope_g = 4'b1001;
            rope_b = 4'b0110;
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
            rope_r = 4'b1001;
            rope_g = 4'b1001;
            rope_b = 4'b0110;
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
        if(done_game == 1) begin
            draw_r = bg_r_end;
            draw_g = bg_g_end;
            draw_b = bg_b_end;
        end 
        
        else begin   
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
    end
endmodule
