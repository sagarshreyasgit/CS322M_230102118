`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 18.08.2025 19:00:57
// Design Name: 
// Module Name: vending_mealy
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

// vending_mealy.v
// Mealy FSM for a simple vending machine.

module vending_mealy(
    input wire clk,
    input wire rst,        
    input wire [1:0] coin,  // 01=5, 10=10, 00=idle
    output reg dispense,    // 1-cycle pulse
    output reg chg5         // 1-cycle pulse when returning 5
);

    localparam S_0  = 2'b00; 
    localparam S_5  = 2'b01; 
    localparam S_10 = 2'b10;
    localparam S_15 = 2'b11;

    reg [1:0] state_reg, state_next;

    always @(posedge clk) begin
        if (rst) begin
            state_reg <= S_0;
        end else begin
            state_reg <= state_next;
        end
    end

    always @(*) begin
        state_next = state_reg;
        dispense = 1'b0;
        chg5 = 1'b0;

        case (state_reg)
            S_0: begin // Total = 0
                if (coin == 2'b01) state_next = S_5;       // 0 + 5 = 5
                else if (coin == 2'b10) state_next = S_10; // 0 + 10 = 10
            end
            S_5: begin // Total = 5
                if (coin == 2'b01) state_next = S_10;      // 5 + 5 = 10
                else if (coin == 2'b10) state_next = S_15; // 5 + 10 = 15
            end
            S_10: begin // Total = 10
                if (coin == 2'b01) state_next = S_15;      // 10 + 5 = 15
                else if (coin == 2'b10) begin              // 10 + 10 = 20
                    dispense = 1'b1;
                    state_next = S_0; 
                end
            end
            S_15: begin // Total = 15
                if (coin == 2'b01) begin                   // 15 + 5 = 20
                    dispense = 1'b1;
                    state_next = S_0;
                end else if (coin == 2'b10) begin          // 15 + 10 = 25
                    dispense = 1'b1;
                    chg5 = 1'b1;
                    state_next = S_0;
                end
            end
            default: begin
                state_next = S_0;
            end
        endcase
    end

endmodule

