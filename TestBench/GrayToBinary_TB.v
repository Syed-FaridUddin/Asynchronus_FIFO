module GrayToBinary_TB ();
	
	reg [4:0]gray;
	wire [4:0]binary;
	GrayToBinary UUT(
		gray,
		binary
	);
	
	initial begin
		gray = 5'b01110;
		#10 gray = 5'b00011;
	end

endmodule