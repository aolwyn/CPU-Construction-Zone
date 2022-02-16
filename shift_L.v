`timescale 1ns / 1ps

module shift_left(output [31:0]shifted,input [31:0]in);
assign shifted = in << 1;

endmodule
