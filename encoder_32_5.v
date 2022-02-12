`timescale 1ns/10ps

module encoder_32_5(
	input wire [31:0] encIn,
	output reg [4:0] encOut
 );

	always@(encIn) begin
		case (encIn)
			32'h00000001 : encOut <= 0; 
			32'h00000002 : encOut <= 1;
			32'h00000004 : encOut <= 2;
			32'h00000008 : encOut <= 3;
			32'h00000010 : encOut <= 4;
			32'h00000020 : encOut <= 5;
			32'h00000040 : encOut <= 6;
			32'h00000080 : encOut <= 7;
			32'h00000100 : encOut <= 8;
			32'h00000200 : encOut <= 9;
			32'h00000400 : encOut <= 10;
			32'h00000800 : encOut <= 11;
			32'h00001000 : encOut <= 12;
			32'h00002000 : encOut <= 13;
			32'h00004000 : encOut <= 14;
			32'h00008000 : encOut <= 15;
			32'h00010000 : encOut <= 16;
			32'h00020000 : encOut <= 17;
			32'h00040000 : encOut <= 18;
			32'h00080000 : encOut <= 19;
			32'h00100000 : encOut <= 20;
			32'h00200000 : encOut <= 21;
			32'h00400000 : encOut <= 22;
			32'h00800000 : encOut <= 23;
				default	 : encOut <= 5'b31;	//11111 means no acceptable input
		endcase
	end
endmodule