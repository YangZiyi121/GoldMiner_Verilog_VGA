`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/06/2021 02:22:27 PM
// Design Name: 
// Module Name: hook_moving
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


module hook_moving(
    input clk,
    output [10:0] blkpos_x_out,
    output [9:0] blkpos_y_out
    );
    
    assign blkpos_x_out = blkpos_x;
    assign blkpos_y_out = blkpos_y; 
     
    //Divide to 60HZ clk
    reg pixclk_60 = 1'b0;
    reg [20:0] clk_counter = 21'd0;
    
    always @(posedge clk)
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
    parameter center_x = 11'd635, center_y = 10'd167;
    parameter x_left = 11'd560, x_right = 10'd710;
    parameter y_bottom = 10'd242;
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
    
endmodule
