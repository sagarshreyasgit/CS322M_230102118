`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 31.07.2025 10:12:11
// Design Name: 
// Module Name: L1_2_tb
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


module L1_2_tb();
reg [3:0] A, B;
wire eq;

     L1_2 uut (
        .A(A),
        .B(B),
        .eq(eq)
    );
    
    initial begin
        A = 4'b0000; B = 4'b0000; #10;
        A = 4'b1010; B = 4'b1010; #10;
        A = 4'b1111; B = 4'b1110; #10;
        A = 4'b0101; B = 4'b0101; #10;
        A = 4'b1100; B = 4'b0011; #10;
        $stop;
    end
endmodule
