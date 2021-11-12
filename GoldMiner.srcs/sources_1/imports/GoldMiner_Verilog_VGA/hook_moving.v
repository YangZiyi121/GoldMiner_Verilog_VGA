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
    input [1:0] state,
    input pixclk_60,
    output [10:0] blkpos_x_out,
    output [9:0] blkpos_y_out
    );
    
    assign blkpos_x_out = blkpos_x;
    assign blkpos_y_out = blkpos_y; 
     
    // Move between x->[10,1269] and y -> [10.789]
    // Circle Center is 625, 11
    // Radius is 75, so x moves [550,700]
    parameter center_x = 11'd635, center_y = 10'd167;
    parameter x_left = 11'd560, x_right = 10'd710;
    parameter waving = 2'b00, stretching = 2'b01, hitting = 2'b10, missing = 2'b11;
    parameter y_bottom = 10'd242;
    reg [10:0] blkpos_x = center_x;
    reg [9:0] blkpos_y = center_y;
    reg x_move_right = 1'b1;
    reg signed [29:0] distance = 30'b0;
    reg [10:0]radius = 75;
    
    parameter x_1 = 15'd635, y_1 = 15'd167; //position of miner, 15 bits to prevent overflow of ((y_0-y_1)*(x_2-x_1)) == ((x_0 - x_1)*(y_2-y_1))
    reg [15:0] x_2, y_2,x_0, y_0; //Position for blok
   
    always @(posedge pixclk_60)
    begin
    //Waving State
    if(state == waving)
    begin
        x_2 <= $signed({1'b0,blkpos_x});
        y_2 <= $signed({1'b0,blkpos_y}); // Save current block position as signed
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
    end // End state case
    
    //Stretching State
    else if(state == stretching)
    begin
            x_0 = {4'b0000,blkpos_x};
            y_0 = {5'b00000,blkpos_y}; // Save current block position as signed
            //Sector 1
            if (blkpos_x <= center_x && ((center_x - blkpos_x) >= (blkpos_y - center_y)) )
            begin
                x_0  = x_0 - 1;
                if ( ($signed(y_0) -$signed(y_1))*($signed(x_2)-$signed(x_1)) - ($signed(x_0) - $signed(x_1))*($signed(y_2)-$signed(y_1))  >= 0  )
                begin
                    y_0 = y_0 + 1;
                end
            end
            //Sector 2
            else if (blkpos_x < center_x && ((center_x - blkpos_x) <= (blkpos_y - center_y)) )
            begin
                y_0 = y_0 + 1;
                if ( ($signed(y_0) -$signed(y_1))*($signed(x_2)-$signed(x_1)) - ($signed(x_0) - $signed(x_1))*($signed(y_2)-$signed(y_1))  <= 0  )
                begin
                    x_0 = x_0 - 1;
                end
            end
            //Sector 3
            else if (blkpos_x >= center_x && ((blkpos_x - center_x ) <= (blkpos_y - center_y)) )
            begin
                y_0 = y_0 + 1;
                if ( ($signed(y_0) -$signed(y_1))*($signed(x_2)-$signed(x_1)) - ($signed(x_0) - $signed(x_1))*($signed(y_2)-$signed(y_1))  >= 0  )
                begin
                    x_0 = x_0 + 1;
                end
            end
            //Sector 4
            else if (blkpos_x >= center_x && ((blkpos_x - center_x ) > (blkpos_y - center_y)) )
            begin
            begin
                x_0  = x_0 + 1;
                if ( ($signed(y_0) -$signed(y_1))*($signed(x_2)-$signed(x_1)) - ($signed(x_0) - $signed(x_1))*($signed(y_2)-$signed(y_1))  <= 0  )
                begin
                    y_0 = y_0 + 1;
                end
            end
            end
            blkpos_x =x_0;
            blkpos_y =y_0;  
    end
    
    // hitting State
    else if(state == hitting)
    begin
            x_0 = {4'b0000,blkpos_x};
            y_0 = {5'b00000,blkpos_y}; // Save current block position as signed
            //Sector 1
            if (blkpos_x <= center_x && ((center_x - blkpos_x) >= (blkpos_y - center_y)) )
            begin
                x_0  = x_0 + 1;
                if ( ($signed(y_0) -$signed(y_1))*($signed(x_2)-$signed(x_1)) - ($signed(x_0) - $signed(x_1))*($signed(y_2)-$signed(y_1))  <= 0  )
                begin
                    y_0 = y_0 - 1;
                end
            end
            //Sector 2
            else if (blkpos_x < center_x && ((center_x - blkpos_x) <= (blkpos_y - center_y)) )
            begin
                y_0 = y_0 - 1;
                if ( ($signed(y_0) -$signed(y_1))*($signed(x_2)-$signed(x_1)) - ($signed(x_0) - $signed(x_1))*($signed(y_2)-$signed(y_1))  >= 0  )
                begin
                    x_0 = x_0 + 1;
                end
            end
            //Sector 3
            else if (blkpos_x >= center_x && ((blkpos_x - center_x ) <= (blkpos_y - center_y)) )
            begin
                y_0 = y_0 - 1;
                if ( ($signed(y_0) -$signed(y_1))*($signed(x_2)-$signed(x_1)) - ($signed(x_0) - $signed(x_1))*($signed(y_2)-$signed(y_1))  <= 0  )
                begin
                    x_0 = x_0 - 1;
                end
            end
            //Sector 4
            else if (blkpos_x >= center_x && ((blkpos_x - center_x ) > (blkpos_y - center_y)) )
            begin
            begin
                x_0  = x_0 - 1;
                if ( ($signed(y_0) -$signed(y_1))*($signed(x_2)-$signed(x_1)) - ($signed(x_0) - $signed(x_1))*($signed(y_2)-$signed(y_1))  >= 0  )
                begin
                    y_0 = y_0 - 1;
                end
            end
            end
            blkpos_x =x_0;
            blkpos_y =y_0; 
    end
    
    // empty State
    else
    begin
            x_0 = {4'b0000,blkpos_x};
            y_0 = {5'b00000,blkpos_y}; // Save current block position as signed
            //Sector 1
            if (blkpos_x <= center_x && ((center_x - blkpos_x) >= (blkpos_y - center_y)) )
            begin
                x_0  = x_0 + 1;
                if ( ($signed(y_0) -$signed(y_1))*($signed(x_2)-$signed(x_1)) - ($signed(x_0) - $signed(x_1))*($signed(y_2)-$signed(y_1))  <= 0  )
                begin
                    y_0 = y_0 - 1;
                end
            end
            //Sector 2
            else if (blkpos_x < center_x && ((center_x - blkpos_x) <= (blkpos_y - center_y)) )
            begin
                y_0 = y_0 - 1;
                if ( ($signed(y_0) -$signed(y_1))*($signed(x_2)-$signed(x_1)) - ($signed(x_0) - $signed(x_1))*($signed(y_2)-$signed(y_1))  >= 0  )
                begin
                    x_0 = x_0 + 1;
                end
            end
            //Sector 3
            else if (blkpos_x >= center_x && ((blkpos_x - center_x ) <= (blkpos_y - center_y)) )
            begin
                y_0 = y_0 - 1;
                if ( ($signed(y_0) -$signed(y_1))*($signed(x_2)-$signed(x_1)) - ($signed(x_0) - $signed(x_1))*($signed(y_2)-$signed(y_1))  <= 0  )
                begin
                    x_0 = x_0 - 1;
                end
            end
            //Sector 4
            else if (blkpos_x >= center_x && ((blkpos_x - center_x ) > (blkpos_y - center_y)) )
            begin
            begin
                x_0  = x_0 - 1;
                if ( ($signed(y_0) -$signed(y_1))*($signed(x_2)-$signed(x_1)) - ($signed(x_0) - $signed(x_1))*($signed(y_2)-$signed(y_1))  >= 0  )
                begin
                    y_0 = y_0 - 1;
                end
            end
            end
            blkpos_x =x_0;
            blkpos_y =y_0; 
    end
        
    end
    
endmodule
