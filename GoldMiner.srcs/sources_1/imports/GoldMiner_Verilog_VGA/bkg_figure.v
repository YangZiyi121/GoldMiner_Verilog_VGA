`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/06/2021 03:23:44 PM
// Design Name: 
// Module Name: bkg_figure
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


module bkg_figure(
    input clk,
    input rst, 
    input [10:0] curr_x,
    input [9:0] curr_y,
    output [16:0] addr
    );
    reg [1:0] counterColumn = 2'd0;
    reg [1:0] counterRow = 2'd0;
    reg clkdraw = 1'b0;
    reg [16:0] R_rom_addr = 17'd0;
    
    assign addr = R_rom_addr;
     
    /*The counter to make the figure bigger *3  */
    // It is too large to store the 780 * 1260 .coe file into ROM. Therefore, I use a 260 * 420 .coe file instead.
    // By repeating each pixel three times on x and each row three times on y, the figure can *3
    always @(posedge clk) begin
    if (rst) begin
        counterColumn <= 2'd0; counterRow <= 2'd0;
    end
    else begin
        if(counterRow == 2'd2)  counterRow = 2'd0;

        else if (curr_x == 11'd10) counterRow = counterRow + 1'b1;
           
        if(counterColumn == 2'd2)  begin
            counterColumn = 2'd0;
        end 
        else if(curr_x >= 11'd10 && curr_x<= 11'd1269 && curr_y>=10'd10 && curr_y <= 10'd789)
                counterColumn = counterColumn + 1'd1;
        end
    end


    /* show the whole image by using address*/
	always @(posedge clk) begin
		if(rst)
			R_rom_addr <= 17'd0;
		else begin
		     if(curr_x >= 11'd10 && curr_x<= 11'd1269  && curr_y>=10'd10 && curr_y <= 10'd789) begin
		        if(counterRow == 1) begin
		          if(counterColumn == 1) R_rom_addr = ((curr_y-10)/3 * 420)+ (curr_x - 10)/3;
		          else if (counterColumn == 2) R_rom_addr = ((curr_y-10)/3 * 420) + ((curr_x - 10) -1)/3;
		          else if (counterColumn == 0) R_rom_addr = ((curr_y-10)/3 * 420)+ ((curr_x - 10) -2)/3;
		        end
		        else if (counterRow == 2) begin
		          if(counterColumn == 1) R_rom_addr = ((curr_y - 1-10)/3 * 420) + (curr_x - 10)/3;
		          else if (counterColumn == 2) R_rom_addr = ((curr_y - 1-10)/3 * 420) + ((curr_x - 10) -1)/3;
		          else if (counterColumn == 0) R_rom_addr = ((curr_y - 1-10)/3 * 420) + ((curr_x - 10) -2)/3;
		        end
		        else if (counterRow == 0) begin
		          if(counterColumn == 1) R_rom_addr = ((curr_y - 2-10)/3 * 420 ) + (curr_x - 10)/3;
		          else if (counterColumn == 2) R_rom_addr = ((curr_y - 2-10)/3 * 420 ) + ((curr_x - 10) -1)/3;
		          else if (counterColumn == 0) R_rom_addr = ((curr_y - 2-10)/3 * 420 ) + ((curr_x - 10) -2)/3;
		        end
		     end
		  end
	end
    
endmodule
