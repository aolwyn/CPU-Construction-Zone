module CONFF(output reg q, input clk, CONin, reset, input [1:0] IRbits, input [31:0] busMuxOut);
  
  wire IR0 = IRbits[0];
  wire IR1 = IRbits[1];
  
  reg[4:0] decoderOut;
  
  wire dconff, and0, and1, and2, and3, norout;
  wire orlt0, orgte0, ornonzero, or0;
  
  always @ (*)
    begin
      case {(IR1,IR0)}
        2'b00: decoderOut = 4'b0001;
        2'b01: decoderOut = 4'b0010;
        2'b10: decoderOut = 4'b0100;
        2'b11: decoderOut = 4'b1000;
        default: decoderOut = 4'bx;
      endcase
    end
  assign norout = !{busMuxOut[0] | 
                    
   --finish assigning the other signals <--- note to self
                    
  always @ (*)
    begin
      if( reset == 0)
        q<= 0;
      else if (CONin ==1)
        q<= dconFF;
    end
endmodule
                        