`timescale 1ns/10ps

module encoder_32_5(
	input wire [31:0] encIn,
	output reg [4:0] encOut
 );

	always@(encIn) begin
		case (encIn)
			32'h00000001 : encOut <= 5'd0; 
			32'h00000002 : encOut <= 5'd1;
			32'h00000004 : encOut <= 5'd2;
			32'h00000008 : encOut <= 5'd3;
			32'h00000010 : encOut <= 5'd4;
			32'h00000020 : encOut <= 5'd5;
			32'h00000040 : encOut <= 5'd6;
			32'h00000080 : encOut <= 5'd7;
			32'h00000100 : encOut <= 5'd8;
			32'h00000200 : encOut <= 5'd9;
			32'h00000400 : encOut <= 5'd10;
			32'h00000800 : encOut <= 5'd11;
			32'h00001000 : encOut <= 5'd12;
			32'h00002000 : encOut <= 5'd13;
			32'h00004000 : encOut <= 5'd14;
			32'h00008000 : encOut <= 5'd15;
			32'h00010000 : encOut <= 5'd16;
			32'h00020000 : encOut <= 5'd17;
			32'h00040000 : encOut <= 5'd18;
			32'h00080000 : encOut <= 5'd19;
			32'h00100000 : encOut <= 5'd20;
			32'h00200000 : encOut <= 5'd21;
			32'h00400000 : encOut <= 5'd22;
			32'h00800000 : encOut <= 5'd23;
				default	 : encOut <= 5'd31;	//11111 means no acceptable input
		endcase
	end
endmodule