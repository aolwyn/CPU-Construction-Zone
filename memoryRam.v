module memoryRam(q, a, d, we, clk);
   output[31:0] q;	//output
   input [31:0] d;	//data
   input [7:0] a; //address
   input we, clk;
   reg [31:0] ram [511:0];
	
	reg [31:0] addr_reg;
	initial
	begin //INIT 
		$readmem("ram.mem", ram);
	end
	
    always @(posedge clk) begin
        if (we)
            ram[a] <= d;
        addr_reg <= a;
   end
	
	assign q = ram[addr_reg];
	
endmodule