`timescale 1ns / 1ps

module logicalOr(output out[31:0], input in2[31:0], in1[31:0]);

assign out = in1 | in2;

endmodule
