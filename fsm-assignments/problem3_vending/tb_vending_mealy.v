`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 18.08.2025 19:01:21
// Design Name: 
// Module Name: tb_vending_mealy
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

module tb_vending_mealy;

    parameter CLK_PERIOD = 10;
    
    reg clk;
    reg rst;
    reg [1:0] coin;
    wire dispense;
    wire chg5;

    vending_mealy dut (
        .clk(clk),
        .rst(rst),
        .coin(coin),
        .dispense(dispense),
        .chg5(chg5)
    );

    initial begin
        clk = 0;
        forever #(CLK_PERIOD / 2) clk = ~clk;
    end

    task insert_coin;
        input [1:0] c;
        begin
            @(posedge clk);
            coin = c;
            @(posedge clk);
            coin = 2'b00; // Return to idle
        end
    endtask
    
    initial begin
        $dumpfile("vending.vcd");
        $dumpvars(0, tb_vending_mealy);

        rst = 1;
        coin = 2'b00;
        repeat(2) @(posedge clk);
        rst = 0;
        @(posedge clk);

        $display("\n--- Starting Vending Machine Test ---");

        // Test Case 1: Exact change (10 + 10)
        $display("\n--> Test Case 1: 10 + 10 = 20");
        insert_coin(2'b10); // 10
        insert_coin(2'b10); // 20 -> dispense
        repeat(2) @(posedge clk);

        // Test Case 2: Exact change (5+5+5+5)
        $display("\n--> Test Case 2: 5 + 5 + 5 + 5 = 20");
        insert_coin(2'b01); // 5
        insert_coin(2'b01); // 10
        insert_coin(2'b01); // 15
        insert_coin(2'b01); // 20 -> dispense
        repeat(2) @(posedge clk);

        // Test Case 3: Change required (10 + 5 + 10)
        $display("\n--> Test Case 3: 10 + 5 + 10 = 25");
        insert_coin(2'b10); // 10
        insert_coin(2'b01); // 15
        insert_coin(2'b10); // 25 -> dispense + change
        repeat(2) @(posedge clk);
        
        // Test Case 4: Idle and invalid coins
        $display("\n--> Test Case 4: 5 + idle + 10 + invalid + 5");
        insert_coin(2'b01);       // 5
        insert_coin(2'b00);       // still 5
        insert_coin(2'b10);       // 15
        insert_coin(2'b11);       // still 15
        insert_coin(2'b01);       // 20 -> dispense
        
        $display("\n--- Test Finished ---");
        $finish;
    end
    
    initial begin
        $monitor("Time=%0t ns, rst=%b, coin=%b, dispense=%b, chg5=%b, state=%b",
                 $time, rst, coin, dispense, chg5, dut.state_reg);
    end

endmodule

