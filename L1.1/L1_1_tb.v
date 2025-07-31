`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 31.07.2025 10:01:57
// Design Name: 
// Module Name: L1_1_tb
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


module L1_1_tb(

    );
reg A, B;
    wire o1, o2, o3;

    L1_1 uut (
        .A(A),
        .B(B),
        .o1(o1),
        .o2(o2),
        .o3(o3)
    );

    initial begin
        A = 0; B = 0; #10;
        A = 0; B = 1; #10;
        A = 1; B = 0; #10;
        A = 1; B = 1; #10;
        $stop;
    end
endmodule
