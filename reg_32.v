//added below, library inclusion
library ieee;
using ieee.std_logic_1164.all;

module datapath (clk, clr, data, D);
	input clk, clr;
	input data;
	output [31:0] D;

	wire [31:0] BusMuxOut;
	
	//registers 0-15
	Reg32 r0(clr,clk,R0in,BusMuxOut,BusMuxIn_R0);
	Reg32 r1(clr,clk,R1in,BusMuxOut,BusMuxIn_R1);
	Reg32 r2(clr,clk,R2in,BusMuxOut,BusMuxIn_R2);
	Reg32 r3(clr,clk,R3in,BusMuxOut,BusMuxIn_R3);
	Reg32 r4(clr,clk,R4in,BusMuxOut,BusMuxIn_R4);
	Reg32 r5(clr,clk,R5in,BusMuxOut,BusMuxIn_R5);
	Reg32 r6(clr,clk,R6in,BusMuxOut,BusMuxIn_R6);
	Reg32 r7(clr,clk,R7in,BusMuxOut,BusMuxIn_R7);
	Reg32 r8(clr,clk,R8in,BusMuxOut,BusMuxIn_R8);
	Reg32 r9(clr,clk,R9in,BusMuxOut,BusMuxIn_R9);
	Reg32 r10(clr,clk,R10in,BusMuxOut,BusMuxIn_R10);
	Reg32 r11(clr,clk,R11in,BusMuxOut,BusMuxIn_R11);
	Reg32 r12(clr,clk,R12in,BusMuxOut,BusMuxIn_R12);
	Reg32 r13(clr,clk,R13in,BusMuxOut,BusMuxIn_R13);
	Reg32 r14(clr,clk,R14in,BusMuxOut,BusMuxIn_R14);
	Reg32 r15(clr,clk,R15in,BusMuxOut,BusMuxIn_R15);
	
	//other registers
	Reg32 PC(clr,clk,PCin,BusMuxOut,BusMuxIn_PC);
	Reg32 IR(clr,clk,IRin,BusMuxOut,BusMuxIn_IR);
	Reg32 Y(clr,clk,Yin,BusMuxOut,BusMuxIn_Y);
	Reg32 Z_HI(clr,clk,ZHiin,BusMuxOut,BusMuxIn_ZHI);
	Reg32 Z_Lo(clr,clk,ZLOin,BusMuxOut,BusMuxIn_ZLO);
	Reg32 MAR(clr,clk,MARin,BusMuxOut,BusMuxIn_MAR);
	Reg32 HI(clr,clk,HIin,BusMuxOut,BusMuxIn_HI);
	Reg32 LO(clr,clk,LOin,BusMuxOut,BusMuxIn_Lo);
	MDRreg MDR(clr, clk, enable, Mdatain, BusMuxOut, MDRread, MDRout);
	
	//encoder
	wire [4:0] encoderOut;
	wire [31:0] encoderIn;
	Encoder32_5 regEncoder(encoderIn, encoderOut);
	
	//mux
	wire [31:0] mux_out;
	wire [31:0] C_sign_extend,BusMuxIn_InPort,BusMuxIn_MDR,BusMuxIn_PC,BusMuxIn_ZLO, BusMuxIn_ZHI, BusMuxIn_Lo, BusMuxIn_HI, BusMuxIn_R15, BusMuxIn_R14, BusMuxIn_R13, BusMuxIn_R12, BusMuxIn_R11, BusMuxIn_R10, BusMuxIn_R9, BusMuxIn_R8, BusMuxIn_R7, BusMuxIn_R6, BusMuxIn_R5, BusMuxIn_R4, BusMuxIn_R3, BusMuxIn_R2, BusMuxIn_R1, BusMuxIn_R0;
						
	Mux32_1 regMux(mux_out,0,0,0,0,0,0,0,0,0,C_sign_extend,BusMuxIn_InPort,BusMuxIn_MDR,BusMuxIn_PC,BusMuxIn_ZLO, BusMuxIn_ZHI, BusMuxIn_Lo, BusMuxIn_HI,
						BusMuxIn_R15, BusMuxIn_R14, BusMuxIn_R13, BusMuxIn_R12, BusMuxIn_R11, BusMuxIn_R10, BusMuxIn_R9, BusMuxIn_R8, BusMuxIn_R7, BusMuxIn_R6, BusMuxIn_R5, BusMuxIn_R4, BusMuxIn_R3, BusMuxIn_R2, BusMuxIn_R1, BusMuxIn_R0);
						
						
endmodule

module MDRreg (clr, clk, enable, Mdatain, BusMuxOut, read, MDRout);
	input clr, clk, enable, read;
	input [31:0] Mdatain, BusMuxOut;
	output [31:0] MDRout;

	wire [31:0] MDRin;
	Mux2_1 MDMux (Mdatain, BusMuxOut, read, MDRin);
	Reg32 regMDR (clr, clk, enable, MDRin, MDRout);	

endmodule
\
module reg_32(
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
