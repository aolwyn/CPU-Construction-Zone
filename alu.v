`timescale 1ns/10ps

module alu(
	input clk, clear, incPC, brn_flag,
	input wire [31:0] RA,
	input wire [31:0] RB,
	input wire [31:0] RY,

	input wire [4:0] opcode,

	output reg [63:0] RC 
);

parameter Addition = 5'b00011, Subtraction = 5'b00100, Multiplication = 5'b01110, Division = 5'b01111, Shift_right = 5'b00101, Shift_left = 5'b00110, Rotate_right = 5'b00111, Rotate_left = 5'b01000, 
				  Logical_AND = 5'b01001, Logical_OR = 5'b01010, Negate = 5'b10000, Not = 5'b10001, addi = 5'b01011, andi = 5'b01100, ori = 5'b01101, ldw = 5'b00000, ldwi = 5'b00001, stw = 5'b00010,
				  branch = 5'b10010, jr = 5'b10011, jal = 5'b10100, mfhi = 5'b10111, mflo = 5'b11000, in = 5'b10101, out = 5'b10110, nop = 5'b11001, halt = 5'b11010;
	
	wire [31:0] IncPC_out, shr_out, shl_out, lor_out, land_out, neg_out, not_out, adder_sum, adder_cout, sub_diff, sub_cout, rol_out, ror_out;
	wire [63:0] mul_out, div_out;

	always @(*)
		begin
			case (opcode)
				
				Addition: begin
					RC[31:0] <= adder_sum[31:0];
					RC[63:32] <= 32'd0;
				end
				
				Subtraction: begin
					RC[31:0] <= sub_diff[31:0];	
					RC[63:32] <= 32'd0;
				end
				
				Logical_OR, ori: begin
					RC[31:0] <= lor_out[31:0];
					RC[63:32] <= 32'd0;
				end
				
				Logical_AND, andi: begin
					RC[31:0] <= land_out[31:0];
					RC[63:32] <= 32'd0;
				end
				
				Negate: begin
					RC[31:0] <= neg_out[31:0];
					RC[63:32] <= 32'd0;
				end
				
				Not: begin
					RC[31:0] <= not_out[31:0];
					RC[63:32] <= 32'd0;
				end
				
				Shift_right: begin
					RC[31:0] <= shr_out[31:0];
					RC[63:32] <= 32'd0;
				end
				
				Shift_left: begin
					RC[31:0] <= shl_out[31:0];
					RC[63:32] <= 32'd0;
				end
				
				Rotate_right: begin
					RC[31:0] <= ror_out[31:0];
					RC[63:32] <= 32'd0;
				end
				
				Rotate_left: begin
					RC[31:0] <= rol_out[31:0];
					RC[63:32] <= 32'd0;
				end
				
				Multiplication: begin
					RC[63:32] <= ~mul_out[63:32];
					RC[31:0] <= mul_out[31:0];
				end
				
				Division: begin
					RC[63:0] <= div_out[63:0];
				end
				
				ldw, ldwi, stw, addi: begin
					RC[31:0] <= adder_sum[31:0];
					RC[63:32] <= 32'd0;
				end
				
				branch: begin
					if(branch_flag==1) begin
						RC[31:0] <= adder_sum[31:0];
						RC[63:32] <= 32'd0;
					end 
					else begin
						RC[31:0] <= RY[31:0];
						RC[63:32] <= 32'd0;
					end
				end
				
				halt: begin
					
				end
				
				nop: begin
					
				end
				
				default: begin
					RC[63:0] <= 64'd0;
				end

			endcase
	end
	
	//ALU Operations
	add adder(.Ra(RY), .Rb(RB),.cin({1'd0}),.sum(adder_sum),.cout(adder_cout));
	divide div(RY,RB, div_out);
	logicalAnd land(RY,RB,land_out);
	logicalNot not_module(RB,not_out);
	logicalOr lor(RY,RB,lor_out);
	multiply mul(RY,RB,mul_out);
	negate neg(RB,neg_out);
	rotate_R ror_op(RY,RB,ror_out);
	rotate_L rol_op(RY,RB,rol_out);
	shift_L shl(RY,RB,shl_out);
	shift_R shr(RY,RB,shr_out);
	subtract subtractor(.Ra(RY), .Rb(RB),.cin({1'd0}),.sum(sub_diff),.cout(sub_cout));
	
	PCincrement pc_inc(RA, IncPC, IncPC_out);

endmodule