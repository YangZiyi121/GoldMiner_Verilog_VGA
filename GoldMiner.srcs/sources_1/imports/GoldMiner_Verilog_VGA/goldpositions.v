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
    output reg [12:0] addr3,
    output reg [11:0] addr0, addr1,
    output reg [10:0] addr2
    );
    parameter waving = 2'b00, stretching = 2'b01, hitting = 2'b10, missing = 2'b11;
    parameter init = 3'b000, hitted = 3'b001, disappear = 3'b010;
    parameter move = 2'b01, disappeared = 2'b10;
    /*goldPosition step*/
    reg [6:0] x_step = 7'd126;
    reg [6:0] y_step = 7'd108;
    reg [2:0] nstGoldState, goldState;
    reg  state_0 , state_1 , state_2, state_3, state_4, state_5, state_6, state_7, state_8, state_9;
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
                x2 = 8 * x_step + 11'd10;  y2 = 3 * y_step + 10'd10;//(7,5)
                x3 = 5 * x_step + 11'd10;  y3 = 3 * y_step + 10'd10;//(8,3)
                x4 = 5 * x_step + 11'd10;  y4 = 4 * y_step + 10'd10;//(5,4)
                x5 = 6 * x_step + 11'd10;  y5 = 4 * y_step + 10'd10;//(6,4)
                x6 = 2 * x_step + 11'd10;  y6 = 3 * y_step + 10'd10;//(2,3)
                x7 = 9 * x_step + 11'd10;  y7 = 5 * y_step + 10'd10;//(9,5)
                x8 = 0 * x_step + 11'd10;  y8 = 4 * y_step + 10'd10;//(0,4)
                x9 = 9 * x_step + 11'd10;  y9 = 4 * y_step + 10'd10;//(9,4)
                state_0 = 2'b00;
                state_1 = 2'b00;
                state_2 = 2'b00;
                state_3 = 2'b00;
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
            //for gold2 (diamond)
            if (hitted_gold == 4'b0010) begin
                state_2 = move;
                x2 = blk_x;
                y2 = blk_y;
            end
            else if (state_2 == move)  begin
                x2 = blk_x;
                y2 = blk_y;
            end  
            //for gold3 (stone)
            if (hitted_gold == 4'b0011) begin
                state_3 = move;
                x3 = blk_x;
                y3 = blk_y;
            end
            else if (state_3 == move)  begin
                x3 = blk_x;
                y3 = blk_y;
            end  
            end //end else
        
        disappear:
            if (state == hitting) nstGoldState = hitted;
            else begin
            //for gold 0
                if (state_0 == move) begin
                    x0 = 11'd2000; y0 = 10'd900;
                    state_0 = disappeared;
                end
            //for gold 1
                if (state_1 == move) begin
                    x1 = 11'd2000; y1 = 10'd900;
                    state_1 = disappeared;
                end
            //for gold 2 （diamond）
                if (state_2 == move) begin
                    x2 = 11'd2000; y2 = 10'd900;
                    state_2 = disappeared;
                end   
            //for gold 3 （stone）
                if (state_3 == move) begin
                    x3 = 11'd2000; y3 = 10'd900;
                    state_3 = disappeared;
                end   
            end               
        endcase   
    end 
     
 
    always @(posedge clk) begin
    if (rst==1 | (curr_x == x0 & curr_y == y0))   addr0 <= 12'd0;
    else begin
        if (addr0 == 12'd3599)  addr0 = 12'd0;
        else if(curr_x >= x0 & curr_x <= x0 + 59 & curr_y >= y0 & curr_y <= y0 + 59)
            addr0 = addr0 + 12'd1;
    end
    end
    
    always @(posedge clk) begin
    if (rst==1|(curr_x == x1 & curr_y == y1))   addr1 <= 12'd0;
    else begin
        if (addr1 == 12'd3599)  addr1 = 12'd0;
        else if(curr_x >= x1 & curr_x <= x1 + 59 & curr_y >= y1 & curr_y <= y1 + 59)
            addr1 = addr1 + 12'd1;
    end
    end
    
    always @(posedge clk) begin
    if (rst==1|(curr_x == x2 & curr_y == y2))   addr2 <= 11'd0;
    else begin
        if (addr2 == 11'd1599)  addr2 = 11'd0;
        else if(curr_x >= x2 & curr_x <= x2 + 39 & curr_y >= y2 & curr_y <= y2 + 39)
            addr2 = addr2 + 11'd1;
    end
    end
    
    always @(posedge clk) begin
    if (rst==1|(curr_x == x3 & curr_y == y3))   addr3 <= 13'd0;
    else begin
        if (addr3 == 13'd6399)  addr3 = 13'd0;
        else if(curr_x >= x3 & curr_x <= x3 + 79 & curr_y >= y3 & curr_y <= y3 + 79)
            addr3 = addr3 + 13'd1;
    end
    end
    
    endmodule

