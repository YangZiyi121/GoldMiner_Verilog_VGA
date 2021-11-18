`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/17/2021 08:01:02 PM
// Design Name: 
// Module Name: score_leds
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


module score_leds(
        input clk, rst,
        input pixclk_60,
        input [7:0] totaltime,
        input [7:0] score,
        output a, b, c, d, e, f, g,
        output [7:0] an
    );
    reg clk_1hz = 0;  
    reg [7:0] clk_counter = 8'd0;
    reg [7:0] time_show = 8'd0;
    reg [7:0] elapsed_time = 8'd0;
    always @(posedge pixclk_60)
    begin
        if (rst)
        begin
        clk_counter = 8'd0;
        end
        else
        begin
            clk_counter = clk_counter + 8'd1;
            if (clk_counter == 8'd42)
            begin
                clk_1hz = ~clk_1hz;
                clk_counter = 0;
            end
        end
    end
    
    always @(posedge clk_1hz)
    begin
        if (rst)
        begin
        elapsed_time = 8'd0;
        end
        else
        begin
            time_show = totaltime - elapsed_time;
            elapsed_time = elapsed_time + 8'd1;
            if(elapsed_time > totaltime)
            begin
                elapsed_time = totaltime;
            end
        end
    end
        
    
    reg [3:0] dig7=4'd0, dig6=4'd0, dig5=4'd0, dig4=4'd0, dig3=4'd3, dig2=4'd2, dig1=4'd1, dig0=4'd0;
    multidigit md(.clk(clk), .rst(rst), .dig7(dig7), .dig6(dig6), .dig5(dig5), .dig4(dig4), .dig3(dig3), .dig2(dig2), .dig1(dig1), .dig0(dig0), .a(a), .b(b), .c(c), .d(d), .e(e), .f(f), .g(g), .an(an));
    
always @*
    begin
        dig0 <= score%10;
        dig1 <= score/10%10;
        dig2 <= score/100%10;
        dig3 <= score/1000%10;
        dig4 <= time_show%10;
        dig5 <= time_show/10%10;
        dig6 <= time_show/100%10;
        dig7 <= time_show/1000%10; 
    end
endmodule
