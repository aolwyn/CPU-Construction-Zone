
module MDRreg (clr, clk, enable, Mdatain, BusMuxOut, read, MDRout);
	input clr, clk, enable, read;
	input [31:0] Mdatain, BusMuxOut;
	output [31:0] MDRout;

	wire [31:0] MDRin;
	mux_2_1 MDMux (Mdatain, BusMuxOut, read, MDRin);
	Reg32 regMDR (clr, clk, enable, MDRin, MDRout);	

endmodule

module Reg32 #(parameter VAL = 0)(
	input clr, clk, enable, 
	input [31:0] D, 
	output reg [31:0] Q
);

	initial Q = VAL;

	always@(posedge clk)
	begin
		if (clr)			//if clr is 1, set to 0
			Q = 0;
		else if(enable) 	//if enable is 1 and clr is 0, Q=D
			Q = D;
	end
endmodule
