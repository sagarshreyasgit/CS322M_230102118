`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 17.08.2025 14:46:46
// Design Name: 
// Module Name: seq_detect_mealy
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


// seq_detect_mealy.v
module seq_detect_mealy(
  input wire clk,
  input wire rst,      // sync active-high
  input wire din,      // serial input bit per clock
  output wire y        // 1-cycle pulse when pattern ...1101 seen
);

  localparam S_IDLE = 2'b00;
  localparam S_1    = 2'b01;
  localparam S_11   = 2'b10;
  localparam S_110  = 2'b11;

  reg [1:0] state_reg, state_next;
  
  reg y_out;
  assign y = y_out;

  always @(posedge clk) begin
    if (rst) begin
      state_reg <= S_IDLE;
    end else begin
      state_reg <= state_next;
    end
  end

  always @(*) begin
    state_next = S_IDLE;
    y_out = 1'b0;

    case (state_reg)
      S_IDLE: begin
        if (din) state_next = S_1;
        else state_next = S_IDLE;
      end
      S_1: begin
        if (din) state_next = S_11;
        else state_next = S_IDLE;
      end
      S_11: begin
        if (din) state_next = S_11;
        else state_next = S_110;
      end
      S_110: begin
        if (din) begin
          state_next = S_1; 
          y_out = 1'b1; 
        end else begin
          state_next = S_IDLE;
        end
      end
      default: begin
        state_next = S_IDLE;
        y_out = 1'b0;
      end
    endcase
  end

endmodule
