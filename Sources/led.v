`timescale 1ns / 1ps
////////////////////////////////////////////////////////////////////////////////////////////
// File refer from https://gitlab.kaust.edu.sa/fahmysa/cs294o-fall21/-/tree/master/homework1
////////////////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/17/2021 07:52:25 PM
// Design Name: GoldMiner
// Module Name: led
// Project Name: GoldMiner
// Target Devices: 
// Tool Versions: 
// Description: 
// This module maps digits to led signals
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module led(
    input [3:0] num,
    output reg a, b, c, d, e, f, g);
always @ *
begin
    a <= 1;
    b <= 1;
    c <= 1;
    d <= 1;
    e <= 1;
    f <= 1;
    g <= 1;
    case(num)
        4'b0000 : begin
                    a<=0;b<=0;c<=0;d<=0;e<=0;f<= 0;
                  end
        4'b0001 : begin
                   b<=0;c<=0;
                  end
        4'b0010 : begin
                    a<=0;b<=0;g<=0;d<=0;e<=0;
                  end
        4'b0011 : begin
                    a<=0;b<=0;c<=0;g<=0;d<=0;
                  end
        4'b0100 : begin
                    f<=0;b<=0;c<=0;g<=0;
                  end
        4'b0101 : begin
                    a<=0;g<=0;c<=0;d<=0;f<= 0;
                  end
        4'b0110 : begin
                    a<=0;g<=0;c<=0;d<=0;e<=0;f<= 0;
                  end
        4'b0111 : begin
                    a<=0;b<=0;c<=0;
                  end
        4'b1000 : begin
                    a<=0;b<=0;c<=0;d<=0;e<=0;f<=0;g<=0;
                  end
        4'b1001 : begin
                    a<=0;b<=0;c<=0;g<=0;f<= 0;
                  end
                  
   endcase
   end
endmodule
