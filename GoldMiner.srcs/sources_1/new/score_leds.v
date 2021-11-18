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
        input [7:0] time_show,
        input [7:0] score,
        output a, b, c, d, e, f, g,
        output [7:0] an
    );
 
        
    
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
