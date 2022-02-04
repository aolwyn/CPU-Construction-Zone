//added below, library inclusion
library ieee;
using ieee.std_logic_1164.all;


module Mux2_1(in1, in2, read, ouput);
		 input in1, in2, read
		 output ouput
		 assign ouput = select ? in1: in2;
		 
endmodule :Mux2_1;


module datapath (clk, ctr, data);
	input clk, ctr
	input data
	//output??

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

module Mux32_1(
    output [31:0] mux_out
    input [31:0] data_31, data_30,data_29, data_28, data_27, data_26, data_25, data_24, data_23, data_22, data_21, data_20, data_19, data_18, data_17, data_16, data_15, data_14, data_13, data_12, data_11, data_10, data_9, data_8, data_7, data_6, data_5, data_4, data_3, data_2, data_1, data_0,
    input [4 :0] select,
    input enable
);
    reg [31:0] mux_int;
    assign mux_out = enable ? mux_int: 32'bz;
    always @ (data_31, data_30,data_29, data_28, data_27, data_26, data_25, data_24, data_23, data_22, data_21, data_20, data_19, data_18, data_17, data_16, data_15, data_14, data_13, data_12, data_11, data_10, data_9, data_8, data_7, data_6, data_5, data_4, data_3, data_2, data_1, data_0, select )
        case(select)
         0:     		  mux_int = data_0;
         1:            mux_int = data_1;        
         2:            mux_int = data_2;
         3:            mux_int = data_3;
         4:            mux_int = data_4;
         5:            mux_int = data_5;
         6:            mux_int = data_6;
         7:            mux_int = data_7;
         8:            mux_int = data_8;
         9:            mux_int = data_9;
         10:            mux_int = data_10;
         11:            mux_int = data_11;
         12:            mux_int = data_12;
         13:            mux_int = data_13;
         14:            mux_int = data_14;
         15:            mux_int = data_15;
         16:            mux_int = data_16;
         17:            mux_int = data_17;
         18:            mux_int = data_18;
         19:            mux_int = data_19;
         20:            mux_int = data_20;
         21:            mux_int = data_21;
         22:            mux_int = data_22;
         23:            mux_int = data_23;
         24:            mux_int = data_24;
         25:            mux_int = data_25;
         26:            mux_int = data_26;
         27:            mux_int = data_27;
         28:            mux_int = data_28;
         29:            mux_int = data_29;
         30:            mux_int = data_30;
         31:            mux_int = data_31;
         default:    mux_int = 32'bx;
        endcase
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
