`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/19/2021 10:51:44 AM
// Design Name: 
// Module Name: CasePositions
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


module CasePositions(
    input i_Clk,
    input rst,
    output reg [10:0] x9,x8,x7,x6,x5,x4,x3,x2,x1,x0,
    output reg [9:0] y9,y8,y7,y6,y5,y4,y3,y2,y1,y0
    );
    
    reg [10:0] x;
    reg [9:0] y;
    wire [3:0] data;
    wire w_LFSR_Done;
    reg [3:0] seedData = {4{0}} ;
    reg [10:0] x_step = 11'd126;
    reg [9:0] y_step = 10'd108;
    reg [3:0] counter = 0;
    reg done = 0;
    
    assign counterWire = counter;
    /*instance for LFSR*/
    LFSR randomPosition(.i_Clk(i_Clk), .i_Enable(1'b1), .i_Seed_DV(1'b0), .i_Seed_Data(4'b0111), 
    .o_LFSR_Data(data), .o_LFSR_Done(w_LFSR_Done));
    
    always @ (posedge i_Clk) begin 
    if (rst == 1)  begin
          done = 0;counter = 0; seedData = {4{1}};
    end
    else begin
    if (counter == 4'd11 & done == 0)  begin
        counter = 4'd0; done = 1;
    end
    else if(w_LFSR_Done!=1 & done == 0)  counter = counter + 1;
    end
    end
    
    always @(posedge i_Clk) begin
    if((done == 0) & (w_LFSR_Done!=1))begin
    case (counter)
        4'd1: 
        begin
            x0 <= x; y0 <= y;
        end
        4'd2: 
        begin
            x1 <= x; y1 <= y;
        end  
        4'd3: 
        begin
            x2 <= x; y2 <= y;
        end  
        4'd4: 
        begin
            x3 <= x; y3 <= y;
        end 
        4'd5: 
        begin
            x4 <= x; y4 <= y;
        end  
        4'd6: 
        begin
            x5 <= x; y5 <= y;
        end   
        4'd7: 
        begin
            x6 <= x; y6 <= y;
        end   
        4'd8: 
        begin
            x7 <= x; y7 <= y;
        end 
        4'd9: 
        begin
            x8 <= x; y8 <= y;
        end        
        4'd10: 
        begin
            x9 <= x; y9 <= y;
        end
        endcase
    end    
    end                                                    
              
    always @* begin
    x = 11'd10;
    y = 10'd10;
    case (data) 
        4'd0:
         begin
           x <= 2 * x_step + 11'd10;  y <= 4 * y_step + 10'd10;//(2, 4) (262, 442)  (106，1ba）
          end
        4'd1: 
          begin
          x <= 1 * x_step + 11'd10;  y <= 3 * y_step + 10'd10;//(1,3) (136，334) (88,14e)
          end
        4'd2:
          begin
          x <= 8 * x_step + 11'd10;  y <= 3 * y_step + 10'd10;//(8,3) (1018, 334) (3fa,14e)
          end
        4'd3:
          begin
          x <= 5 * x_step + 11'd10;  y <= 3 * y_step + 10'd10;//(5,3) (640, 334) (280, 14e)
          end
        4'd4:
          begin
          x <= 5 * x_step + 11'd10;  y <= 4 * y_step + 10'd10;//(5,4) (280, 1ba) 
          end
        4'd5:
          begin
          x <= 6 * x_step + 11'd10;  y <= 4 * y_step + 10'd10;//(6,4) 
          end 
        4'd6:
          begin
          x <= 9 * x_step + 11'd10;  y <= 5 * y_step + 10'd10;//(9,5)
          end
        4'd7:
          begin
          x <= 0 * x_step + 11'd10;  y <= 4 * y_step + 10'd10;//(0,4)
          end
        4'd8:
          begin
          x <= 7 * x_step + 11'd10;  y <= 4 * y_step + 10'd10;//(7,4)
          end  
        4'd9:
          begin
          x <= 8 * x_step + 11'd10;  y <= 5 * y_step + 10'd10;//(8,5)   
          end
        4'd10:
          begin
          x <= 9 * x_step + 11'd10;  y <= 4 * y_step + 10'd10;//(9,4)   
          end 
        4'd11:
          begin
          x <= 9 * x_step + 11'd10;  y <= 3 * y_step + 10'd10;//(9,3)   
          end 
        4'd12:
          begin
          x <= 0 * x_step + 11'd10;  y <= 5 * y_step + 10'd10;//(0,5)   
          end   
        4'd13:
          begin
          x <= 1 * x_step + 11'd10;  y <= 4 * y_step + 10'd10;//(1,4)   
          end    
        4'd14:
          begin
          x <= 6 * x_step + 11'd10;  y <= 3 * y_step + 10'd10;//(6,3)   
          end      
        4'd15:
          begin
          x <= 5 * x_step + 11'd10;  y <= 5 * y_step + 10'd10;//(5,5)   
          end   
     endcase     
     end
     
endmodule
