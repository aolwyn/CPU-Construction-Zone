`timescale 1ns / 1ps

module PCincrement #(parameter qInitial = 0)(
    input clk, clr, en, IncPC,
    input [31:0] inputPC,
    output reg[31:0] newPC
    );

initial newPC = qInitial;

always @ (posedge clk)
    begin
        if(clr)
            newPC = 1;
        else if (en)
            newPC = inputPC + 1;

    end

endmodule
