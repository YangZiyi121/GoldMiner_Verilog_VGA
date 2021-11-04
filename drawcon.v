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
    input [7:0] W_rom_data,
    input [10:0] draw_x,
    input [9:0] draw_y,
    output [3:0] draw_r,
    output [3:0] draw_g,
    output [3:0] draw_b
    );
    

    
    assign draw_r = (draw_x >=10 && draw_x<= 1269 && draw_y>=10 && draw_y <= 789)? W_rom_data[7:5]*2:4'b1111;
    assign draw_g = (draw_x >=10 && draw_x<= 1269 && draw_y>=10 && draw_y <= 789)? W_rom_data[4:2]*2:4'b1111;
    assign draw_b = (draw_x >=10 && draw_x<= 1269 && draw_y>=10 && draw_y <= 789)? W_rom_data[1:0]*4:4'b1111;
    
endmodule
