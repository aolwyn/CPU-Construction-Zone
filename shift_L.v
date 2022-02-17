`timescale 1ns / 1ps

module shift_L(input [31:0]in, output [31:0]shifted);
assign shifted = in << 1;

endmodule
