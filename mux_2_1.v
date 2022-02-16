`timescale 1ns/10ps

module mux_2_1 (
input [31:0] input1, 
input [31:0] input2, 
input signal, 
output reg [31:0] out);
 
always@(signal)
begin
		if (signal==0)
			out <= input2;
		else
			out <= input1;
end
endmodule