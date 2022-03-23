
module datapath(
	//output [31:0] BusMuxOut,
	output [31:0] OutPort_output,
	input [31:0] inPort_input,
	input clk, rst, stop
);
	
	reg  [15:0] enableReg;					//chooses the register to enable
	reg  [15:0] Rout;						//chooses which register to read from

	wire RAM_wr_enable, MDRin, MDRout, MARin,  IRin, Read, GRA, GRB, GRC;
	wire HIin, LOin, ZHIin, ZLOin, Yin, PCin, enable_outPort, enable_inPort;
	wire InPortout, PCout, Yout, ZLowout, ZHighout, LOout, HIout, Baout, Cout, IncPC;
	wire R_in, R_out, Cin, CONin, run, clr;
	
	wire [15:0] enableReg_IR, enableReg_CPU, Rout_IR;

	initial begin
		Rout = 16'b0;
		enableReg = 16'b0;
	end

		//sets register enable and out signals based on provided info from CPU or IR
		always@(*)begin			
			if (enableReg_IR) enableReg <= enableReg_IR; 
			//else enableReg <= enableReg_CPU;

			if (Rout_IR) Rout <= Rout_IR; 
			else Rout <= 16'b0;	
		end 
	//make wires for reg outputs
	wire [31:0] BusMuxIn_IR, BusMuxIn_Y, C_sign_extend, BusMuxIn_InPort,BusMuxIn_MDR,BusMuxIn_PC,BusMuxIn_ZLO, BusMuxIn_ZHI, BusMuxIn_LO, BusMuxIn_HI;
	wire [31:0] BusMuxIn_R15, BusMuxIn_R14, BusMuxIn_R13, BusMuxIn_R12, BusMuxIn_R11, BusMuxIn_R10, BusMuxIn_R9, BusMuxIn_R8, BusMuxIn_R7, BusMuxIn_R6, BusMuxIn_R5, BusMuxIn_R4, BusMuxIn_R3, BusMuxIn_R2, BusMuxIn_R1, BusMuxIn_R0;
	wire [31:0] bus_signal, C_data_out, BusMuxIn_MAR, outPort_output, con_out, RAMout, BusMuxOut, incOut;
	wire [4:0] operation;
	wire branch_flag;

	//registers 0-15
	wire [31:0] r0_out;
	Reg32 r0(clr,clk,enableReg[0],BusMuxOut,r0_out);
	assign BusMuxIn_R0 = {32{!Baout}} & r0_out;

	Reg32 #(20) r1(clr,clk,enableReg[1],BusMuxOut,BusMuxIn_R1);
	Reg32 #(8) r2(clr,clk,enableReg[2],BusMuxOut,BusMuxIn_R2);
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
	Reg32 PC(clr,clk,PCin,incOut,BusMuxIn_PC);
	PCincrement incPC(clk, clr, IncPC, BusMuxIn_PC, incOut);
	Reg32 Y(clr,clk,Yin,BusMuxOut,BusMuxIn_Y);
	Reg32 Z_HI(clr,clk,ZHIin,C_data_out,BusMuxIn_ZHI);
	Reg32 Z_LO(clr,clk,ZLOin,C_data_out,BusMuxIn_ZLO);
	Reg32 HI(clr,clk,HIin,BusMuxOut,BusMuxIn_HI);
	Reg32 LO(clr,clk,LOin,BusMuxOut,BusMuxIn_LO);
	Reg32 r15(clr,clk,enableReg[15],BusMuxOut,BusMuxIn_R15);
	
	//other registers
	Reg32 IR(clr,clk,IRin,BusMuxOut,BusMuxIn_IR);
	select_and_encode IRlogic(BusMuxIn_IR, GRA, GRB, GRC, R_in, R_out, Baout, operation, enableReg_IR, Rout_IR, C_sign_extend);

	MDRreg MDR(clr, clk, MDRin, RAM_out, BusMuxOut, Read, BusMuxIn_MDR);

	//input and output ports
	Reg32 input_port(clr, clk, enable_inPort, inPort_input, BusMuxIn_InPort);
	Reg32 output_port(clr, clk, enable_outPort, BusMuxOut, outPort_output); 

	CONFF conff_logic (branch_flag, CONin, clr, BusMuxIn_IR, BusMuxOut);

	marUnit MAR(clr, clk, MARin, BusMuxOut, BusMuxIn_MAR);
	
	//memoryRam stuff
	//memoryRam RAM (.a(BusMuxIn_MAR[8:0]), .clk(clk), .d(BusMuxIn_MDR), .we(RAM_wr_enable), .q(RAM_out));
	RAM ram(.address(BusMuxIn_MAR[8:0]), .clock(clk), .data(BusMuxIn_MDR), .rden(Read), .wren(RAM_wr_enable), .q(RAM_out));
	wire [4:0] encoderOut;
	//********inputs may be in wrong order
	encoder_32_5 regEncoder({{8{1'b0}},Cout,InPortout,MDRout,PCout,ZLowout,ZHighout,LOout,HIout,Rout}, encoderOut);
//	$monitor ("[$monitor] time = %0t Rout=0x%0h  encoderOut=0x%0h", $time, Rout, encoderOut);					
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
			.BusMuxIn_MDR(BusMuxIn_MDR),	
			.BusMuxIn_InPort(BusMuxIn_InPort),
			.C_sign_extended(C_sign_extend),
			.BusMuxOut(BusMuxOut),
			.select(encoderOut)
			);
					
	//instantiate alu
	alu the_alu(
		.RA(BusMuxIn_Y),
		.RB(BusMuxOut),
		.opcode(operation),
		.brn_flag(branch_flag),	
		.RC(C_data_out)                              
	);			

	//instantiate the control unit here
	control_unit CPU(
		.PCout(PCout),
		.ZHighout(ZHighout),
		.ZLowout(ZLowout),
		.MDRout(MDRout),
		.MAR_enable(MARin),
		.PC_enable(PCin),
		.MDR_enable(MDRin),
		.IR_enable(IRin),
		.Y_enable(Yin),
		.IncPC(IncPC),
		.MDR_read(Read),
		.HIin(HIin),
		.LOin(LOin),
		.HIout(HIout),
		.LOout(LOout),
		.ZHighIn(ZHIin),
		.ZLowIn(ZLOin),
		.Cout(Cout),
		.RAM_write(RAM_wr_enable),
		.Gra(GRA),
		.Grb(GRB),
		.Grc(GRC),
		.R_enable(R_in),
		.Rout(R_out),
		.BAout(Baout),
		.CON_enable(CONin),
		.enableInputPort(enable_inPort),
		.OutPort_enable(enable_outPort),
		.InPortout(InPortout),
		.Run(run),
		.Reg_enableIn(enableReg_CPU),
		.IR(BusMuxIn_IR),
		.Clock(clk),
		.Reset(rst),
		.Stop(stop)

	);

endmodule


/*  //Final inputs for datapath 
	input clk, clr, stop,
	//input wire[31:0] InPort_input,	//for later
	//output wire[31:0] OutPort_output,		//for later
	output [31:0] BusMuxOut,
	output [4:0] operation
*/
	/*	//commented out for early testing
	wire PCout, ZHighout, ZLowout, MDRout, MARin, PCin, MDRin, IRin, Yin, IncPC, Read, 
			HIin, LOin, HIout, LOout, ZHIin, ZLOin, Cout, RAM_write_en, GRA, GRB, GRC, 
			R_in, R_out, Baout, enableCon, enableInputPort, enableOutputPort, InPortout, Run;
	*/

