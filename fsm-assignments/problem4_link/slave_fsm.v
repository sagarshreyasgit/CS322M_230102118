`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 18.08.2025 19:15:57
// Design Name: 
// Module Name: slave_fsm
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

// slave_fsm.v
module slave_fsm(
    input wire clk,
    input wire rst,
    input wire req,
    input wire [7:0] data_in,
    output reg ack,
    output reg [7:0] last_byte 
);
    localparam S_IDLE = 2'b00, S_ACK_1 = 2'b01, S_ACK_2 = 2'b10, S_WAIT_REQ_LOW = 2'b11;

    reg [1:0] state_reg, state_next;

    always @(posedge clk) begin
        if (rst) begin
            state_reg <= S_IDLE;
            last_byte <= 8'b0;
        end else begin
            state_reg <= state_next;
            if (state_reg == S_IDLE && req) begin
                last_byte <= data_in; // Latch data
            end
        end
    end

    always @(*) begin
        state_next = state_reg;
        ack = 1'b0;
        case (state_reg)
            S_IDLE: if (req) state_next = S_ACK_1;
            S_ACK_1: begin
                ack = 1'b1;
                state_next = S_ACK_2;
            end
            S_ACK_2: begin
                ack = 1'b1;
                state_next = S_WAIT_REQ_LOW;
            end
            S_WAIT_REQ_LOW: begin
                if (!req) state_next = S_IDLE;
            end
        endcase
    end
endmodule
