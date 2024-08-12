module BinaryToGray_TB();
	
	reg [4:0]binary;
	wire [4:0]gray;
	BinaryToGray UUT(
	binary,
	gray
);
	initial begin
		binary = 5'b01110;
		#10 binary = 5'b00010;
	end

endmodule