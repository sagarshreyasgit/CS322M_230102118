`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 17.08.2025 14:49:26
// Design Name: 
// Module Name: tb_seq_detect_mealy
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


module tb_seq_detect_mealy;

    parameter CLK_PERIOD = 10;

    reg clk;
    reg rst;
    reg din;
    wire y;
    seq_detect_mealy dut (
        .clk(clk),
        .rst(rst),
        .din(din),
        .y(y)
    );
    reg [10:0] test_stream;
    initial begin
        clk = 0;
        forever #(CLK_PERIOD / 2) clk = ~clk;
    end

    initial begin
        $dumpfile("dump.vcd");
        $dumpvars(0, tb_seq_detect_mealy);

        test_stream = 11'b11011011101;

        rst = 1; // Assert active-high reset
        din = 0;
        @(posedge clk);
        @(posedge clk); // Hold reset for 2 clock cycles
        rst = 0; // De-assert reset
        @(posedge clk);

        for (integer i = 10; i >= 0; i = i - 1) begin
            din = test_stream[i];
            @(posedge clk);
        end

        din = 0;
        @(posedge clk);
        @(posedge clk);

        $display("Simulation finished.");
        $finish;
    end

    initial begin
        $monitor("Time = %0t ns\t rst = %b\t din = %b\t y = %b", $time, rst, din, y);
    end

endmodule
