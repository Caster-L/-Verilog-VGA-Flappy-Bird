`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: Fudan University
// Engineer: Caster
// 
// Create Date: 2024/11/01 14:40:49
// Design Name: 
// Module Name: character_location
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


module character_location(
    input clk,
    input rst,
    input rst_game_n,
    input jump,
    input left,
    input right,
    output reg[9:0] v_location,
    output reg[9:0] h_location
    );

    reg jump_prev, left_prev, right_prev;
    reg [20:0] cnt, cnt_plus;
    reg [9:0] velocity;

    wire jump_impulse, left_impulse, right_impulse;

    // Check the button's positive edge
    assign jump_impulse = jump & ~jump_prev;
    assign left_impulse = left & ~left_prev;
    assign right_impulse = right & ~right_prev;

    // Store the previous state
    always @(posedge clk) begin
        jump_prev <= jump;
        left_prev <= left;
        right_prev <= right;
    end

    // Refresh the character's location
    always @(posedge clk, posedge rst) begin
        if (rst) begin
            v_location <= 10'd216;
            h_location <= 10'd300;
            velocity <= 0;
            cnt <= 0;
            cnt_plus <= 0;
        end else if (rst_game_n) begin
            if (jump_impulse) begin
                v_location <= v_location - 20;
                cnt <= 0;
                velocity <= 0;
                cnt_plus <= 0;
            end else if (left_impulse) begin
                h_location <= h_location - 10;
            end else if (right_impulse) begin
                h_location <= h_location + 10;
            end else begin
                if (cnt < 21'd400_000) begin
                    cnt <= cnt + 1;
                end else begin
                    if (cnt_plus < 21'd10) begin
                        v_location <= v_location + velocity;
                        cnt <= 0;
                        cnt_plus <= cnt_plus + 1;
                    end else begin
                        velocity <= velocity + 1;
                        cnt_plus <= 0;
                    end
                    
                end
            end
        end else begin
            v_location <= 10'd216;
            h_location <= 10'd300;
            velocity <= 0;
            cnt <= 0;
            cnt_plus <= 0;
        end
    end
endmodule
