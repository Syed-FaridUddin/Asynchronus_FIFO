module TB_write_ptr_controller();
	
	reg w_clk, w_en, w_reset;
	reg [4:0]r_add_synched;
	wire [4:0]w_add, w_add_gray_synch;
	wire full;
	
	write_ptr_controller UUT(
						w_clk,
						w_en,
						w_reset,
						r_add_synched, // comes from read_ptr_controller(in binary after synchronization with wclk)
						w_add, 	// goes to FIFO mem
						w_add_gray_synch, // goes to read_ptr_controller
						full
					);
	
	initial begin
		w_clk = 1'b0; w_en = 1'b0; w_reset = 1'b0; r_add_synched = 5'd0; // should stop at 5'd16		
		#5  w_reset = 1'b1;
		#1  w_en = 1'b01;
		#20 w_reset = 1'b0;
		#60 w_en = 1'b0;
		#30 w_en = 1'b01;
		#300 w_reset = 1'b1;
		#15 w_reset = 1'b0; r_add_synched = 5'd5; // should stop at 5'd21
	end
	
	always w_clk = #5 ~w_clk;
	
endmodule