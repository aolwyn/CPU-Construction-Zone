`timescale 1ns / 10ps

module datapath_tb; 	
	reg	PCout, ZHighout, ZLowout,  HIout, LOout, InPortout, Cout, MDRout, R2out, R4out;// add any other signals to see in your simulation
	reg	MARin, PCin, MDRin, IRin, Yin, Read, IncPC;
	reg	[4:0] opCode; 
	reg	R5in, R2in, R4in, HIin, LOin, ZHighIn, Cin, ZLowIn, Clock, Clear;
	reg	[31:0] Mdatain;
   reg   branch_flag;

parameter	Default = 4'b0000, Reg_load1a= 4'b0001, Reg_load1b= 4'b0010,
					Reg_load2a = 4'b0011, Reg_load2b = 4'b0100, Reg_load3a = 4'b0101,
					Reg_load3b = 4'b0110, T0= 4'b0111, T1= 4'b1000,T2= 4'b1001, T3= 4'b1010, T4= 4'b1011, T5= 4'b1100;
reg	[3:0] Present_state = Default;

datapath DUT(
	.PCout(PCout), .ZHighout(ZHighout), .ZLowout(ZLowout), .HIout(HIout), 
	.LOout(LOout), .InPortout(InPortout), .Cout(Cout), .MDRout(MDRout), 
	.R2out(R2out),.R4out(R4out), .MARin(MARin), .PCin(PCin), .MDRin(MDRin), 
	.IRin(IRin), .Yin(Yin), .IncPC(IncPC),.Read(Read),.operation(opCode), 
	.R5in(R5in), .R2in(R2in), .R4in(R4in), .clk(Clock), .Mdatain(Mdatain), 
	.clr(Clear), .HIin(HIin), .LOin(LOin), .ZHIin(ZHighIn), .ZLOin(ZLowIn), 
	.Cin(Cin), .branch_flag(branch_flag)
	);
// add test logic here

initial 
	begin
		Clear = 0;
		Clock = 0;
		forever #10 Clock = ~ Clock;
end

always @(posedge Clock)//finite state machine; if clock rising-edge
begin
	case (Present_state)
		Default			:	#40 Present_state = Reg_load1a;
		Reg_load1a		:	#40 Present_state = Reg_load1b;
		Reg_load1b		:	#40 Present_state = Reg_load2a;
		Reg_load2a		:	#40 Present_state = Reg_load2b;
		Reg_load2b		:	#40 Present_state = Reg_load3a;
		Reg_load3a		:	#40 Present_state = Reg_load3b;
		Reg_load3b		:	#40 Present_state = T0;
		T0					:	#40 Present_state = T1;
		T1					:	#40 Present_state = T2;
		T2					:	#40 Present_state = T3;
		T3					:	#40 Present_state = T4;
		T4					:	#40 Present_state = T5;
		endcase
	end

always @(Present_state)// do the required job ineach state
begin
	case (Present_state)              //assert the required signals in each clock cycle
		Default: begin
						PCout <= 0;   ZLowout <= 0; ZHighout <= 0;  MDRout<= 0;   //initialize the signals
						R2out <= 0;   R4out <= 0;   MARin <= 0;   ZLowIn <= 0;  
						PCin <=0;   MDRin <= 0;   IRin  <= 0;   Yin <= 0;  
						IncPC <= 0;   Read <= 0;   opCode <= 5'b00000;  branch_flag <=0;
						HIout<=0;  LOout<=0; InPortout<=0; Cout<=0;
						R5in <= 0; R2in <= 0; R4in <= 0; Mdatain <= 32'h00000000;
		end
		Reg_load1a: begin 
				Mdatain<= 32'h00000022;
				Read = 0; MDRin = 0;	//the first zero is there for completeness
				#10 Read <= 1; MDRin <= 1;  
				#15 Read <= 0; MDRin <= 0;
		end
		Reg_load1b: begin
				#10 MDRout<= 1; R2in <= 1;  
				#15 MDRout<= 0; R2in <= 0;     // initialize R2 with the value $22
		end
		Reg_load2a: begin 
				Mdatain <= 32'h00000011;
				#10 Read <= 1; MDRin <= 1;  
				#15 Read <= 0; MDRin <= 0;
		end
		Reg_load2b: begin
				#10 MDRout<= 1; R4in <= 1;  
				#15 MDRout<= 0; R4in <= 0;		// initialize R4 with the value $10 
		end
		Reg_load3a: begin 
				Mdatain <= 32'h00000026;
				#10 Read <= 1; MDRin <= 1;  
				#15 Read <= 0; MDRin <= 0;
		end
		Reg_load3b: begin
				#10 MDRout<= 1; R5in <= 1;  
				#15 MDRout<= 0; R5in <= 0;// initialize R5 with the value $26 
		end
	
		T0: begin//see if you need to de-assert these signals	
				PCout<= 1; MARin <= 1; IncPC <= 1; ZLowIn <= 1;
		end
		T1: begin										//hold value of Mdatain in MDR
				`timescale 1ns / 10ps

