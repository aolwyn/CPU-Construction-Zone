`timescale 1ns / 10ps

module PCincrement #(parameter qInitial = 0)(
    input clk, clr, IncPC,
    input [31:0] inputPC,
    output reg[31:0] newPC
    );

initial newPC = qInitial;

always @ (negedge clk)
    begin
        if(clr)
            newPC = 0;
        else if (IncPC)
            newPC = inputPC + 1;

    end

endmodule
