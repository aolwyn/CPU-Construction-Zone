`timescale 1ns / 1ps

module PCincrement #(parameter qInitial = 0)(
	input clk, IncPC,
	input [31:0] inputPC,
	output reg[31:0] newPC
	);
	
initial newPC = qInitial;
	
always @ (posedge clk)
	begin
		if(IncPC == 1)
			newPC <= newPC + 1;
	end
				
endmodule