module datapath_tb; 	
	reg	PCout, ZHighout, ZLowout,  HIout, LOout, InPortout, Cout, MDRout, R2out, R4out;// add any other signals to see in your simulation
	reg	MARin, PCin, MDRin, IRin, Yin, Read, IncPC;
	reg	[4:0] opCode; 
	reg	R5in, R2in, R4in, HIin, LOin, ZHighIn, Cin, ZLowIn, Clock, Clear;
	reg	[31:0] Mdatain;
   reg   branch_flag;

parameter	Default = 4'b0000, Reg_load1a= 4'b0001, Reg_load1b= 4'b0010,
					Reg_load2a = 4'b0011, Reg_load2b = 4'b0100, Reg_load3a = 4'b0101,
					Reg_load3b = 4'b0110, T0= 4'b0111, T1= 4'b1000,T2= 4'b1001, T3= 4'b1010, T4= 4'b1011, T5= 4'b1100;
reg	[3:0] Present_state = Default;

datapath DUT(
	.PCout(PCout), .ZHighout(ZHighout), .ZLowout(ZLowout), .HIout(HIout), 
	.LOout(LOout), .InPortout(InPortout), .Cout(Cout), .MDRout(MDRout), 
	.R2out(R2out),.R4out(R4out), .MARin(MARin), .PCin(PCin), .MDRin(MDRin), 
	.IRin(IRin), .Yin(Yin), .IncPC(IncPC),.Read(Read),.operation(opCode), 
	.R5in(R5in), .R2in(R2in), .R4in(R4in), .clk(Clock), .Mdatain(Mdatain), 
	.clr(Clear), .HIin(HIin), .LOin(LOin), .ZHIin(ZHighIn), .ZLOin(ZLowIn), 
	.Cin(Cin), .branch_flag(branch_flag)
	);
// add test logic here

initial 
	begin
		Clear = 0;
		Clock = 0;
		forever #10 Clock = ~ Clock;
end

always @(posedge Clock)//finite state machine; if clock rising-edge
begin
	case (Present_state)
		Default			:	#40 Present_state = Reg_load1a;
		Reg_load1a		:	#40 Present_state = Reg_load1b;
		Reg_load1b		:	#40 Present_state = Reg_load2a;
		Reg_load2a		:	#40 Present_state = Reg_load2b;
		Reg_load2b		:	#40 Present_state = Reg_load3a;
		Reg_load3a		:	#40 Present_state = Reg_load3b;
		Reg_load3b		:	#40 Present_state = T0;
		T0					:	#40 Present_state = T1;
		T1					:	#40 Present_state = T2;
		T2					:	#40 Present_state = T3;
		T3					:	#40 Present_state = T4;
		T4					:	#40 Present_state = T5;
		endcase
	end

