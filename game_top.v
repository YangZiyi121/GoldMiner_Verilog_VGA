`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/31/2021 08:37:18 PM
// Design Name: 
// Module Name: game_top
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


module game_top(
    input clk,rst,
    output  [3:0] pix_r,
    output  [3:0] pix_g,
    output  [3:0] pix_b,
    output hsync,
    output vsync
    );
    wire [10:0]curr_x;
    wire [9:0]curr_y;
    wire [3:0] pix_r_or,  pix_g_or,  pix_b_or;
    wire clkout;
    reg [1:0] counterColumn = 2'd0;
    reg [1:0] counterRow = 2'd0;
    reg clkdraw = 1'b0;
    reg [16:0] R_rom_addr = 17'd0;
    wire [7:0] W_rom_data;
    /* pixal clock instance */
    clk_wiz_0 pixClkIns (.clk_in1(clk), .clk_out1(clkout));
    
    /* background image instance */
    blk_mem_gen_0 rom (.clka(clkout), .addra(R_rom_addr), .douta(W_rom_data));
    
    /* vga-out instance */
    vga_out vgainst (.clk(clkout), .rst(rst), .draw_r(pix_r_or), .draw_g(pix_g_or), .draw_b(pix_b_or),                  
    .pix_r(pix_r), .pix_g(pix_g), .pix_b(pix_b), .hsync(hsync), .vsync(vsync), .curr_x(curr_x), .curr_y(curr_y)); 
          
    drawcon drawEnvironment (.W_rom_data(W_rom_data), .draw_x(curr_x), .draw_y(curr_y), .draw_r(pix_r_or), .draw_g(pix_g_or), .draw_b(pix_b_or));
    
    /*The counter to make the figure bigger *3  */
    always @(posedge clkout) begin
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
//      always @(posedge clkout) begin
//        if(rst) counter <= 2'd0;
//        else if(curr_x >= 11'd10 && curr_x<= 11'd1269  && curr_y>=10'd10 && curr_y <= 10'd789) begin
//            if (counter == 2'd2)   counter <= 2'd0;  
//            else counter = counter + 1'b1; 
//        end
//      end
//    /*Show the background*/
//	always @(posedge clkout) begin
//		if(rst)
//			R_rom_addr <= 17'd0;
//		else begin
//		    if(R_rom_addr == 17'd109199)
//		        R_rom_addr = 17'd0;
//		    else if(curr_x >= 11'd10 && curr_x<= 11'd1269  && curr_y>=10'd10 && curr_y <= 10'd789) begin
//		        if (!counterRow == 1)  R_rom_addr = R_rom_addr - 420;
//		        R_rom_addr = R_rom_addr +1'd1;
//		        if (!counterColumn == 1) R_rom_addr = R_rom_addr - 1'd1;     
//		    end
//		  end
//	   end

/* show the whole image by using address*/
	always @(posedge clkout) begin
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
