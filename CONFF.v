`timescale 1ns/10ps

module CONFF(
    output reg q,       //to control unit
    input CONin, clr,  //CONin is control signal
    input [1:0] IRbits, 
    input [31:0] busMuxOut  
    );
  
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

  assign norout     = (busMuxOut == 32'd0) ? 1'b1 : 1'b0;
  assign or0        = decoderOut[0] & norout;                    
  assign ornonzero  = (!(norout)) & decoderOut[1];
  
  assign orgte0     = decoderOut[2] & (!(busMuxOut[31]));
  assign orlt0      = decoderOut[3] & busMuxOut[31];
  assign dconff     = or0 | ornonzero | orgte0 | orlt0;
                    
                   
                    
  always @ (*)
    begin
      if(clr == 0)
        q <= 0;
      else if (CONin)
        q <= dconff;
    end
endmodule
                        
