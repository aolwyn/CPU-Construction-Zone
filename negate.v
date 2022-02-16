`timescale 1ns / 1ps

module negate(output [31:0]out, input [31:0]in);

  assign out = ~in+1; 
    
endmodule 
    
