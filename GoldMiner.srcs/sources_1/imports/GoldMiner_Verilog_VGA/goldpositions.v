`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/06/2021 07:51:25 PM
// Design Name: 
// Module Name: goldpositions
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


module goldpositions(
    input clk,
    input rst,
    input state,
    input [10:0] blk_x,
    input [9:0] blk_y,
    input [10:0] hitted_x,
    input [9:0] hitted_y,
    input [10:0] curr_x,
    input [9:0] curr_y,
    output reg [10:0] x9,x8,x7,x6,x5,x4,x3,x2,x1,x0,
    output reg [9:0] y9,y8,y7,y6,y5,y4,y3,y2,y1,y0,
    output reg [10:0] addr0, addr1
    );
    parameter waving = 2'b00, stretching = 2'b01, hitting = 2'b10, missing = 2'b11;
    /*goldPosition step*/
    reg [6:0] x_step = 7'd126;
    reg [6:0] y_step = 7'd108;
    
    /*initial position of gold*/
    always@*begin
    if (state == hitting & hitted_x == x0 & hitted_y == y0) begin
         x0 = blk_x;  y0 = blk_y;
     end
     else if (state == waving & hitted_x == x0 & hitted_y == y0) begin
         x0 = 11'd11111111111;  y0 = 10'd1111111111;
     end
     else begin
     x0 = 2 * x_step + 11'd10;  y0 = 4 * y_step + 10'd10;//(2, 4)
     end
     
     if (state == hitting & hitted_x == x1 & hitted_y == y1) begin 
      x1 = blk_x;  y1 = blk_y;
     end
     else if (state == waving & hitted_x == x1 & hitted_y == y1) begin
         x1 = 11'd11111111111;  y1 = 10'd1111111111;
     end
     else begin
     x1 = 1 * x_step + 11'd10;  y1 = 3 * y_step + 10'd10;//(1,3)
     end
     
     x2 = 7 * x_step + 11'd10;  y2 = 1 * y_step + 10'd10;//(7,1)
     x3 = 8 * x_step + 11'd10;  y3 = 2 * y_step + 10'd10;//(8,2)
     x4 = 5 * x_step + 11'd10;  y4 = 4 * y_step + 10'd10;//(5,4)
     x5 = 6 * x_step + 11'd10;  y5 = 2 * y_step + 10'd10;//(6,2)
     x6 = 2 * x_step + 11'd10;  y6 = 1 * y_step + 10'd10;//(2,1)
     x7 = 9 * x_step + 11'd10;  y7 = 0 * y_step + 10'd10;//(9,0)
     x8 = 0 * x_step + 11'd10;  y8 = 4 * y_step + 10'd10;//(0,4)
     x9 = 9 * x_step + 11'd10;  y9 = 4 * y_step + 10'd10;//(9,4)
    end 
    /*       
            (curr_x >= x2 & curr_x < x2 + 39 & curr_y >= y2 & curr_y < y2 + 39)|
            (curr_x >= x3 & curr_x < x3 + 39 & curr_y >= y3 & curr_y < y3 + 39)|
            (curr_x >= x4 & curr_x < x4 + 39 & curr_y >= y4 & curr_y < y4 + 39)|
            (curr_x >= x5 & curr_x < x5 + 39 & curr_y >= y5 & curr_y < y5 + 39)|
            (curr_x >= x6 & curr_x < x6 + 39 & curr_y >= y6 & curr_y < y6 + 39)|
            (curr_x >= x7 & curr_x < x7 + 39 & curr_y >= y7 & curr_y < y7 + 39)|
            (curr_x >= x8 & curr_x < x8 + 39 & curr_y >= y8 & curr_y < y8 + 39)|
            (curr_x >= x9 & curr_x < x9 + 39 & curr_y >= y9 & curr_y < y9 + 39))
     */
     
//    always @(posedge clk) begin
//    if (rst==1)   addr0 <= 11'd0;
//    else if(curr_x >= x0 & curr_x <= x0 + 39 & curr_y >= y0 & curr_y <= y0 + 39)begin
//        addr0 = (curr_x - x0) + 40 * (curr_y - y0);
//    end
//    end
    
//    always @(posedge clk) begin
//    if (rst==1)   addr1 <= 11'd0;
//    else if(curr_x >= x1 & curr_x <= x1 + 39 & curr_y >= y1 & curr_y <= y1 + 39)begin
//        addr1 = (curr_x - x1) + 40 * (curr_y - y1);
//    end
//    end
    always @(posedge clk) begin
    if (rst==1)   addr0 <= 11'd0;
    else begin
        if (addr0 == 11'd1599)  addr0 = 11'd0;
        else if(curr_x >= x0 & curr_x <= x0 + 39 & curr_y >= y0 & curr_y <= y0 + 39)
            addr0 = addr0 + 11'd1;
    end
    end
    
    always @(posedge clk) begin
    if (rst==1)   addr1 <= 11'd0;
    else begin
        if (addr1 == 11'd1599)  addr1 = 11'd0;
        else if(curr_x >= x1 & curr_x <= x1 + 39 & curr_y >= y1 & curr_y <= y1 + 39)
            addr1 = addr1 + 11'd1;
    end
    end
    
    endmodule