always @(Present_state)// do the required job ineach state
begin
	case (Present_state)              //assert the required signals in each clock cycle
		Default: begin
						PCout <= 0;   ZLowout <= 0; ZHighout <= 0;  MDRout<= 0;   //initialize the signals
						R2out <= 0;   R4out <= 0;   MARin <= 0;   ZLowIn <= 0;  
						PCin <=0;   MDRin <= 0;   IRin  <= 0;   Yin <= 0;  
						IncPC <= 0;   Read <= 0;   opCode <= 5'b00000;  branch_flag <=0;
						HIout<=0;  LOout<=0; InPortout<=0; Cout<=0;
						R5in <= 0; R2in <= 0; R4in <= 0; Mdatain <= 32'h00000000;
		end
		Reg_load1a: begin 
				Mdatain<= 32'h00000022;
				Read = 0; MDRin = 0;	//the first zero is there for completeness
				#10 Read <= 1; MDRin <= 1;  
				#15 Read <= 0; MDRin <= 0;
		end
		Reg_load1b: begin
				#10 MDRout<= 1; R2in <= 1;  
				#15 MDRout<= 0; R2in <= 0;     // initialize R2 with the value $22
		end
		Reg_load2a: begin 
				Mdatain <= 32'h00000010;
				#10 Read <= 1; MDRin <= 1;  
				#15 Read <= 0; MDRin <= 0;
		end
		Reg_load2b: begin
				#10 MDRout<= 1; R4in <= 1;  
				#15 MDRout<= 0; R4in <= 0;		// initialize R4 with the value $10 
		end
		Reg_load3a: begin 
				Mdatain <= 32'h00000026;
				#10 Read <= 1; MDRin <= 1;  
				#15 Read <= 0; MDRin <= 0;
		end
		Reg_load3b: begin
				#10 MDRout<= 1; R5in <= 1;  
				#15 MDRout<= 0; R5in <= 0;// initialize R5 with the value $26 
		end
	
		T0: begin//see if you need to de-assert these signals	
				PCout<= 1; MARin <= 1; IncPC <= 1; ZLowIn <= 1;
		end
		T1: begin										//hold value of Mdatain in MDR
				Mdatain <= 32'h4A920000; Read <= 1; MDRin <= 1; ZLowout<= 1; PCin <= 1; PCout <=0; 	//divide
				
				
		end
		T2: begin								
				MDRout<= 1; IRin <= 1; ZLowout<= 0;
		end
		T3: begin
				MDRout<=0; R2out<= 1; Yin <= 1;
		end
		T4: begin
				Yin <= 0; R2out <=0; R4out<= 1; opCode <= 5'b00100; ZLowIn <= 1; 
		end
		T5: begin
				R4out <=0; ZLowout<= 1; R5in <= 1; LOin <= 1; 
				//#10 ZHighout <= 1; ZLowout<= 0; HIin <= 1; LOin <= 0;
		end
	endcase
end
endmodule

//Addition = 5'b00011, Subtraction = 5'b00100, Multiplication = 5'b01110, Division = 5'b01111, Shift_right = 5'b00101, Shift_left = 5'b00110, Rotate_right = 5'b00111, Rotate_left = 5'b01000, 
//Logical_AND = 5'b01001, Logical_OR = 5'b01010, Negate = 5'b10000, Not = 5'b10001 <= 32'h4A920000;  
				Read <= 1; MDRin <= 1;
				ZLowout<= 1; PCin <= 1; 
				
		end
		T2: begin								
				MDRout<= 1; IRin <= 1; 
		end
		T3: begin
				R2out<= 1; Yin <= 1;
		end
		T4: begin
				Yin <= 0; R2out <=0; R4out<= 1; opCode <= 5'b01111; ZLowIn <= 1; 
		end
		T5: begin
				R4out <=0; ZLowout<= 1; R5in <= 1; LOin <= 1; 
				//#10 ZHighout <= 1; ZLowout<= 0; HIin <= 1; LOin <= 0;
		end
	endcase
end
endmodule

//Addition = 5'b00011, Subtraction = 5'b00100, Multiplication = 5'b01110, Division = 5'b01111, Shift_right = 5'b00101, Shift_left = 5'b00110, Rotate_right = 5'b00111, Rotate_left = 5'b01000, 
//Logical_AND = 5'b01001, Logical_OR = 5'b01010, Negate = 5'b10000, Not = 5'b10001