`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: Fudan University
// Engineer: Caster
// 
// Create Date: 2024/11/01 14:23:26
// Design Name: 
// Module Name: button_debounce
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


module button_debounce #(
    parameter [20:0] TIME_MIN = 21'd500_000
)(
    input clk,
    input rst,
    input BTN_i,
    output reg BTN_o
    );

    reg [20:0] cnt; // A small counter to debounce
    reg BTN_sync_0, BTN_sync_1; // Synchronized signal
    
    always @(posedge clk, posedge rst) begin
        if (rst) begin
            BTN_o <= 0;
            cnt <= 0;
            BTN_sync_0 <= 0;
            BTN_sync_1 <= 0;
        end else begin
            BTN_sync_0 <= BTN_i;
            BTN_sync_1 <= BTN_sync_0;
            if (BTN_sync_1 == BTN_o) begin
                cnt <= 0;
            end else begin
            cnt <= cnt + 1;
            if (cnt >= TIME_MIN) begin
                cnt <= 0;
                BTN_o <= BTN_sync_1;
            end
        end
        end
    end
endmodule