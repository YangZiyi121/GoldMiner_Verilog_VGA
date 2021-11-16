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
    input clk, rst, button,
    output  [3:0] pix_r,
    output  [3:0] pix_g,
    output  [3:0] pix_b,
    output hsync,
    output vsync
    );
    wire [10:0]curr_x;
    wire [9:0]curr_y;
    wire [3:0] pix_r_or,  pix_g_or,  pix_b_or;
    wire [10:0]blk_out_x;
    wire [9:0] blk_out_y;
    wire clkout;
    reg [1:0] counterColumn = 2'd0;
    reg [1:0] counterRow = 2'd0;
    reg clkdraw = 1'b0;
    wire [16:0] R_rom_addr;
    wire [12:0] R_rom_addr_stone0;
    wire [11:0] R_rom_addr_gold0, R_rom_addr_gold1;
    wire [10:0] R_rom_addr_diamond0;
    wire [7:0] W_rom_data, W_rom_data_gold0, W_rom_data_gold1, W_rom_data_diamond0, W_rom_data_stone0;
    wire [10:0] x9,x8,x7,x6,x5,x4,x3,x2,x1,x0;
    wire [9:0] y9,y8,y7,y6,y5,y4,y3,y2,y1,y0;
    
    //regs for hitting logic, updated one time during hitting, and keep the same between two hittings
    reg [3:0] hitted_gold;
    
    /*Divide to 60HZ clk*/
    reg pixclk_60 = 1'b0;
    reg [20:0] clk_counter = 21'd0;
    always @(posedge clk)
    begin
    clk_counter = clk_counter + 21'd1;
    if (clk_counter == 21'd695500)
        begin
        clk_counter = 21'd0;
        pixclk_60 =  ~pixclk_60;
        end
    end
    
    /* State Machine*/
    parameter waving = 2'b00, stretching = 2'b01, hitting = 2'b10, missing = 2'b11;
    parameter hookThresholdHeight = 10'd242, hookThresholdLeft = 11'd560, hookThresholdRight = 11'd710;
    reg [1:0] next_state, state;
    
    always @(posedge pixclk_60) // Update current state
    begin
        if (rst)
            state <= waving;
        else
            state <= next_state;
    end
    
    always @(posedge pixclk_60) // Trigger next state
    begin
        next_state = state;
        case(state)
        waving: if(button == 1) next_state = stretching;
        stretching:
               if((blk_out_x + 11'd32 >= 11'd1259) | (blk_out_x <= 11'd10) | (blk_out_y + 10'd32 >= 10'd779))
                    next_state = missing;
               else if ((blk_out_x > x0) & (blk_out_x <= x0 + 11'd59) & (blk_out_y > y0) & (blk_out_y < y0 + 10'd59)|
                      ((blk_out_x + 11'd32 >= x0) & (blk_out_x + 11'd32 < x0 + 11'd59)  & (blk_out_y >= y0) & (blk_out_y < y0 + 10'd59))|
                      ((blk_out_x + 11'd32 >= x0) & (blk_out_x + 11'd32 < x0 + 11'd59) & (blk_out_y  + 11'd32 >= y0) & (blk_out_y  + 11'd32 < y0 + 10'd59))|
                      ((blk_out_x > x0) & (blk_out_x <= x0 + 11'd59) & (blk_out_y  + 11'd32 >= y0) & (blk_out_y  + 11'd32 < y0 + 10'd59)))
                      
               begin //hit the first gold
                    next_state = hitting;
                    hitted_gold = 4'b0000;
               end
               else if ((blk_out_x > x1) & (blk_out_x <= x1 + 11'd59) & (blk_out_y > y1) & (blk_out_y < y1 + 10'd59)|
                      ((blk_out_x + 11'd32 >= x1) & (blk_out_x + 11'd32 < x1 + 11'd59)  & (blk_out_y >= y1) & (blk_out_y < y1 + 10'd59))|
                      ((blk_out_x + 11'd32 >= x1) & (blk_out_x + 11'd32 < x1 + 11'd59) & (blk_out_y  + 11'd32 >= y1) & (blk_out_y  + 11'd32 < y1 + 10'd59))|
                      ((blk_out_x > x1) & (blk_out_x <= x1 + 11'd59) & (blk_out_y  + 11'd32 >= y1) & (blk_out_y  + 11'd32 < y1 + 10'd59)))
               begin //hit the second gold
                    next_state = hitting;
                    hitted_gold = 4'b0001;
               end
               else if ((blk_out_x > x2) & (blk_out_x <= x2 + 11'd39) & (blk_out_y > y2) & (blk_out_y < y2 + 10'd39)|
                      ((blk_out_x + 11'd32 >= x2) & (blk_out_x + 11'd32 < x2 + 11'd39)  & (blk_out_y >= y2) & (blk_out_y < y2 + 10'd39))|
                      ((blk_out_x + 11'd32 >= x2) & (blk_out_x + 11'd32 < x2 + 11'd39) & (blk_out_y  + 11'd32 >= y2) & (blk_out_y  + 11'd32 < y2 + 10'd39))|
                      ((blk_out_x > x2) & (blk_out_x <= x2 + 11'd39) & (blk_out_y  + 11'd32 >= y2) & (blk_out_y  + 11'd32 < y2 + 10'd39)))
               begin //hit the second gold
                    next_state = hitting;
                    hitted_gold = 4'b0010;
               end
               else if ((blk_out_x > x3) & (blk_out_x <= x3 + 11'd79) & (blk_out_y > y3) & (blk_out_y < y3 + 10'd79)|
                      ((blk_out_x + 11'd32 >= x3) & (blk_out_x + 11'd32 < x3 + 11'd79)  & (blk_out_y >= y3) & (blk_out_y < y3 + 10'd79))|
                      ((blk_out_x + 11'd32 >= x3) & (blk_out_x + 11'd32 < x3 + 11'd79) & (blk_out_y  + 11'd32 >= y3) & (blk_out_y  + 11'd32 < y3 + 10'd79))|
                      ((blk_out_x > x3) & (blk_out_x <= x3 + 11'd79) & (blk_out_y  + 11'd32 >= y3) & (blk_out_y  + 11'd32 < y3 + 10'd79)))
               begin //hit the second gold
                    next_state = hitting;
                    hitted_gold = 4'b0011;
               end
        hitting:
                if(blk_out_y <=  hookThresholdHeight & blk_out_x >= hookThresholdLeft & blk_out_x <= hookThresholdRight)
                    next_state = waving;
        missing: 
                if(blk_out_y <= hookThresholdHeight & blk_out_x >= hookThresholdLeft & blk_out_x <= hookThresholdRight)
                    next_state = waving;
        default: next_state = waving;
        endcase
    end
  
    /* pixal clock instance */
    clk_wiz_0 pixClkIns (.clk_in1(clk), .clk_out1(clkout));
    
    /* store background image instance */
    //for testing, comment this instance
    blk_mem_gen_0 rom (.clka(clkout), .addra(R_rom_addr), .douta(W_rom_data));
    blk_mem_gen_1 rom_gold0 (.clka(clkout), .addra(R_rom_addr_gold0), .douta(W_rom_data_gold0));
    blk_mem_gen_1 rom_gold1 (.clka(clkout), .addra(R_rom_addr_gold1), .douta(W_rom_data_gold1));
    blk_mem_gen_2 rom_diamond0 (.clka(clkout), .addra(R_rom_addr_diamond0), .douta(W_rom_data_diamond0));
    blk_mem_gen_3 rom_stone0 (.clka(clkout), .addra(R_rom_addr_stone0), .douta(W_rom_data_stone0));
    /* vga-out instance */
    vga_out vgainst (.clk(clkout), .rst(rst), .draw_r(pix_r_or), .draw_g(pix_g_or), .draw_b(pix_b_or),                  
    .pix_r(pix_r), .pix_g(pix_g), .pix_b(pix_b), .hsync(hsync), .vsync(vsync), .curr_x(curr_x), .curr_y(curr_y)); 
    
    /* get background figure instance*/
    //for testing, comment this instance
    bkg_figure bkg (.clk(clkout), .rst(rst), .curr_x(curr_x), .curr_y(curr_y), .addr(R_rom_addr));
    
    goldpositions gold_blk (.clk(clkout), .pixclk_60(pixclk_60), .rst(rst), .curr_x(curr_x), .curr_y(curr_y),
     .hitted_gold(hitted_gold), .blk_x(blk_out_x), .blk_y(blk_out_y), 
    .addr0(R_rom_addr_gold0), .addr1(R_rom_addr_gold1), .addr2(R_rom_addr_diamond0),.addr3(R_rom_addr_stone0),
    .state(state),
    .x9(x9), .x8(x8), .x7(x7), .x6(x6), .x5(x5), .x4(x4), .x3(x3), .x2(x2), .x1(x1), .x0(x0),
    .y9(y9), .y8(y8), .y7(y7), .y6(y6), .y5(y5), .y4(y4), .y3(y3), .y2(y2), .y1(y1), .y0(y0));
    
    /* get hook moving positions*/
    hook_moving moveHook(.state(state), .pixclk_60(pixclk_60), .blkpos_x_out(blk_out_x), .blkpos_y_out(blk_out_y));
    
    /* drawcon instance*/ 
    //for testing, comment W_rom_data , use the second row   
    drawcon drawEnvironment (.hitted_x(hitted_x), .hitted_y(hitted_y), 
    .W_rom_data(W_rom_data), .W_rom_data_gold0(W_rom_data_gold0),.W_rom_data_gold1(W_rom_data_gold1),
    .W_rom_data_diamond0(W_rom_data_diamond0),.W_rom_data_stone0(W_rom_data_stone0),
 .blkpos_x(blk_out_x), .blkpos_y(blk_out_y),.draw_x(curr_x), .draw_y(curr_y), .draw_r(pix_r_or), .draw_g(pix_g_or), .draw_b(pix_b_or), 
    .x9(x9), .x8(x8), .x7(x7), .x6(x6), .x5(x5), .x4(x4), .x3(x3), .x2(x2), .x1(x1), .x0(x0),
    .y9(y9), .y8(y8), .y7(y7), .y6(y6), .y5(y5), .y4(y4), .y3(y3), .y2(y2), .y1(y1), .y0(y0));
//    drawcon drawEnvironment (.W_rom_data_gold0(W_rom_data_gold0),.W_rom_data_gold1(W_rom_data_gold1),
//     .blkpos_x(blk_out_x), .blkpos_y(blk_out_y),.draw_x(curr_x), .draw_y(curr_y), 
//     .draw_r(pix_r_or), .draw_g(pix_g_or), .draw_b(pix_b_or),
//        .x9(x9), .x8(x8), .x7(x7), .x6(x6), .x5(x5), .x4(x4), .x3(x3), .x2(x2), .x1(x1), .x0(x0),
//        .y9(y9), .y8(y8), .y7(y7), .y6(y6), .y5(y5), .y4(y4), .y3(y3), .y2(y2), .y1(y1), .y0(y0));
    
    
     
endmodule
