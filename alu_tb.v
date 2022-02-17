`timescale 1ns/10ps
module alu_tb;
    reg [31:0] alu_in_a, alu_in_b, clk, clear, incPC, brn_flag;
     reg [4:0] op_code;
    wire [63:0] alu_out;
	 
initial
    begin
		  clk <= 0;
		  clear<= 0;
		  incPC<= 0; 
		  brn_flag <= 0;
        alu_in_a <= 32'd10;
        alu_in_b <= 32'd10;
        #300 op_code <= 5'b00101;

    //try all the other opcodes here (mul and div not currently working)
    end
    alu alu_unit(clk, clear, incPC, brn_flag, alu_in_a, alu_in_b, op_code, alu_out);
endmodule