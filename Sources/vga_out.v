//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/29/2021 11:43:20 AM
// Design Name: GoldMiner
// Module Name: vga_out
// Project Name: GoldMiner
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


module vga_out(
    input clk,rst,
    input  [3:0] draw_r,
    input  [3:0] draw_g,
    input  [3:0] draw_b,
    output  [3:0] pix_r,
    output  [3:0] pix_g,
    output  [3:0] pix_b,
    output [10:0] curr_x,
    output [9:0] curr_y,
    output hsync,
    output vsync
    );
    reg [10:0] hcount=11'd0;
    reg [9:0] vcount=10'd0;
    reg [10:0] curr_x_counter=11'd0;
    reg [9:0] curr_y_counter=10'd0;
    
    always @ (posedge clk) 
    begin
        if (rst == 1'b1)
        begin  
        hcount <= 11'd0; 
        vcount <= 10'd0; 
        end
    else begin
        if (hcount == 11'd1679) 
        begin 
            hcount <= 11'd0;
            if (vcount == 10'd931) 
                vcount <= 10'd0;
            else
                vcount = vcount + 1'b1;
        end
        else
            hcount = hcount + 1'b1;
    end
    end
    
    always @(posedge clk) begin
        if (rst == 1'b1)
        begin  
        curr_x_counter <= 11'd0; 
        curr_y_counter <= 10'd0; 
        end
        else begin
        if(hcount ==  11'd1679)
            begin 
                if (curr_y_counter == 10'd799)  curr_y_counter <= 10'd0;
                else if((vcount >= 10'd27) & (vcount <= 10'd826)) curr_y_counter = curr_y_counter + 1'b1;
            end
        else
            begin
                if(curr_x_counter == 11'd1279) curr_x_counter <= 11'd0;
                else if((hcount <= 11'd1615) & (hcount >= 11'd336)) curr_x_counter = curr_x_counter + 1'b1;
            end
        end
    end
    
    assign curr_x = curr_x_counter;
    assign curr_y = curr_y_counter;
    
    assign hsync = ((hcount >= 11'd0) & (hcount <= 11'd135))? 1'b0: 1'b1;
    assign vsync = ((vcount >= 10'd0) & (vcount <= 10'd2))? 1'b1: 1'b0;
    

    assign pix_r = ((hcount<=11'd1615) & (hcount >= 11'd336) & (vcount>=10'd27) &(vcount <= 10'd826))? draw_r: 4'd0000;
    assign pix_g = ((hcount<=11'd1615) & (hcount >= 11'd336) & (vcount>=10'd27) &(vcount <= 10'd826))? draw_g: 4'd0000;
    assign pix_b = ((hcount<=11'd1615) & (hcount >= 11'd336) & (vcount>=10'd27) &(vcount <= 10'd826))? draw_b: 4'd0000;

endmodule
