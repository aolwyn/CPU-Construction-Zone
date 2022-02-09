
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