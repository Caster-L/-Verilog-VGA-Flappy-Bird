`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2024/11/02 09:46:44
// Design Name: 
// Module Name: obstacle_location
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


module obstacle_location(
    input clk,
    input rst,
    input rst_game_n,
    input [9:0] origin,
    output reg[9:0] v_location,
    output reg[9:0] h_location
    );

    reg [20:0] cnt;

    always @(posedge clk, posedge rst) begin
        if (rst) begin
            cnt <= 0;
            v_location <= origin;
            h_location <= 10'd625;
        end else if (rst_game_n) begin
            if (cnt < 21'd100_000) begin
                cnt <= cnt + 1;
            end else begin
                if (h_location > 10'd0) begin
                    h_location <= h_location - 1;
                end else begin
                    h_location <= 625;
                    v_location <= origin;
                end
                cnt <= 0;
            end
        end else begin
            cnt <= 0;
            v_location <= 290;
            h_location <= 10'd625;
        end
    end
endmodule
