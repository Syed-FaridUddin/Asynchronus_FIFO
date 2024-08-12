module synchronizer_TB();

	reg [4:0]asynch_data;
	reg gen_clk, reset;
	wire [4:0]sunch_data;
	synchronizer UUT(
					asynch_data,
					gen_clk,
					reset,
					sunch_data
					);
	
	initial begin
		gen_clk = 1'b0; reset = 1'b0;
		#7  reset = 1'b1;
		#10 reset = 1'b0;
		#31 asynch_data = 5'd16;
		#19 asynch_data = 5'd6;
	end
	
	always gen_clk = #5 ~gen_clk;


endmodule