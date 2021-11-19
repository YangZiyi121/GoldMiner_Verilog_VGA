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
    output reg [12:0] addr7, addr8, addr9,
    output reg [11:0] addr0, addr1, addr2, addr3, addr4,
    output reg [10:0] addr5, addr6
    );
    parameter waving = 2'b00, stretching = 2'b01, hitting = 2'b10, missing = 2'b11;
    parameter init = 3'b000, hitted = 3'b001, disappear = 3'b010;
    parameter move = 2'b01, disappeared = 2'b10;
    /*goldPosition step*/
//    reg [6:0] x_step = 7'd126;
//    reg [6:0] y_step = 7'd108;
    reg [2:0] nstGoldState;
    reg [2:0] goldState;
    reg  state_0 , state_1 , state_2, state_3, state_4, state_5, state_6, state_7, state_8, state_9;
    
    /*generate random value*/
    wire [10:0] x9_r,x8_r,x7_r,x6_r,x5_r,x4_r,x3_r,x2_r,x1_r,x0_r;
    wire [9:0] y9_r,y8_r,y7_r,y6_r,y5_r,y4_r,y3_r,y2_r,y1_r,y0_r;
    
    
    CasePositions getPositions(.i_Clk(clk), .rst(rst),
    .x9(x9_r), .x8(x8_r), .x7(x7_r), .x6(x6_r), .x5(x5_r), .x4(x4_r), .x3(x3_r), .x2(x2_r), .x1(x1_r), .x0(x0_r),
    .y9(y9_r), .y8(y8_r), .y7(y7_r), .y6(y6_r), .y5(y5_r), .y4(y4_r), .y3(y3_r), .y2(y2_r), .y1(y1_r), .y0(y0_r));
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
                x0 = x0_r;  y0 = y0_r;
                x1 = x1_r;  y1 = y1_r;
                x2 = x2_r;  y2 = y2_r;
                x3 = x3_r;  y3 = y3_r;
                x4 = x4_r;  y4 = y4_r;
                x5 = x5_r;  y5 = y5_r;
                x6 = x6_r;  y6 = y6_r;
                x7 = x7_r;  y7 = y7_r;
                x8 = x8_r;  y8 = y8_r;
                x9 = x9_r;  y9 = y9_r;
                state_0 = 2'b00;
                state_1 = 2'b00;
                state_2 = 2'b00;
                state_3 = 2'b00;
                state_4 = 2'b00;
                state_5 = 2'b00;
                state_6 = 2'b00;
                state_7 = 2'b00;
                state_8 = 2'b00;
                state_9 = 2'b00;
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
            //for gold2 
            if (hitted_gold == 4'b0010) begin
                state_2 = move;
                x2 = blk_x;
                y2 = blk_y;
            end
            else if (state_2 == move)  begin
                x2 = blk_x;
                y2 = blk_y;
            end  
            //for gold3 
            if (hitted_gold == 4'b0011) begin
                state_3 = move;
                x3 = blk_x;
                y3 = blk_y;
            end
            else if (state_3 == move)  begin
                x3 = blk_x;
                y3 = blk_y;
            end  
            //for gold4 
            if (hitted_gold == 4'b0100) begin
                state_4 = move;
                x4 = blk_x;
                y4 = blk_y;
            end
            else if (state_4 == move)  begin
                x4 = blk_x;
                y4 = blk_y;
            end
            //for gold5 (diamond)
            if (hitted_gold == 4'b0101) begin
                state_5 = move;
                x5 = blk_x;
                y5 = blk_y;
            end
            else if (state_5 == move)  begin
                x5 = blk_x;
                y5 = blk_y;
            end
            //for gold6 (diamond)
            if (hitted_gold == 4'b0110) begin
                state_6 = move;
                x6 = blk_x;
                y6 = blk_y;
            end
            else if (state_6 == move)  begin
                x6 = blk_x;
                y6 = blk_y;
            end
            //for gold7 (stone)
            if (hitted_gold == 4'b0111) begin
                state_7 = move;
                x7 = blk_x;
                y7 = blk_y;
            end
            else if (state_7 == move)  begin
                x7 = blk_x;
                y7 = blk_y;
            end
            //for gold8 (stone)
            if (hitted_gold == 4'b1000) begin
                state_8 = move;
                x8 = blk_x;
                y8 = blk_y;
            end
            else if (state_8 == move)  begin
                x8 = blk_x;
                y8 = blk_y;
            end
            //for gold9 (stone)
            if (hitted_gold == 4'b1001) begin
                state_9 = move;
                x9 = blk_x;
                y9 = blk_y;
            end
            else if (state_9 == move)  begin
                x9 = blk_x;
                y9 = blk_y;
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
            //for gold 2 
                if (state_2 == move) begin
                    x2 = 11'd2000; y2 = 10'd900;
                    state_2 = disappeared;
                end   
            //for gold 3 
                if (state_3 == move) begin
                    x3 = 11'd2000; y3 = 10'd900;
                    state_3 = disappeared;
                end   
            //for gold 4 
                if (state_4 == move) begin
                    x4 = 11'd2000; y4 = 10'd900;
                    state_4 = disappeared;
                end
            //for gold 5 
                if (state_5 == move) begin
                    x5 = 11'd2000; y5 = 10'd900;
                    state_5 = disappeared;
                end   
            //for gold 6 
                if (state_6 == move) begin
                    x6 = 11'd2000; y6 = 10'd900;
                    state_6 = disappeared;
                end 
            //for gold 7 
                if (state_7 == move) begin
                    x7 = 11'd2000; y7 = 10'd900;
                    state_7 = disappeared;
                end     
            //for gold 8 
                if (state_8 == move) begin
                    x8 = 11'd2000; y8 = 10'd900;
                    state_8 = disappeared;
                end    
            //for gold 9 
                if (state_9 == move) begin
                    x9 = 11'd2000; y9 = 10'd900;
                    state_9 = disappeared;
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
    if (rst==1|(curr_x == x2 & curr_y == y2))   addr2 <= 12'd0;
    else begin
        if (addr1 == 12'd3599)  addr2 = 12'd0;
        else if(curr_x >= x2 & curr_x <= x2 + 59 & curr_y >= y2 & curr_y <= y2 + 59)
            addr2 = addr2 + 12'd1;
    end
    end
    
    always @(posedge clk) begin
    if (rst==1|(curr_x == x3 & curr_y == y3))   addr3 <= 12'd0;
    else begin
        if (addr1 == 12'd3599)  addr3 = 12'd0;
        else if(curr_x >= x3 & curr_x <= x3 + 59 & curr_y >= y3 & curr_y <= y3 + 59)
            addr3 = addr3 + 12'd1;
    end
    end
    
    always @(posedge clk) begin
    if (rst==1|(curr_x == x4 & curr_y == y4))   addr4 <= 12'd0;
    else begin
        if (addr4 == 12'd3599)  addr4 = 12'd0;
        else if(curr_x >= x4 & curr_x <= x4 + 59 & curr_y >= y4 & curr_y <= y4 + 59)
            addr4 = addr4 + 12'd1;
    end
    end
    
    always @(posedge clk) begin
    if (rst==1|(curr_x == x5 & curr_y == y5))   addr5 <= 11'd0;
    else begin
        if (addr5 == 11'd1599)  addr5 = 11'd0;
        else if(curr_x >= x5 & curr_x <= x5 + 39 & curr_y >= y5 & curr_y <= y5 + 39)
            addr5 = addr5 + 11'd1;
    end
    end
    
    always @(posedge clk) begin
    if (rst==1|(curr_x == x6 & curr_y == y6))   addr6 <= 11'd0;
    else begin
        if (addr6 == 11'd1599)  addr6 = 11'd0;
        else if(curr_x >= x6 & curr_x <= x6 + 39 & curr_y >= y6 & curr_y <= y6 + 39)
            addr6 = addr6 + 11'd1;
    end
    end
    
    always @(posedge clk) begin
    if (rst==1|(curr_x == x7 & curr_y == y7))   addr7 <= 13'd0;
    else begin
        if (addr7 == 13'd6399)  addr7 = 13'd0;
        else if(curr_x >= x7 & curr_x <= x7 + 79 & curr_y >= y7 & curr_y <= y7 + 79)
            addr7 = addr7 + 13'd1;
    end
    end
    
    always @(posedge clk) begin
    if (rst==1|(curr_x == x8 & curr_y == y8))   addr8 <= 13'd0;
    else begin
        if (addr8 == 13'd6399)  addr8 = 13'd0;
        else if(curr_x >= x8 & curr_x <= x8 + 79 & curr_y >= y8 & curr_y <= y8 + 79)
            addr8 = addr8 + 13'd1;
    end
    end
    
    always @(posedge clk) begin
    if (rst==1|(curr_x == x9 & curr_y == y9))   addr9 <= 13'd0;
    else begin
        if (addr9 == 13'd6399)  addr9 = 13'd0;
        else if(curr_x >= x9 & curr_x <= x9 + 79 & curr_y >= y9 & curr_y <= y9 + 79)
            addr9 = addr9 + 13'd1;
    end
    end
    
    endmodule

