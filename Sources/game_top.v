`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/31/2021 08:37:18 PM
// Design Name: GoldMiner
// Module Name: game_top
// Project Name: GoldMiner
// Target Devices: 
// Tool Versions: 
// Description: 
// The top module controls the game state.
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
    output vsync,
    output a, b, c, d, e, f, g,
    output [7:0] an
    );
    //current drawing position
    wire [10:0]curr_x;
    wire [9:0]curr_y;
    //rgb data
    wire [3:0] pix_r_or,  pix_g_or,  pix_b_or;
    // block position
    wire [10:0]blk_out_x;
    wire [9:0] blk_out_y;
    //83.34M clock
    wire clkout;
    //column and row counters
    reg [1:0] counterColumn = 2'd0;
    reg [1:0] counterRow = 2'd0;
    //address for ROM blocks
    wire [16:0] R_rom_addr,R_rom_addr_end;
    wire [12:0] R_rom_addr_stone7, R_rom_addr_stone8,  R_rom_addr_stone9 ;
    wire [11:0] R_rom_addr_gold0, R_rom_addr_gold1, R_rom_addr_gold2, R_rom_addr_gold3, R_rom_addr_gold4;
    wire [10:0] R_rom_addr_diamond5, R_rom_addr_diamond6;
    wire [9:0] R_rom_addr_hook;
    //RGB output of ROM blocks
    wire [7:0] W_rom_data,W_rom_data_end, W_rom_data_gold0, W_rom_data_gold1, W_rom_data_gold2, W_rom_data_gold3, W_rom_data_gold4,
     W_rom_data_diamond5,W_rom_data_diamond6,
     W_rom_data_stone7, W_rom_data_stone8, W_rom_data_stone9,W_rom_data_hook;
     //(x,y) positions for golds
    wire [10:0] x9,x8,x7,x6,x5,x4,x3,x2,x1,x0;
    wire [9:0] y9,y8,y7,y6,y5,y4,y3,y2,y1,y0;
    // LED: scores and time
    reg [7:0] score = 8'd0;
    //regs for hitting logic, updated one time during hitting, and keep the same between two hittings
    reg [3:0] hitted_gold;
    //Whether the game is done or not
    reg done_game;
    
    /*Divide to 60HZ clk*/
    reg pixclk_60 = 1'b0;
    reg [20:0] clk_counter = 21'd0;
    always @(posedge clk)
    begin
    clk_counter = clk_counter + 21'd1;
    if (clk_counter == 21'd600000) //
        begin
        clk_counter = 21'd0;
        pixclk_60 =  ~pixclk_60;
        end
    end

     /* Time Down Count 90 seconds*/
    reg [7:0] clk_1hz_counter = 8'd0;
    reg [7:0] time_show = 8'd90;
    always @(posedge pixclk_60)
        begin
        if (rst)
          begin
            clk_1hz_counter = 8'd0;
            time_show = 8'd90;
          end
        else
          begin
            clk_1hz_counter = clk_1hz_counter + 8'd1;
            if (clk_1hz_counter == 8'd83)
            begin
                if(time_show > 8'd0)
                begin
                    time_show <= time_show - 8'd1;
                end
                clk_1hz_counter = 0;
            end
          end
        end
     
     always @* begin
        if (time_show == 8'd0)  done_game = 1;
        else done_game = 0;
     end 
    
    /* State Machine*/
    parameter waving = 2'b00, stretching = 2'b01, hitting = 2'b10, missing = 2'b11;
    parameter hookThresholdHeight = 10'd242, hookThresholdLeft = 11'd560, hookThresholdRight = 11'd710;
    reg [1:0] next_state, state;
    
    always @(posedge pixclk_60) // Update current state
    begin
        if (rst)
        begin
            state <= waving;
        end
        else
            state <= next_state;
    end
    
    always @(posedge pixclk_60) // Trigger next state
    begin
        if (rst)
        begin
            score <= 8'd0;
        end
        next_state = state;
        case(state)
        waving: if(button == 1) next_state = stretching;
        stretching:
               if((blk_out_x + 11'd32 >= 11'd1259) | (blk_out_x <= 11'd10) | (blk_out_y + 10'd32 >= 10'd779))
                    next_state = missing;
               else if (((blk_out_x > x0) & (blk_out_x <= x0 + 11'd59) & (blk_out_y > y0) & (blk_out_y < y0 + 10'd59))|
                      ((blk_out_x + 11'd32 >= x0) & (blk_out_x + 11'd32 < x0 + 11'd59)  & (blk_out_y >= y0) & (blk_out_y < y0 + 10'd59))|
                      ((blk_out_x + 11'd32 >= x0) & (blk_out_x + 11'd32 < x0 + 11'd59) & (blk_out_y  + 11'd32 >= y0) & (blk_out_y  + 11'd32 < y0 + 10'd59))|
                      ((blk_out_x > x0) & (blk_out_x <= x0 + 11'd59) & (blk_out_y  + 11'd32 >= y0) & (blk_out_y  + 11'd32 < y0 + 10'd59)))
                      
               begin //hit the first gold
                    next_state = hitting;
                    hitted_gold = 4'b0000;
                    score = score + 8'd6;
               end
               else if (((blk_out_x > x1) & (blk_out_x <= x1 + 11'd59) & (blk_out_y > y1) & (blk_out_y < y1 + 10'd59))|
                      ((blk_out_x + 11'd32 >= x1) & (blk_out_x + 11'd32 < x1 + 11'd59)  & (blk_out_y >= y1) & (blk_out_y < y1 + 10'd59))|
                      ((blk_out_x + 11'd32 >= x1) & (blk_out_x + 11'd32 < x1 + 11'd59) & (blk_out_y  + 11'd32 >= y1) & (blk_out_y  + 11'd32 < y1 + 10'd59))|
                      ((blk_out_x > x1) & (blk_out_x <= x1 + 11'd59) & (blk_out_y  + 11'd32 >= y1) & (blk_out_y  + 11'd32 < y1 + 10'd59)))
               begin //hit the second gold
                    next_state = hitting;
                    hitted_gold = 4'b0001;
                    score = score + 8'd6;
               end
               else if (((blk_out_x > x2) & (blk_out_x <= x2 + 11'd59) & (blk_out_y > y2) & (blk_out_y < y2 + 10'd59))|
                      ((blk_out_x + 11'd32 >= x2) & (blk_out_x + 11'd32 < x2 + 11'd59)  & (blk_out_y >= y2) & (blk_out_y < y2 + 10'd59))|
                      ((blk_out_x + 11'd32 >= x2) & (blk_out_x + 11'd32 < x2 + 11'd59) & (blk_out_y  + 11'd32 >= y2) & (blk_out_y  + 11'd32 < y2 + 10'd59))|
                      ((blk_out_x > x2) & (blk_out_x <= x2 + 11'd59) & (blk_out_y  + 11'd32 >= y2) & (blk_out_y  + 11'd32 < y2 + 10'd59)))
               begin //hit the third gold
                    next_state = hitting;
                    hitted_gold = 4'b0010;
                    score = score + 8'd6;
               end
               else if (((blk_out_x > x3) & (blk_out_x <= x3 + 11'd59) & (blk_out_y > y3) & (blk_out_y < y3 + 10'd59))|
                      ((blk_out_x + 11'd32 >= x3) & (blk_out_x + 11'd32 < x3 + 11'd59)  & (blk_out_y >= y3) & (blk_out_y < y3 + 10'd59))|
                      ((blk_out_x + 11'd32 >= x3) & (blk_out_x + 11'd32 < x3 + 11'd59) & (blk_out_y  + 11'd32 >= y3) & (blk_out_y  + 11'd32 < y3 + 10'd59))|
                      ((blk_out_x > x3) & (blk_out_x <= x3 + 11'd59) & (blk_out_y  + 11'd32 >= y3) & (blk_out_y  + 11'd32 < y3 + 10'd59)))
               begin //hit the fourth gold
                    next_state = hitting;
                    hitted_gold = 4'b0011;
                    score =score + 8'd6;
               end
               else if (((blk_out_x > x4) & (blk_out_x <= x4 + 11'd59) & (blk_out_y > y4) & (blk_out_y < y4 + 10'd59))|
                      ((blk_out_x + 11'd32 >= x4) & (blk_out_x + 11'd32 < x4 + 11'd59)  & (blk_out_y >= y4) & (blk_out_y < y4 + 10'd59))|
                      ((blk_out_x + 11'd32 >= x4) & (blk_out_x + 11'd32 < x4 + 11'd59) & (blk_out_y  + 11'd32 >= y4) & (blk_out_y  + 11'd32 < y4 + 10'd59))|
                      ((blk_out_x > x4) & (blk_out_x <= x4 + 11'd59) & (blk_out_y  + 11'd32 >= y4) & (blk_out_y  + 11'd32 < y4 + 10'd59)))
               begin //hit the fifth gold
                    next_state = hitting;
                    hitted_gold = 4'b0100;
                    score =score + 8'd6;
               end
               else if (((blk_out_x > x5) & (blk_out_x <= x5 + 11'd39) & (blk_out_y > y5) & (blk_out_y < y5 + 10'd39))|
                      ((blk_out_x + 11'd32 >= x5) & (blk_out_x + 11'd32 < x5 + 11'd39)  & (blk_out_y >= y5) & (blk_out_y < y5 + 10'd39))|
                      ((blk_out_x + 11'd32 >= x5) & (blk_out_x + 11'd32 < x5 + 11'd39) & (blk_out_y  + 11'd32 >= y5) & (blk_out_y  + 11'd32 < y5 + 10'd39))|
                      ((blk_out_x > x5) & (blk_out_x <= x5 + 11'd39) & (blk_out_y  + 11'd32 >= y5) & (blk_out_y  + 11'd32 < y5 + 10'd39)))
               begin //hit the sixth diamond
                    next_state = hitting;
                    hitted_gold = 4'b0101;
                    score =score + 8'd10;
               end
               else if (((blk_out_x > x6) & (blk_out_x <= x6 + 11'd39) & (blk_out_y > y6) & (blk_out_y < y6 + 10'd39))|
                      ((blk_out_x + 11'd32 >= x6) & (blk_out_x + 11'd32 < x6 + 11'd39)  & (blk_out_y >= y6) & (blk_out_y < y6 + 10'd39))|
                      ((blk_out_x + 11'd32 >= x6) & (blk_out_x + 11'd32 < x6 + 11'd39) & (blk_out_y  + 11'd32 >= y6) & (blk_out_y  + 11'd32 < y6 + 10'd39))|
                      ((blk_out_x > x6) & (blk_out_x <= x6 + 11'd39) & (blk_out_y  + 11'd32 >= y6) & (blk_out_y  + 11'd32 < y6 + 10'd39)))
               begin //hit the seventh diamond
                    next_state = hitting;
                    hitted_gold = 4'b0110;
                    score =score + 8'd10;
               end
               else if (((blk_out_x > x7) & (blk_out_x <= x7 + 11'd79) & (blk_out_y > y7) & (blk_out_y < y7 + 10'd79))|
                      ((blk_out_x + 11'd32 >= x7) & (blk_out_x + 11'd32 < x7 + 11'd79)  & (blk_out_y >= y7) & (blk_out_y < y7 + 10'd79))|
                      ((blk_out_x + 11'd32 >= x7) & (blk_out_x + 11'd32 < x7 + 11'd79) & (blk_out_y  + 11'd32 >= y7) & (blk_out_y  + 11'd32 < y7 + 10'd79))|
                      ((blk_out_x > x7) & (blk_out_x <= x7 + 11'd79) & (blk_out_y  + 11'd32 >= y7) & (blk_out_y  + 11'd32 < y7 + 10'd79)))
               begin //hit the eighth stone
                    next_state = hitting;
                    hitted_gold = 4'b0111;
                    score =score + 8'd0;
               end
               else if (((blk_out_x > x8) & (blk_out_x <= x8 + 11'd79) & (blk_out_y > y8) & (blk_out_y < y8 + 10'd79))|
                      ((blk_out_x + 11'd32 >= x8) & (blk_out_x + 11'd32 < x8 + 11'd79)  & (blk_out_y >= y8) & (blk_out_y < y8 + 10'd79))|
                      ((blk_out_x + 11'd32 >= x8) & (blk_out_x + 11'd32 < x8 + 11'd79) & (blk_out_y  + 11'd32 >= y8) & (blk_out_y  + 11'd32 < y8 + 10'd79))|
                      ((blk_out_x > x8) & (blk_out_x <= x8 + 11'd79) & (blk_out_y  + 11'd32 >= y8) & (blk_out_y  + 11'd32 < y8 + 10'd79)))
               begin //hit the ninth stone
                    next_state = hitting;
                    hitted_gold = 4'b1000;
                    score =score + 8'd0;
               end
               else if (((blk_out_x > x9) & (blk_out_x <= x9 + 11'd79) & (blk_out_y > y9) & (blk_out_y < y9 + 10'd79))|
                      ((blk_out_x + 11'd32 >= x9) & (blk_out_x + 11'd32 < x9 + 11'd79)  & (blk_out_y >= y9) & (blk_out_y < y9 + 10'd79))|
                      ((blk_out_x + 11'd32 >= x9) & (blk_out_x + 11'd32 < x9 + 11'd79) & (blk_out_y  + 11'd32 >= y9) & (blk_out_y  + 11'd32 < y9 + 10'd79))|
                      ((blk_out_x > x9) & (blk_out_x <= x9 + 11'd79) & (blk_out_y  + 11'd32 >= y9) & (blk_out_y  + 11'd32 < y9 + 10'd79)))
               begin //hit the tenth stone
                    next_state = hitting;
                    hitted_gold = 4'b1001;
                    score =score + 8'd0;
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
    blk_mem_gen_0 rom (.clka(clkout), .addra(R_rom_addr), .douta(W_rom_data));
    blk_mem_gen_5 rom_end (.clka(clkout), .addra(R_rom_addr_end), .douta(W_rom_data_end));
    blk_mem_gen_1 rom_gold0 (.clka(clkout), .addra(R_rom_addr_gold0), .douta(W_rom_data_gold0));
    blk_mem_gen_1 rom_gold1 (.clka(clkout), .addra(R_rom_addr_gold1), .douta(W_rom_data_gold1));
    blk_mem_gen_1 rom_gold2 (.clka(clkout), .addra(R_rom_addr_gold2), .douta(W_rom_data_gold2));
    blk_mem_gen_1 rom_gold3 (.clka(clkout), .addra(R_rom_addr_gold3), .douta(W_rom_data_gold3));
    blk_mem_gen_1 rom_gold4 (.clka(clkout), .addra(R_rom_addr_gold4), .douta(W_rom_data_gold4));
    blk_mem_gen_2 rom_diamond5 (.clka(clkout), .addra(R_rom_addr_diamond5), .douta(W_rom_data_diamond5));
    blk_mem_gen_2 rom_diamond6 (.clka(clkout), .addra(R_rom_addr_diamond6), .douta(W_rom_data_diamond6));
    blk_mem_gen_3 rom_stone7 (.clka(clkout), .addra(R_rom_addr_stone7), .douta(W_rom_data_stone7));
    blk_mem_gen_3 rom_stone8 (.clka(clkout), .addra(R_rom_addr_stone8), .douta(W_rom_data_stone8));
    blk_mem_gen_3 rom_stone9 (.clka(clkout), .addra(R_rom_addr_stone9), .douta(W_rom_data_stone9));
    blk_mem_gen_4 rom_hook (.clka(clkout), .addra(R_rom_addr_hook), .douta(W_rom_data_hook));

    /* vga-out instance */
    vga_out vgainst (.clk(clkout), .rst(rst), .draw_r(pix_r_or), .draw_g(pix_g_or), .draw_b(pix_b_or),                  
    .pix_r(pix_r), .pix_g(pix_g), .pix_b(pix_b), .hsync(hsync), .vsync(vsync), .curr_x(curr_x), .curr_y(curr_y)); 
    
    /* get background figure instance*/
    bkg_figure bkg (.clk(clkout), .rst(rst), .curr_x(curr_x), .curr_y(curr_y), .addr(R_rom_addr));
    bkg_figure_end bkg_end (.clk(clkout), .rst(rst), .curr_x(curr_x), .curr_y(curr_y), .addr(R_rom_addr_end));
    goldpositions gold_blk (.clk(clkout), .pixclk_60(pixclk_60), .rst(rst), .curr_x(curr_x), .curr_y(curr_y),
     .hitted_gold(hitted_gold), .blk_x(blk_out_x), .blk_y(blk_out_y), 
    .addr0(R_rom_addr_gold0), .addr1(R_rom_addr_gold1), .addr2(R_rom_addr_gold2),.addr3(R_rom_addr_gold3),.addr4(R_rom_addr_gold4),
    .addr5(R_rom_addr_diamond5), .addr6(R_rom_addr_diamond6), .addr7(R_rom_addr_stone7),.addr8(R_rom_addr_stone8), .addr9(R_rom_addr_stone9),
    .state(state),
    .x9(x9), .x8(x8), .x7(x7), .x6(x6), .x5(x5), .x4(x4), .x3(x3), .x2(x2), .x1(x1), .x0(x0),
    .y9(y9), .y8(y8), .y7(y7), .y6(y6), .y5(y5), .y4(y4), .y3(y3), .y2(y2), .y1(y1), .y0(y0));
    hook_image hook_blk(.clk(clkout), .rst(rst), .curr_x(curr_x), .curr_y(curr_y), .blk_out_x(blk_out_x), .blk_out_y(blk_out_y), .addr(R_rom_addr_hook));
    
    /* get hook moving positions*/
    hook_moving moveHook(.rst(rst), .state(state), .pixclk_60(pixclk_60), .blkpos_x_out(blk_out_x), .blkpos_y_out(blk_out_y));
    
    /* drawcon instance*/ 
    drawcon drawEnvironment (.hitted_x(hitted_x), .hitted_y(hitted_y), 
    .W_rom_data(W_rom_data), .W_rom_data_end(W_rom_data_end),
    .W_rom_data_gold0(W_rom_data_gold0),.W_rom_data_gold1(W_rom_data_gold1),.W_rom_data_gold2(W_rom_data_gold2),.W_rom_data_gold3(W_rom_data_gold3),.W_rom_data_gold4(W_rom_data_gold4),
    .W_rom_data_diamond5(W_rom_data_diamond5),.W_rom_data_diamond6(W_rom_data_diamond6),
    .W_rom_data_stone7(W_rom_data_stone7), .W_rom_data_stone8(W_rom_data_stone8), .W_rom_data_stone9(W_rom_data_stone9),  .W_rom_data_hook(W_rom_data_hook),
    .blkpos_x(blk_out_x), .blkpos_y(blk_out_y),.draw_x(curr_x), .draw_y(curr_y), .draw_r(pix_r_or), .draw_g(pix_g_or), .draw_b(pix_b_or), 
    .x9(x9), .x8(x8), .x7(x7), .x6(x6), .x5(x5), .x4(x4), .x3(x3), .x2(x2), .x1(x1), .x0(x0),
    .y9(y9), .y8(y8), .y7(y7), .y6(y6), .y5(y5), .y4(y4), .y3(y3), .y2(y2), .y1(y1), .y0(y0),
    .done_game(done_game));
                                                                                                                                                   
    /*LED*/                                                                                                                                     
    score_leds score_leds_0(.clk(clk), .time_show(time_show), .rst(rst), .score(score), .a(a), .b(b), .c(c), .d(d), .e(e), .f(f), .g(g),.an(an));
      
endmodule