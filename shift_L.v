`timescale 1ns / 1ps

module shift_left(output shifted[31:0],input in[31:0]);
assign shifted = in << 1;

endmodule
