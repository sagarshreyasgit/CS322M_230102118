`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 31.07.2025 10:01:15
// Design Name: 
// Module Name: L1_1
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


module L1_1(
    input A,
    input B,
    output o1,
    output o2,
    output o3
    );
    assign o1 = A & ~B;
    assign o2 = ~(A ^ B);
    assign o3 = ~A & B;
endmodule
