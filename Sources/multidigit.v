`timescale 1ns / 1ps
////////////////////////////////////////////////////////////////////////////////////////////
// File refer from https://gitlab.kaust.edu.sa/fahmysa/cs294o-fall21/-/tree/master/homework1
////////////////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/17/2021 09:57:00 PM
// Design Name: 
// Module Name: multidigit
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


module multidigit(
        input clk, rst,
        input [3:0] dig7, dig6, dig5, dig4, dig3, dig2, dig1, dig0,
        output a, b, c, d, e, f, g,
        output reg [7:0] an
    );
    
    wire led_clk;

    reg [3:0] dig_sel;
    reg [2:0] led_index = 3'd0;

    reg [28:0] clk_count = 11'd0;
    
    always @(posedge clk)
        clk_count <= clk_count + 1'b1;
    
    assign led_clk = clk_count[16];
    assign div_clk = clk_count[25];
        
    always@(posedge led_clk)
        if(rst)
            led_index <= 3'd0;
        else
            led_index <= led_index + 1'b1;

    always@*
    begin   
        an = 8'b11111111;
        an[led_index] = 1'b0;
        case (led_index)
            3'd0: dig_sel = dig0;
            3'd1: dig_sel = dig1;
            3'd2: dig_sel = dig2;
            3'd3: dig_sel = dig3;
            3'd4: dig_sel = dig4;
            3'd5: dig_sel = dig5;
            3'd6: dig_sel = dig6;
            3'd7: dig_sel = dig7;
        endcase     
    end

    led M1 (.num(dig_sel), .a(a), .b(b), .c(c), .d(d), .e(e), .f(f), .g(g));
    
endmodule

