`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/01/2021 02:28:03 PM
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
    input clk,
    input up,down,left,right,centre,
    output [3:0] pix_r, pix_g, pix_b,
    output hsync, vsync
    );
    // 83_46 MHZ clk
    wire pixclk_84M;
    clk_wiz_83_46 clkwiz83_46(.clk_out1(pixclk_84M), .clk_in1(clk));
    
    //Divide to 60HZ clk
    reg pixclk_60 = 1'b0;
    reg [20:0] clk_counter = 21'd0;
    always @(posedge pixclk_84M)
    begin
    clk_counter = clk_counter + 21'd1;
    if (clk_counter == 21'd695500)
        begin
        clk_counter = 21'd0;
        pixclk_60 =  ~pixclk_60;
        end
    end
    
    // Move between x->[10,1269] and y -> [10.789]
    // Circle Center is 625, 11
    // Radius is 75, so x moves [550,700]
    parameter center_x = 11'd625, center_y = 10'd11;
    parameter x_left = 11'd550, x_right = 10'd700;
    parameter y_bottom = 10'd86;
    reg [10:0] blkpos_x = center_x;
    reg [9:0] blkpos_y = center_y;
    reg x_move_right = 1'b1;
    reg signed [29:0] distance = 30'b0;
    reg [10:0]radius = 75;

        
    always @(posedge pixclk_60)
    begin
        // U-turn after reaching border
        if (blkpos_x <= x_left)
        begin
            x_move_right = 1'b1;
            blkpos_y = center_y;
        end
        if (blkpos_x >= x_right)
        begin
            x_move_right = 1'b0;
            blkpos_y = center_y;
        end

        // Moving right
        if (x_move_right == 1'b1)
        begin
            //Sector 1
            if (blkpos_x < center_x && ((center_x - blkpos_x) > (blkpos_y - center_y)) )
            begin
                blkpos_y = blkpos_y + 1;
                distance = (center_x-blkpos_x)*(center_x-blkpos_x) + (blkpos_y - center_y)*(blkpos_y-center_y);
                if (distance > radius * radius)
                    blkpos_x = blkpos_x + 1;
            end
            //Sector 2
            else if (blkpos_x < center_x && ((center_x - blkpos_x) <= (blkpos_y - center_y)) )
            begin
                blkpos_x = blkpos_x + 1;
                distance = (center_x-blkpos_x)*(center_x-blkpos_x) + (blkpos_y + 1 - center_y) * (blkpos_y + 1 - center_y);
                if (distance <= radius * radius)
                    blkpos_y = blkpos_y + 1;
            end
            //Sector 3
            else if (blkpos_x >= center_x && ((blkpos_x - center_x ) <= (blkpos_y - center_y)) )
            begin
                blkpos_x = blkpos_x + 1;
                distance = (blkpos_x - center_x)*(blkpos_x-center_x) + (blkpos_y - center_y)*(blkpos_y-center_y);
                if (distance > radius * radius)
                    blkpos_y = blkpos_y - 1;
            end
            //Sector 4
            else if (blkpos_x >= center_x && ((blkpos_x - center_x ) > (blkpos_y - center_y)) )
            begin
                blkpos_y = blkpos_y - 1;
                distance = (blkpos_x - center_x)*(blkpos_x - center_x) + (blkpos_y - center_y)*(blkpos_y-center_y);
                if (distance < radius * radius)
                    blkpos_x = blkpos_x + 1;
            end
        end
        
        else if (x_move_right == 1'b0)
        begin
            //Sector 5
            if (blkpos_x >= center_x && ((blkpos_x - center_x ) > (blkpos_y - center_y)) )
            begin
                blkpos_y = blkpos_y + 1;
                distance = (blkpos_x - center_x)*(blkpos_x - center_x) + (blkpos_y - center_y)*(blkpos_y-center_y);
                if (distance > radius * radius)
                    blkpos_x = blkpos_x - 1;
            end
             //Sector 6
            else if (blkpos_x >= center_x && ((blkpos_x - center_x ) <= (blkpos_y - center_y)) )
            begin
                blkpos_x = blkpos_x - 1;
                distance = (blkpos_x - center_x)*(blkpos_x-center_x) + (blkpos_y - center_y)*(blkpos_y-center_y);
                if (distance < radius * radius)
                    blkpos_y = blkpos_y + 1;
            end
            //Sector 7
            else if (blkpos_x < center_x && ((center_x - blkpos_x) <= (blkpos_y - center_y)) )
            begin
                blkpos_x = blkpos_x - 1;
                distance = (center_x-blkpos_x)*(center_x-blkpos_x) + (blkpos_y - center_y) * (blkpos_y - center_y);
                if (distance > radius * radius)
                    blkpos_y = blkpos_y - 1;
            end
            //Sector 8          
            else if (blkpos_x < center_x && ((center_x - blkpos_x) > (blkpos_y - center_y)) )
            begin
                blkpos_y = blkpos_y - 1;
                distance = (center_x-blkpos_x)*(center_x-blkpos_x) + (blkpos_y - center_y)*(blkpos_y-center_y);
                if (distance < radius * radius)
                    blkpos_x = blkpos_x - 1;
            end
        end 
    end
    
    wire [3:0]draw_r, draw_g, draw_b;
    wire [10:0] curr_x;
    wire [9:0] curr_y;
    drawcon dc(.blkpos_x(blkpos_x), .blkpos_y(blkpos_y), .draw_x(curr_x), .draw_y(curr_y), .r(draw_r), .g(draw_g), .b(draw_b));
    vga_out vo (.clk(pixclk_84M), .in_r(draw_r), .in_g(draw_g), .in_b(draw_b), .pix_r(pix_r), .pix_g(pix_g), .pix_b(pix_b), .hsync(hsync), .vsync(vsync), .curr_x(curr_x), .curr_y(curr_y));

endmodule
