
module multiply(input signed [31:0] x, y, output[63:0] out);

    reg [2:0] combBits [15:0]; 				
    reg signed [32:0] pProd [15:0];  		
    reg signed [63:0] shiftedPProd [15:0];
	 reg signed [63:0] sumPProd;
	 
	 wire signed[32:0] negX;
	 
	 integer i, j;

	 assign negX = -x;
	 always @ (x or y or negX)
    begin
        combBits[0] = {y[1], y[0], 1'b0};
            
        for(i=1;i<16;i=i+1) begin
             combBits[i] = {y[2*i+1],y[2*i],y[2*i-1]};
        end

        for(i=0;i<16;i=i+1)begin //case check for which bit and whatnot
            case(combBits[i])
                3'b001 , 3'b010 : pProd[i] = {x[31],x};
                
                3'b011 : pProd[i] = {x,1'b0};
                
                3'b100 : pProd[i] = {negX[31:0],1'b0};
                
                3'b101 , 3'b110 : pProd[i] = negX;
                
                default : pProd[i] = 0;
                
            endcase
            
            
            shiftedPProd[i] = pProd[i] << (2*i);  //sign extension 
        end

        sumPProd = shiftedPProd[0];
        
        for(i=1;i<16;i=i+1) begin //add product to tot.
            sumPProd = sumPProd + shiftedPProd[i];
        end
    end
   
    assign out = sumPProd; //after all shifts adne verythig is done, send it out
endmodule
	 

/*
module multiplier(
input [31:0] m, q,
output reg [63:0] product //product = a ?

//let m = multiplier, q = multiplicand
);
	reg [32:0] extended = (m,0);
	reg [63:0] currVal;
	reg [63:0] cumSum;
	reg [2:0] temp;

	integer i,k;
	integer c = 0;

	//This multiplication algo uses Booth's
	//NOTE: <-- don't forget to swap the bits, i+2
	//inspiration taken from Geeks4Geek's C++ explanation of the code 


	//111 :16 0's [0]
	//110 :concatenate ~m+1 for top + bottom 8 bits [-1]
	//101 :same as above [-1]
	//100 : [-2]
	//011 : [+2]
	//010 : [+1]
	//001 : [+1]
	//000 : 16 0's [0]
	//outside range: 16 x's [0? unknown logic type, not valid input ???]


	initial begin
	for(i = 0; i < 30; i = i + 2)
	begin 
		assign currVal = 0;
		assign temp = (extended_q[3], extended_q[2], extended_q[1]);

		case(group) // need to sort out which value needs to be sign extended
		3'b111: assign currVal = 16'b0000000000000000;
		3'b110: assign currVal = m[31] ? {8'h11111111, ~m + 1} : {8'h00000000, ~m+1};
		3'b101: assign currVal = m[31] ? {8'h11111111, ~m + 1} : {8'h00000000, ~m+1};
		3'b100:	assign currVal = m[31] ? {7'hfffffff, 3'b111, ~m + 1, 1'b0} : {7'h0000000, 3'b000, ~m + 1, 1'b0}  
		3'b011:	assign currVal = m[31] ? {7'hfffffff, 3'b111, m, 1'b0} : {7'h0000000, 3'b000, m, 1'b0}			
		3'b010:	assign currVal = m[31] ? {8'h11111111, m} : {8'h00000000, m};		
		3'b001:	assign currVal = m[31] ? {8'h11111111, m} : {8'h00000000, m};		
		3'b000: assign currVal = 16'b0000000000000000;		
		
		default: asign currVal = 16'hxxxxxxxxxxxxxxxx; //need to double check the base case, x = anything?
							       //could we just use default case for 0 ????
		endcase

		//extensions done. now shifting if needed.
		for(k = 0; k < c; c=c+1) //c++ operation doesn't exist in this language ._.
		begin 
			currVal = curVall << 2;
		end
		assign cumSum = cumSum + currVal;
		//c++
		c= c+1;
		end
		assign product = cumSum;
		end
	end module 


	*/
		
		
		
	
