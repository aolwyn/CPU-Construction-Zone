`timescale 1ns / 1ps

module division(clk, dividend, divisor, Q, R, ready);

input clk;
input [15:0] dividend, divisor;
output[15:0] Q, R;
output ready;

reg[31:0] copyDivi, copyDivis, difference;


reg[31:0] bit;
reg [15:0] Q;

assign ready = !bit;
assign remainder = copyDivi[15:0];
initial bit = 0;

always @ (posedge clk)

if (ready)
begin 
	bit = 16;
	Q=0;
	copyDivi = {16'd0,dividend}; //copy and shift for next rotation
	
	copyDivis = {1'b0, 15'd0};
end
	else
begin
difference = copyDivi - copyDivis;

Q = Q<<1;

	if(!difference[31])
begin
	copyDivi = difference;
	Q[0] = 1'd1;
end

	copyDivis = copyDivi >>1;
	bit = bit-1;
end
endmodule
 



/*
module divide_32 (
	input signed [31:0] dividend, 
	input signed [31:0] divisor,
	output reg [63:0] out
);

	reg [63:32] high, low;
	always@(*)
	begin
		high = dividend % divisor;
		low = (dividend - high)/divisor;
		begin
			out = {high, low};
		end
	end
endmodule
*/
