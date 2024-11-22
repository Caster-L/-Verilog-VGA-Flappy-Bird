`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2024/11/02 14:11:37
// Design Name: 
// Module Name: random_generate
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


module random_generate(
    input clk,
    input rst,
    input seed,
    output [7:0] random_data
    );

    reg [7:0] cnt;

    always @(posedge clk, posedge rst) begin
        if (rst) begin
            cnt <= 0;
        end else begin
            if (seed) begin
                cnt <= cnt + 1;
            end else begin
                cnt <= cnt;
            end
        end
    end

    assign random_data = cnt;
endmodule
