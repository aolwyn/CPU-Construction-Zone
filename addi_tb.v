module addi_tb;
reg Clock, Clear;
    reg IncPC, CON_enable;
    reg RAM_write, MDR_enable, MDRout, MAR_enable, IR_enable, MDR_read;
    reg Gra, Grb, Grc;
    reg HI_enable, LO_enable, ZHighIn, ZLowIn, Y_enable, PC_enable, OutPort_enable;
    reg InPortout, PCout, Yout, ZLowout, ZHighout, LOout, HIout, BAout, Cout;
    wire [31:0] OutPort_output;
    reg [31:0] InPort_input, Mdatain;
    reg R_in, R_out, Cin;

parameter    Default = 4'b0000, Reg_load1a= 4'b0001, Reg_load1b= 4'b0010,
                    Reg_load2a = 4'b0011, Reg_load2b = 4'b0100, Reg_load3a = 4'b0101,
                    Reg_load3b = 4'b0110, T0= 4'b0111, T1= 4'b1000,T2= 4'b1001, T3= 4'b1010, T4= 4'b1011, T5= 4'b1100, T6 = 4'b1101, T7 = 4'b1111;
reg    [3:0] Present_state = Default;

datapath DUT(    
    OutPort_output, Clock, Clear, IncPC, CONin, 
    RAM_write, MDR_enable, MDRout, MAR_enable,  IR_enable, MDR_read,
    Gra, Grb, Grc, HI_enable, LO_enable, ZHighIn, ZLowIn, Y_enable, PC_enable, OutPort_enable,
    InPortout, PCout, Yout, ZLowout, ZHighout, LOout, HIout, BAout, Cout, InPort_input, Mdatain,
    R_in, R_out, Cin             
);

initial 
    begin
        Clear = 0;
        Clock = 0;
        forever #10 Clock = ~ Clock;
        #500 $finish;
end

always @(posedge Clock)//finite state machine; if clock rising-edge
begin
    case (Present_state)
        Default            :    #40 Present_state = T0;
        T0                    :    #40 Present_state = T1;
        T1                    :    #40 Present_state = T2;
        T2                    :    #40 Present_state = T3;
        T3                    :    #40 Present_state = T4;
        T4                    :    #40 Present_state = T5;
        T5                    :    #40 Present_state = T6;
        T6                    :    #40 Present_state = T7;
        endcase
    end

always @(Present_state)// do the required job in each state
begin
    case (Present_state)              //assert the required signals in each clock cycle
        Default: begin    //initialize all signals
                    PCout <= 0; ZLowout <= 0; MDRout <= 0; 
                    MAR_enable <= 0; ZHighIn <= 0; ZLowIn <= 0; CON_enable<=0; 
                    OutPort_enable<=0; InPort_input<=32'd0;
                    PC_enable <=0; MDR_enable <= 0; IR_enable <= 0; 
                    Y_enable <= 0; IncPC <= 0; RAM_write<=0;
                    Gra<=0; Grb<=0; Grc<=0;
						 BAout<=0; Cout<=0; InPortout<=0; ZHighout<=0; LOout<=0; HIout<=0; 
                    HI_enable<=0; LO_enable<=0; R_out <=0; R_in <=0;MDR_read<=0;
						  
						  IncPC <= 1; PC_enable <= 1;
        end
        
      T0: begin//see if you need to de-assert these signals	
				IncPC <= 0; PC_enable <= 0; Clear <= 0; 
				PCout<= 1; MAR_enable <= 1; ZLowIn <= 1;	//increaase PC and send address to MAR and save in Z
		end
		T1: begin	//loadss RAM output into MDR 									
				PCout<= 0; MAR_enable <= 0; ZLowIn <= 0;
				//Mdatain	<= 32'h59080002; 				//addi r2, r1, 2
				MDR_read <= 1; MDR_enable <= 1; 		//Get instruction from mem
				ZLowout<= 1; 
		end
		T2: begin
				ZLowout<= 0;  MDR_enable <= 0; MDR_read <= 0;
				MDRout<= 1; IR_enable <= 1; ZLowIn <= 1;			 //save inst to IR
				PC_enable <= 1; IncPC <= 1;							//increase PC
		end
      T3: begin
		  MDRout<= 0; IR_enable <= 0;
        Grb <= 1; R_out <= 1; Y_enable <= 1;
       end
            
      T4: begin 
		  Grb <= 0; R_out <= 0; Y_enable <= 0;
        Cout <= 1; ZLowIn = 1;
      end
        
      T5: begin
			 Cout <= 0; ZLowIn = 0;
        ZLowout = 1; Gra <= 1; R_in <= 1;
        
        end
        endcase
        end
        endmodule
		  
