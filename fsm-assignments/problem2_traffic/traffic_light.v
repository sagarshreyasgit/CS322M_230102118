`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 17.08.2025 15:10:06
// Design Name: 
// Module Name: traffic_light
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


module traffic_light(
    input wire clk,
    input wire rst,      // sync active-high
    input wire tick,     // 1-cycle per-second pulse
    output reg ns_g, ns_y, ns_r,
    output reg ew_g, ew_y, ew_r
);

    localparam S_NS_GREEN  = 2'b00;
    localparam S_NS_YELLOW = 2'b01;
    localparam S_EW_GREEN  = 2'b10;
    localparam S_EW_YELLOW = 2'b11;

    reg [1:0] state_reg, state_next;
    reg [2:0] tick_count_reg, tick_count_next; // Counter up to 5

    always @(posedge clk) begin
        if (rst) begin
            state_reg      <= S_NS_GREEN;
            tick_count_reg <= 3'b0;
        end else begin
            state_reg      <= state_next;
            tick_count_reg <= tick_count_next;
        end
    end

    always @(*) begin
        // Default assignments to prevent latches
        state_next      = state_reg;
        tick_count_next = tick_count_reg;

        if (tick) begin // Only update logic when a tick occurs
            case (state_reg)
                S_NS_GREEN: begin
                    if (tick_count_reg == 4) begin // After 5 ticks (0 to 4)
                        state_next      = S_NS_YELLOW;
                        tick_count_next = 3'b0;
                    end else begin
                        tick_count_next = tick_count_reg + 1;
                    end
                end
                S_NS_YELLOW: begin
                    if (tick_count_reg == 1) begin // CORRECTED: After 2 ticks (0 to 1)
                        state_next      = S_EW_GREEN;
                        tick_count_next = 3'b0;
                    end else begin
                        tick_count_next = tick_count_reg + 1;
                    end
                end
                S_EW_GREEN: begin
                    if (tick_count_reg == 4) begin // After 5 ticks (0 to 4)
                        state_next      = S_EW_YELLOW;
                        tick_count_next = 3'b0;
                    end else begin
                        tick_count_next = tick_count_reg + 1;
                    end
                end
                S_EW_YELLOW: begin
                    if (tick_count_reg == 1) begin // CORRECTED: After 2 ticks (0 to 1)
                        state_next      = S_NS_GREEN;
                        tick_count_next = 3'b0;
                    end else begin
                        tick_count_next = tick_count_reg + 1;
                    end
                end
                default: begin
                    state_next      = S_NS_GREEN;
                    tick_count_next = 3'b0;
                end
            endcase
        end
    end



    always @(*) begin

        ns_g = 0; ns_y = 0; ns_r = 0;
        ew_g = 0; ew_y = 0; ew_r = 0;

        case (state_reg)
            S_NS_GREEN: begin
                ns_g = 1;
                ew_r = 1;
            end
            S_NS_YELLOW: begin
                ns_y = 1;
                ew_r = 1;
            end
            S_EW_GREEN: begin
                ns_r = 1;
                ew_g = 1;
            end
            S_EW_YELLOW: begin
                ns_r = 1;
                ew_y = 1;
            end
        endcase
    end

endmodule
