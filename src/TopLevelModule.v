module TopLevelModule (
		input 	[15:0]data_in, 
		input 	FIFO_w_clk,
		input 	FIFO_w_en,
		input 	FIFO_w_reset,
		output	FIFO_full,
	//********************//
		input 	FIFO_r_clk,
		input 	FIFO_r_en,
		input 	FIFO_r_reset,
		output 	[15:0]data_out,
		output	FIFO_empty
);
	//////////////////////////////////

	reg  [4:0]r_add_synched;
	wire [4:0]w_add; //op
	wire [4:0]w_add_gray_w_clk; //op: asynch with r_clk
	wire [4:0]w_add_gray_r_clk; //synch with r_clk
	wire [4:0]w_add_bin_r_clk;
	reg  [4:0]w_add_synched;
	
	wire [4:0]r_add;
	wire [4:0]r_add_gray_r_clk; // wrt wclk
	wire [4:0]r_add_gray_w_clk; //synch with w_clk
	wire [4:0]r_add_bin_w_clk;
	
	always @ (posedge FIFO_w_clk) begin
		if (FIFO_w_reset) begin
			r_add_synched <= 5'd0;
		end
		else begin
			r_add_synched <= r_add_bin_w_clk;
		end
	end
	
	always @ (posedge FIFO_r_clk) begin
		if (FIFO_r_reset) begin
			w_add_synched <= 5'd0;
		end
		else begin
			w_add_synched <= w_add_bin_r_clk;
		end
	end
	
	

	/////////////////////////////////
	
	write_ptr_controller w_ptr(
							 .w_clk(FIFO_w_clk),
							 .w_en(FIFO_w_en),
							 .w_reset(FIFO_w_reset),
							 .r_add_synched(r_add_synched), // comes from read_ptr_controller(in binary after synchronization with wclk)
							 .w_add(w_add), 	// goes to FIFO mem
							 .w_add_gray_synch(w_add_gray_w_clk), // goes to read_ptr_controller
							 .full(FIFO_full)
							);
	
	
	synchronizer 		synch_r_clk(
							.asynch_data(w_add_gray_w_clk),
							.gen_clk(FIFO_r_clk),
							.reset(FIFO_r_reset),
							.synch_data(w_add_gray_r_clk)
							);
	
	
	GrayToBinary 		G2B_w(
							.gray(w_add_gray_r_clk),
							.binary(w_add_bin_r_clk)
							);
	
	
	
	read_ptr_controller r_ptr(
							 .r_clk(FIFO_r_clk),
							 .r_en(FIFO_r_en),
							 .r_reset(FIFO_r_reset),
							 .w_add_synched(w_add_synched), // comes from write_ptr_controller(in binary after synchronization with rclk)
							 .r_add(r_add), 	// goes to FIFO mem
							 .r_add_gray_synch(r_add_gray_r_clk), // goes to read_ptr_controller
							 .empty(FIFO_empty)	
						);
	
		
	synchronizer 		synch_w_clk(
							.asynch_data(r_add_gray_r_clk),
							.gen_clk(FIFO_w_clk),
							.reset(FIFO_w_reset),
							.synch_data(r_add_gray_w_clk)
							);
							
	
	GrayToBinary 		G2B_r(
							.gray(r_add_gray_w_clk),
							.binary(r_add_bin_w_clk)
							);
	
	FIFO_mem 			mem(
							.w_add(w_add[3:0]),
							.w_data(data_in),
							.w_en(FIFO_w_en),
							.w_clk(FIFO_w_clk),
							////////////////////////
							.r_add(r_add[3:0]),
							.r_data(data_out),
							.r_en(FIFO_r_en),
							.r_clk(FIFO_r_clk),
							
							.full(FIFO_full),
							.empty(FIFO_empty)
						);

endmodule