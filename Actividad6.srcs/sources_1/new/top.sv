`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 20.10.2025 00:09:25
// Design Name: 
// Module Name: top
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


module top(
input  logic clk, reset, start,
    input  logic [7:0] swx, swy,
    output logic [6:0] seg,
    output logic [3:0] an
    );
    logic [7:0] resultado;
    control cpu (.clk(clk), .reset(reset), .xin(swx), .yin(swy), .gcd(resultado));
    
    x7segmux dis (.clk(clk), .an(an), .reset(reset), .sseg(seg),  .hex3(resultado [7:4]), .hex2(resultado [3:0]));
    
endmodule
