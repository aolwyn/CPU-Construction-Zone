`timescale 1ns/10ps

module mux_2_1(
	input wire[31:0] in1,
	input wire[31:0] in2, 
	input wire read_sig,
	output reg [31:0] out
);

	always@(*) begin
		assign out = read_sig ? in1: in2;
	end
endmodule