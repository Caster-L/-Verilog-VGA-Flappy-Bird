`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: Fudan University
// Engineer: Caster
// 
// Create Date: 2024/10/30 16:02:51
// Design Name: 
// Module Name: vga
// Project Name: VGA Game
// Target Devices: 
// Tool Versions: 
// Description: VGA Display
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module vga(
    input clk_vga,
    input rst_vga,
    input [3:0] r_i,
    input [3:0] g_i,
    input [3:0] b_i,
    output reg [9:0] x_o,
    output reg [9:0] y_o,
    output vga_hs_o,
    output vga_vs_o,
    output [3:0] vga_r_o,
    output [3:0] vga_g_o,
    output [3:0] vga_b_o
    );

    // Horizontal Timing Parameters
    localparam H_SYNC_PW = 96; // Horizontal Sync Pulse Width
    localparam H_L_PORCH = 48; // Horizontal Left Porch
    localparam H_VISIBLE = 640; // Visible Area
    localparam H_R_PORCH = 16; // Horizontal Right Porch
    localparam H_TOTAL_W = 800;

    // Vertical Timing Parameters
    localparam V_SYNC_PW = 2; // Vertical Sync Pulse Width
    localparam V_U_PORCH = 33; // Vertical Up Porch
    localparam V_VISIBLE = 480; // Visible Area
    localparam V_D_PORCH = 10; // Vertical Down Porch
    localparam V_TOTAL_H = 525;

    reg [9:0] h_cnt, v_cnt; // Horizontal Counter and Vertical Counter
    reg rgb_en;

    // Scan the horizontal and vertical line
    always @(posedge clk_vga) begin
        if (rst_vga) begin
            v_cnt <= 0;
            h_cnt <= 0;
        end else begin
            if (h_cnt == H_TOTAL_W - 1 && v_cnt == V_TOTAL_H - 1) begin
                h_cnt <= 0;
                v_cnt <= 0;
            end else if (h_cnt == H_TOTAL_W - 1) begin
                v_cnt <= v_cnt + 1;
                h_cnt <= 0;
            end else begin
                v_cnt <= v_cnt;
                h_cnt <= h_cnt + 1;
            end
        end
    end

    // Decide whether the pixel is lighten or not. Only in the visible area, the pixel is lighten.
    always @(*) begin
        if (rst_vga) begin
            x_o = 0;
            y_o = 0;
            rgb_en = 0;
        end else if (v_cnt >= V_SYNC_PW + V_U_PORCH && v_cnt < V_SYNC_PW + V_U_PORCH + V_VISIBLE 
                  && h_cnt >= H_SYNC_PW + H_L_PORCH && h_cnt < H_SYNC_PW + H_L_PORCH + H_VISIBLE) begin
            x_o = h_cnt - (H_SYNC_PW + H_L_PORCH);
            y_o = v_cnt - (V_SYNC_PW + V_U_PORCH);
            rgb_en = 1;
        end else begin
            x_o = x_o;
            y_o = y_o;
            rgb_en = 0;
        end
    end

    assign vga_vs_o = v_cnt < V_SYNC_PW;
    assign vga_hs_o = h_cnt < H_SYNC_PW;

    assign vga_r_o = rgb_en ? r_i : 4'd0;
    assign vga_b_o = rgb_en ? b_i : 4'd0;
    assign vga_g_o = rgb_en ? g_i : 4'd0;

endmodule
