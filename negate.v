`timescale 1ns / 1ps

module negate(output out[31:0], input in[31:0]);

  assign out = ~in+1; 
    
endmodule 
    