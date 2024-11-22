`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2024/11/09 21:15:50
// Design Name: 
// Module Name: binary_to_bcd_tb
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


`timescale 1ns / 1ps

module binary_to_bcd_tb;

    reg [7:0] binary_in;
    wire [3:0] bcd_hundreds;
    wire [3:0] bcd_tens;
    wire [3:0] bcd_ones;

    binary_to_bcd uut (
        .binary_in(binary_in),
        .bcd_hundreds(bcd_hundreds),
        .bcd_tens(bcd_tens),
        .bcd_ones(bcd_ones)
    );

    initial begin
        binary_in = 8'd0;
        #10;

        binary_in = 8'd0;
        #10;

        binary_in = 8'd9;
        #10;

        binary_in = 8'd42;
        #10;

        binary_in = 8'd99;
        #10;

        binary_in = 8'd123;
        #10;

        binary_in = 8'd255;
        #10;

        $finish;
    end

endmodule