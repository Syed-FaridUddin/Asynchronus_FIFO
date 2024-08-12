module TB_read_ptr_controller();
	
	reg r_clk, r_en, r_reset;
	reg [4:0]w_add_synched;
	wire [4:0]r_add, r_add_gray_synch;
	wire empty;
	
	read_ptr_controller UUT(
						r_clk,
						r_en,
						r_reset,
						w_add_synched, // comes from read_ptr_controller(in binary after synchronization with wclk)
						r_add, 	// goes to FIFO mem
						r_add_gray_synch, // goes to read_ptr_controller
						empty
					);
	
	initial begin
		r_clk = 1'b0; r_en = 1'b0; r_reset = 1'b0; w_add_synched = 5'd10; // should stop at 5'd10		
		#5  r_reset = 1'b1;
		#1  r_en = 1'b01;
		#20 r_reset = 1'b0;
		#60 r_en = 1'b0;
		#30 r_en = 1'b01;
		#300 r_reset = 1'b1;
		#15 r_reset = 1'b0; w_add_synched = 5'd0; // should stop at 5'd0
	end
	
	always r_clk = #5 ~r_clk;
	
endmodule