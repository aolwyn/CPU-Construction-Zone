
module datapath(
	input PCout, ZHighout, ZLowout, MDRout, R2out, R4out, MARin, PCin, MDRin, IRin, Yin, IncPC, Read,
    input [4:0] operation, 
	input	R5in, R2in, R4in, clk, Mdatain, clr, R1in, R3in, R6in, R7in, R8in, R9in, R10in, R11in, 
            R12in, R13in, R14in, R15in, HIin, LOin, ZHIin, ZLOin, Cin,
	output [31:0] BusMuxOut

/*  //Final inputs for datapath 
	input clk, clr, stop,
	//input wire[31:0] InPort_input,	//for later
	//output wire[31:0] OutPort_output,		//for later
	output [31:0] BusMuxOut,
	output [4:0] operation
*/
);

	/*	//commented out for early testing
	wire PCout, ZHighout, ZLowout, MDRout, MARin, PCin, MDRin, IRin, Yin, IncPC, Read, 
			HIin, LOin, HIout, LOout, ZHIin, ZLOin, Cout, RAM_write_en, GRA, GRB, GRC, 
			R_in, R_out, Baout, enableCon, enableInputPort, enableOutputPort, InPortout, Run;
	*/
		
	wire [15:0] R_enableIn;					//from the CPU
	wire [15:0] enableR_IR;					//output from select_enable logic
	wire [15:0] RegOut_IR;					//was Rout_IR, output from select_enable logic
	reg  [15:0] enableReg;					//chooses the register to enable
	reg  [15:0] Rout;						//chooses which register to read from
	wire [3:0]  decoder_in;

		//sets register enable and out signals based on provided info from CPU or IR
		always@(*)begin		
			if (enableR_IR)enableReg<=enableR_IR; 
			else enableReg<=R_enableIn;
			if (Rout_IR)Rout<=Rout_IR; 
			else Rout<=16'b0;	
		end 
	
	//make wires for reg outputs
	wire [31:0] BusMuxIn_IR, BusMuxIn_Y, C_sign_extend, BusMuxIn_InPort,BusMuxIn_MDR,BusMuxIn_PC,BusMuxIn_ZLO, BusMuxIn_ZHI, BusMuxIn_LO, BusMuxIn_HI;
	wire [31:0] BusMuxIn_R15, BusMuxIn_R14, BusMuxIn_R13, BusMuxIn_R12, BusMuxIn_R11, BusMuxIn_R10, BusMuxIn_R9, BusMuxIn_R8, BusMuxIn_R7, BusMuxIn_R6, BusMuxIn_R5, BusMuxIn_R4, BusMuxIn_R3, BusMuxIn_R2, BusMuxIn_R1, BusMuxIn_R0;
	wire [31:0] bus_signal, C_data_out;

	//registers 0-15
	Reg32 r0(clr,clk,enableReg[0],BusMuxOut,BusMuxIn_R0);
	Reg32 r1(clr,clk,enableReg[1],BusMuxOut,BusMuxIn_R1);
	Reg32 r2(clr,clk,enableReg[2],BusMuxOut,BusMuxIn_R2);
	Reg32 r3(clr,clk,enableReg[3],BusMuxOut,BusMuxIn_R3);
	Reg32 r4(clr,clk,enableReg[4],BusMuxOut,BusMuxIn_R4);
	Reg32 r5(clr,clk,enableReg[5],BusMuxOut,BusMuxIn_R5);
	Reg32 r6(clr,clk,enableReg[6],BusMuxOut,BusMuxIn_R6);
	Reg32 r7(clr,clk,enableReg[7],BusMuxOut,BusMuxIn_R7);
	Reg32 r8(clr,clk,enableReg[8],BusMuxOut,BusMuxIn_R8);
	Reg32 r9(clr,clk,enableReg[9],BusMuxOut,BusMuxIn_R9);
	Reg32 r10(clr,clk,enableReg[10],BusMuxOut,BusMuxIn_R10);
	Reg32 r11(clr,clk,enableReg[11],BusMuxOut,BusMuxIn_R11);
	Reg32 r12(clr,clk,enableReg[12],BusMuxOut,BusMuxIn_R12);
	Reg32 r13(clr,clk,enableReg[13],BusMuxOut,BusMuxIn_R13);
	Reg32 r14(clr,clk,enableReg[14],BusMuxOut,BusMuxIn_R14);
	Reg32 r15(clr,clk,enableReg[15],BusMuxOut,BusMuxIn_R15);
	
	//other registers
	Reg32 PC(clr,clk,PCin,BusMuxOut,BusMuxIn_PC);
	Reg32 Y(clr,clk,Yin,BusMuxOut,BusMuxIn_Y);
	Reg32 Z_HI(clr,clk,ZHIin,C_data_out,BusMuxIn_ZHI);
	Reg32 Z_LO(clr,clk,ZLOin,C_data_out,BusMuxIn_ZLO);
	Reg32 HI(clr,clk,HIin,BusMuxOut,BusMuxIn_HI);
	Reg32 LO(clr,clk,LOin,BusMuxOut,BusMuxIn_LO);

	Reg32 IR(clr,clk,IRin,BusMuxOut,BusMuxIn_IR);
	//select_encode_logic IRlogic(...);

	MDRreg MDR(clr, clk, MDRin, Mdatain, BusMuxOut, MDRread, MDRout);

	//input and output port will be added here
	//conff logic may be added here 

	//MAR unit will be added here
	
	//memoryRam stuff
	
	wire [4:0] encoderOut;
	//********inputs may be in wrong order
	encoder_32_5 regEncoder({{8{1'b0}},Cout,InPortout,MDRout,PCout,ZLowout,ZHighout,LOout,HIout,Rout}, encoderOut);

						
	mux_32_1 busMux(
			.BusMuxIn_R0(BusMuxIn_R0),
			.BusMuxIn_R1(BusMuxIn_R1), 
			.BusMuxIn_R2(BusMuxIn_R2),
			.BusMuxIn_R3(BusMuxIn_R3),
			.BusMuxIn_R4(BusMuxIn_R4),
			.BusMuxIn_R5(BusMuxIn_R5),
			.BusMuxIn_R6(BusMuxIn_R6),
			.BusMuxIn_R7(BusMuxIn_R7),
			.BusMuxIn_R8(BusMuxIn_R8),
			.BusMuxIn_R9(BusMuxIn_R9),
			.BusMuxIn_R10(BusMuxIn_R10),
			.BusMuxIn_R11(BusMuxIn_R11),
			.BusMuxIn_R12(BusMuxIn_R12),
			.BusMuxIn_R13(BusMuxIn_R13),
			.BusMuxIn_R14(BusMuxIn_R14),
			.BusMuxIn_R15(BusMuxIn_R15),
			.BusMuxIn_HI(BusMuxIn_HI),
			.BusMuxIn_LO(BusMuxIn_LO),
			.BusMuxIn_Z_high(BusMuxIn_ZHI),
			.BusMuxIn_Z_low(BusMuxIn_ZLO),
			.BusMuxIn_PC(BusMuxIn_PC),
			.BusMuxIn_MDR(MDRout),	
			.BusMuxIn_InPort(BusMuxIn_InPort),
			.C_sign_extended(C_sign_extend),
			.BusMuxOut(BusMuxOut),
			.select_signal(bus_signal)
			);
					
	//instantiate alu
	alu the_alu(
		.clk(clk),
		.clear(clr), 
		.A_reg(BusMuxOut),
		.B_reg(BusMuxOut),
		.Y_reg(BusMuxIn_Y),
		.opcode(operation),
		.brn_flag(con_out),			//??????????
		.IncPC(IncPC),
		.C_reg(C_data_out)                              
	);			


	//instantiate the control unit here

endmodule