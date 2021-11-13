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
    input pixclk_60,
    input rst,
    input [1:0] state,
    input [10:0] blk_x,
    input [9:0] blk_y,
    input [3:0] hitted_gold,
    input [10:0] curr_x,
    input [9:0] curr_y,
    output reg [10:0] x9,x8,x7,x6,x5,x4,x3,x2,x1,x0,
    output reg [9:0] y9,y8,y7,y6,y5,y4,y3,y2,y1,y0,
    output reg [10:0] addr0, addr1
    );
    parameter waving = 2'b00, stretching = 2'b01, hitting = 2'b10, missing = 2'b11;
    parameter init = 3'b000, hitted = 3'b001, disappear = 3'b010;
    parameter move = 1'b1;
    /*goldPosition step*/
    reg [6:0] x_step = 7'd126;
    reg [6:0] y_step = 7'd108;
    reg [2:0] nstGoldState, goldState;
    reg  state_0 = 1'b0, state_1 = 1'b0, state_2 =1'b0, state_3=1'b0, state_4=1'b0, state_5=1'b0, state_6=1'b0, state_7=1'b0, state_8=1'b0, state_9=1'b0;
    /*state machine for gold*/
    always @(posedge pixclk_60)
    begin 
        if(rst) begin
             goldState <= init;
        end
        else goldState <= nstGoldState;
    end
    
    /*state trassition for gold*/
    always@*begin
        nstGoldState = goldState;
        case(goldState)
        init:
            if(state == hitting) nstGoldState = hitted;
            else begin
                x0 = 2 * x_step + 11'd10;  y0 = 4 * y_step + 10'd10;//(2, 4)
                x1 = 1 * x_step + 11'd10;  y1 = 3 * y_step + 10'd10;//(1,3)
                x2 = 7 * x_step + 11'd10;  y2 = 1 * y_step + 10'd10;//(7,1)
                x3 = 8 * x_step + 11'd10;  y3 = 2 * y_step + 10'd10;//(8,2)
                x4 = 5 * x_step + 11'd10;  y4 = 4 * y_step + 10'd10;//(5,4)
                x5 = 6 * x_step + 11'd10;  y5 = 2 * y_step + 10'd10;//(6,2)
                x6 = 2 * x_step + 11'd10;  y6 = 1 * y_step + 10'd10;//(2,1)
                x7 = 9 * x_step + 11'd10;  y7 = 0 * y_step + 10'd10;//(9,0)
                x8 = 0 * x_step + 11'd10;  y8 = 4 * y_step + 10'd10;//(0,4)
                x9 = 9 * x_step + 11'd10;  y9 = 4 * y_step + 10'd10;//(9,4)
                state_0 = 1'b0;
                state_1 = 1'b0;
             end
        hitted:
            if(state == waving)  nstGoldState = disappear;
            else begin
            //for gold0
            if (hitted_gold == 4'b0000) begin
                state_0 = move;
                x0 = blk_x;
                y0 = blk_y;
            end
            else if (state_0 == move)  begin
                x0 = blk_x;
                y0 = blk_y;
            end  
            //for gold1
            if (hitted_gold == 4'b0001) begin
                state_1 = move;
                x1 = blk_x;
                y1 = blk_y;
            end
            else if (state_1 == move)  begin
                x1 = blk_x;
                y1 = blk_y;
            end  
             
            end //end else
        
        disappear:
            if (state == hitting) nstGoldState = hitted;
            else begin
            //for gold 0
                if (state_0 == move) begin
                    x0 = 11'd2000; y0 = 10'd900;
                end
            //for gold 1
                if (state_1 == move) begin
                    x1 = 11'd2000; y1 = 10'd900;
                end
            end               
        endcase   
    end 
     
 
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

