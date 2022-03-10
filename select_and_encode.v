module select_and_encode(
 input [31:0] IRin,		//instruction
 input Gra, Grb, Grc, Rin, Rout, Baout, 
 output [4:0] opcode,
 output [15:0] regin, regout,
 output reg[31:0] C_sign_extended
 );
 
 wire [3:0] a, b, c, out;
 reg[16:0] decoderOutput;
 
 assign a[3] = IRin[26] & Gra;
 assign a[2] = IRin[25] & Gra;
 assign a[1] = IRin[24] & Gra;
 assign a[0] = IRin[23] & Gra;

 assign b[3] = IRin[22] & Gra;
 assign b[2] = IRin[21] & Gra;
 assign b[1] = IRin[20] & Gra;
 assign b[0] = IRin[19] & Gra;
 
 assign c[3] = IRin[18] & Gra;
 assign c[2] = IRin[17] & Gra;
 assign c[1] = IRin[16] & Gra;
 assign c[0] = IRin[15] & Gra;
 
 assign out = a | b | c;
 
 always @ (*)
 begin
  case(out)
	4'b0000 :  out = 16'b0000000000000001;
	4'b0001 :  out = 16'b0000000000000010;
	4'b0010 :  out = 16'b0000000000000100; 
	4'b0011 :  out = 16'b0000000000001000;
	4'b0100 :  out = 16'b0000000000010000;
	4'b0101 :  out = 16'b0000000000100000;
	4'b0110 :  out = 16'b0000000001000000;
	4'b0111 :  out = 16'b0000000010000000;
	4'b1000 :  out = 16'b0000000100000000;
	4'b1001 :  out = 16'b0000001000000000;
	4'b1010 :  out = 16'b0000010000000000;
	4'b1011 :  out = 16'b0000100000000000;
	4'b1100 :  out = 16'b0001000000000000;
	4'b1101 :  out = 16'b0010000000000000;
	4'b1110 :  out = 16'b0100000000000000;
	4'b1111 :  out = 16'b1000000000000000;
   default :  out = 16'bx;
 endcase
 
	 assign regout[15] = out[15] & (Rout | BAout);
	 assign regout[14] = out[14] & (Rout | BAout);
	 assign regout[13] = out[13] & (Rout | BAout);
	 assign regout[12] = out[12] & (Rout | BAout);
	 assign regout[11] = out[11] & (Rout | BAout);
	 assign regout[10] = out[10] & (Rout | BAout);
	 assign regout[9] = out[9] & (Rout | BAout);	
	 assign regout[8] = out[8] & (Rout | BAout);
	 assign regout[7] = out[7] & (Rout | BAout);
	 assign regout[6] = out[6] & (Rout | BAout);
	 assign regout[5] = out[5] & (Rout | BAout);
	 assign regout[4] = out[4] & (Rout | BAout);
	 assign regout[3] = out[3] & (Rout | BAout);
	 assign regout[2] = out[2] & (Rout | BAout); 
	 assign regout[1] = out[1] & (Rout | BAout);
	 assign regout[0] = out[0] & (Rout | BAout); 
	 
	 assign regin[15] = out[15] & Rin;
	 assign regin[14] = out[14] & Rin;
	 assign regin[13] = out[13] & Rin;
	 assign regin[12] = out[12] & Rin;
	 assign regin[11] = out[11] & Rin;
	 assign regin[10] = out[10] & Rin;
	 assign regin[9] = out[9] & Rin;
	 assign regin[8] = out[8] & Rin;
	 assign regin[7] = out[7] & Rin;
	 assign regin[6] = out[6] & Rin;
	 assign regin[5] = out[5] & Rin;
	 assign regin[4] = out[4] & Rin;
	 assign regin[3] = out[3] & Rin;
	 assign regin[2] = out[2] & Rin;
	 assign regin[1] = out[1] & Rin;
	 assign regin[0] = out[0] & Rin;
	 
	 assign opcode = IRin[31:27];
	 
 end

 always@(*)
 begin
	if(IRin[18] == 0)
	C_sign_extended = {13'b0000000000000, IRin[18:0]};
	else
	C_sign_extended = {13'b1111111111111, IRin[18:0]};
 end
  
endmodule
	
