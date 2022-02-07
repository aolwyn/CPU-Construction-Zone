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
	Encoder32_5 regEncoder(encoderOut, encoderIn);
	
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

module Encoder32_5(output reg[4:0] SOut, input[31:0] Data);
aways @(Data)
		case (Data)
			32'h00000001 : SOut = 0; 
			32'h00000002 : SOut = 1;
			32'h00000004 : SOut = 2;
			32'h00000008 : SOut = 3;
			32'h00000010 : SOut = 4;
			32'h00000020 : SOut = 5;
			32'h00000040 : SOut = 6;
			32'h00000080 : SOut = 7;
			32'h00000100 : SOut = 8;
			32'h00000200 : SOut = 9;
			32'h00000400 : SOut = 10;
			32'h00000800 : SOut = 11;
			32'h00001000 : SOut = 12;
			32'h00002000 : SOut = 13;
			32'h00004000 : SOut = 14;
			32'h00008000 : SOut = 15;
			32'h00010000 : SOut = 16;
			32'h00020000 : SOut = 17;
			32'h00040000 : SOut = 18;
			32'h00080000 : SOut = 19;
			32'h00100000 : SOut = 20;
			32'h00200000 : SOut = 21;
			32'h00400000 : SOut = 22;
			32'h00800000 : SOut = 23;
				default	 : SOut = 31;	//11111 means no acceptable input
		endcase
endmodule
		

module Reg32(
	input clr, clk, enable, 
	input [31:0] D, 
	output [31:0] Q
);
endmodule
