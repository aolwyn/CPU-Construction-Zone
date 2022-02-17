`timescale 1ns / 1ps

module shift_R(input [31:0]in, output [31:0]shifted);
assign shifted = in >> 32'b1;

endmodule

