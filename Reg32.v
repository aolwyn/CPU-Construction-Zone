module MDRreg (clr, clk, enable, Mdatain, BusMuxOut, read, MDRout);
	input clr, clk, enable, read;
	input [31:0] Mdatain, BusMuxOut;
	output [31:0] MDRout;

	wire [31:0] MDRin;
	Mux2_1 MDMux (Mdatain, BusMuxOut, read, MDRin);
	Reg32 regMDR (clr, clk, enable, MDRin, MDRout);	

endmodule

module Reg32(
	input wire clr, clk, enable, 
	input wire [31:0] D, 
	output reg [31:0] Q
);
	parameter Q_INIT= 0;
	initial Q = Q_INIT;				//initalize register value to 0

	always@(posedge clk)
	begin
		if (clr) begin				//if clr is 1, set to 0
			Q[31:0] = 32'b0;
		end
		else if(enable) begin		//if enable is 1 and clr is 0, Q=D
			Q[31:0} = D[31:0]
		end
	end
endmodule
