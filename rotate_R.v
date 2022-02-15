`timescale 1ns / 1ps

module rotateRight(output out[31:0], input in[31:0])

assign out = {in[31],in[30:0]}

endmodule    