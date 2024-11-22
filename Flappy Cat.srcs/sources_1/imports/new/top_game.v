`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2024/11/01 14:39:52
// Design Name: 
// Module Name: top_game
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


module top_game(
    input clk,
    input rst,
    input rst_game_n,
    input [4:0] BTN,
    output [3:0] VGA_RED,
    output [3:0] VGA_GREEN,
    output [3:0] VGA_BLUE,
    output VGA_HS,
    output VGA_VS
    );

    // Clock wires
    wire clk_25MHz;
    wire clk_locked;

    // VGA signals
    wire [9:0] h_cnt, v_cnt;
    wire [7:0] random, score;
    wire [9:0] x_chr, y_chr, x_obs, y_obs;
    wire [3:0] data_r, data_g, data_b;

    wire left, right, jump;

    clk_wiz_0 clk_wiz_25MHz (
        .clk_in1(clk),
        .clk_out1(clk_25MHz),
        .reset(rst),
        .locked(clk_locked)
    );
    
    button_debounce left_button  (
        .clk(clk_25MHz),
        .BTN_i(BTN[1]),
        .BTN_o(left)
    );
    button_debounce right_button (
        .clk(clk_25MHz),
        .BTN_i(BTN[2]),
        .BTN_o(right)
    );
    button_debounce jump_button  (
        .clk(clk_25MHz),
        .BTN_i(BTN[4]),
        .BTN_o(jump)
    );

    random_generate random_location (
        .clk(clk_25MHz),
        .rst(rst),
        .seed(jump),
        .random_data(random)
    );

    character_location chr_location (
        .clk(clk_25MHz),
        .rst(rst),
        .rst_game_n(rst_game_n),
        .jump(jump),
        .left(left),
        .right(right),
        .h_location(x_chr),
        .v_location(y_chr)
    );

    obstacle_location obs_location (
        .clk(clk_25MHz),
        .rst(rst),
        .rst_game_n(rst_game_n),
        .origin(150 + random),
        .v_location(y_obs),
        .h_location(x_obs)
    );

    image_processor img_inst (
        .clk_vga(clk_25MHz),
        .rst_game_n(rst_game_n),
        .x_i(h_cnt),
        .y_i(v_cnt),
        .x_chr_i(x_chr),
        .y_chr_i(y_chr),
        .x_obs_i(x_obs),
        .y_obs_i(y_obs),
        .red_o(data_r),
        .green_o(data_g),
        .blue_o(data_b)
    );

    vga vga_inst (
        .clk_vga(clk_25MHz),
        .rst_vga(~clk_locked),
        .r_i(data_r),
        .g_i(data_g),
        .b_i(data_b),
        .x_o(h_cnt),
        .y_o(v_cnt),
        .vga_hs_o(VGA_HS),
        .vga_vs_o(VGA_VS),
        .vga_r_o(VGA_RED),
        .vga_g_o(VGA_GREEN),
        .vga_b_o(VGA_BLUE)
    );
    
endmodule
