`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2024/11/09 21:12:56
// Design Name: 
// Module Name: binary_to_bcd
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


module binary_to_bcd(
    input  [7:0] binary_in, 
    output [3:0] bcd_hundreds,   
    output [3:0] bcd_tens,       
    output [3:0] bcd_ones       
);
    // Store the processing data
    wire [19:0] shift_reg [0:8];
    genvar i;
    
    assign shift_reg[0] = {12'd0, binary_in};

    // Use double dabble method
    generate
        for (i = 0; i < 8; i = i + 1) begin : dd_logic
            wire [3:0] hundreds = shift_reg[i][19:16];
            wire [3:0] tens     = shift_reg[i][15:12];
            wire [3:0] ones     = shift_reg[i][11:8];
            wire [19:0] shifted;

            wire [3:0] hundreds_adj = (hundreds >= 5) ? hundreds + 4'd3 : hundreds;
            wire [3:0] tens_adj     = (tens     >= 5) ? tens     + 4'd3 : tens;
            wire [3:0] ones_adj     = (ones     >= 5) ? ones     + 4'd3 : ones;

            assign shifted = {hundreds_adj, tens_adj, ones_adj, shift_reg[i][7:0]} << 1;

            assign shift_reg[i+1] = shifted;
        end
    endgenerate

    assign bcd_hundreds = shift_reg[8][19:16];
    assign bcd_tens     = shift_reg[8][15:12];
    assign bcd_ones     = shift_reg[8][11:8];

endmodule
