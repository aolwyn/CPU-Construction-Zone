`timescale 1ns / 1ps

module logicalOr(output [31:0]out, input [31:0] in2, in1);

assign out = in1 | in2;

endmodule
