module Rotate_L(output[63:0] outC, input[31:0] inA, input [31:0] inB);
initial begin
	reg [31:0] temp = inB;
	reg msb = 1'b0;

  end

always @ (*) begin
	msb = inB[31];
	temp = temp <<1;
	logialOr(temp, temp, inB);

	end
end module
