`timescale 1ns / 1ps

module rotateRight(output [31:0]out, input [31:0]in);

  assign out = {in[31],in[30:0]};

endmodule    
