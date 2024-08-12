module TB_TopLevelModule ();
	
	reg [15:0]data_in;
	reg FIFO_w_clk, FIFO_w_en, FIFO_w_reset;
	wire FIFO_full;
	wire [15:0]data_out;
	reg FIFO_r_clk, FIFO_r_en, FIFO_r_reset;
	wire FIFO_empty;
	TopLevelModule 	UUT(
						data_in, 
						FIFO_w_clk,
						FIFO_w_en,
						FIFO_w_reset,
						FIFO_full,
					//********************//
						FIFO_r_clk,
						FIFO_r_en,
						FIFO_r_reset,
						data_out,
						FIFO_empty
					);
	
	initial begin
		FIFO_w_clk = 1'b0; FIFO_w_en = 1'b0; FIFO_w_reset = 1'b0; data_in = 16'h0000;
		FIFO_r_clk = 1'b0; FIFO_r_en = 1'b0; FIFO_r_reset = 1'b0;
		
		#10 FIFO_w_reset = 1'b1; FIFO_r_reset 	= 1'b1;
		#5 FIFO_w_en = 1'b1; 	 FIFO_r_en 		= 1'b1;
		#5 data_in = 16'h1111;
		#3 FIFO_w_reset = 1'b0;	 FIFO_r_reset 	= 1'b0;
		#5 data_in = 16'h1111;
		@(posedge FIFO_w_clk)  data_in = 16'h2222;
		@(posedge FIFO_w_clk)  data_in = 16'h3333;
		@(posedge FIFO_w_clk)  data_in = 16'h4444;
		@(posedge FIFO_w_clk)  data_in = 16'h5555;
		@(posedge FIFO_w_clk)  data_in = 16'h6666;
		@(posedge FIFO_w_clk)  data_in = 16'h7777;
		@(posedge FIFO_w_clk)  data_in = 16'h8888;
		@(posedge FIFO_w_clk)  data_in = 16'h9999;
		@(posedge FIFO_w_clk)  data_in = 16'haaaa;
		@(posedge FIFO_w_clk)  data_in = 16'hbbbb;
		@(posedge FIFO_w_clk)  data_in = 16'hcccc;
		@(posedge FIFO_w_clk)  data_in = 16'hdddd;
		@(posedge FIFO_w_clk)  data_in = 16'heeee;
		@(posedge FIFO_w_clk)  data_in = 16'hFFFF;
		@(posedge FIFO_w_clk)  data_in = 16'h1112;
		@(posedge FIFO_w_clk)  data_in = 16'h1113;
		@(posedge FIFO_w_clk)  data_in = 16'h1114;
		@(posedge FIFO_w_clk)  data_in = 16'h1112;
		@(posedge FIFO_w_clk)  data_in = 16'h1113;
		@(posedge FIFO_w_clk)  data_in = 16'h1112;
		@(posedge FIFO_w_clk)  data_in = 16'h1113;
		@(posedge FIFO_w_clk)  data_in = 16'h1112;
		@(posedge FIFO_w_clk)  data_in = 16'h1113;
		#100 FIFO_w_en = 1'b0;
		#32 FIFO_w_en = 1'b01;
		#300 FIFO_w_reset = 1'b1; FIFO_r_reset = 1'b1; 
		#50  FIFO_w_reset = 1'b0; FIFO_r_reset = 1'b0; 
		#50 data_in = 16'h2222;
		@(posedge FIFO_w_clk)  data_in = 16'h3333;
		@(posedge FIFO_w_clk)  data_in = 16'h4444;
		@(posedge FIFO_w_clk)  data_in = 16'h5555;
		@(posedge FIFO_w_clk)  data_in = 16'h6666;
		@(posedge FIFO_w_clk)  data_in = 16'h7777;
		@(posedge FIFO_w_clk)  data_in = 16'h8888;
		@(posedge FIFO_w_clk)  data_in = 16'h9999;
		@(posedge FIFO_w_clk)  data_in = 16'haaaa;
		@(posedge FIFO_w_clk)  data_in = 16'hbbbb;
		@(posedge FIFO_w_clk)  data_in = 16'hcccc;
		@(posedge FIFO_w_clk)  data_in = 16'hdddd;
		@(posedge FIFO_w_clk)  data_in = 16'heeee;
		@(posedge FIFO_w_clk)  data_in = 16'hFFFF;
		@(posedge FIFO_w_clk)  data_in = 16'h1112;
		@(posedge FIFO_w_clk)  data_in = 16'h1113;
		@(posedge FIFO_w_clk)  data_in = 16'h1114;
		@(posedge FIFO_w_clk)  data_in = 16'h1112;
		@(posedge FIFO_w_clk)  data_in = 16'h1113;
		@(posedge FIFO_w_clk)  data_in = 16'h1112;
		@(posedge FIFO_w_clk)  data_in = 16'h1113;
		@(posedge FIFO_w_clk)  data_in = 16'h1112;
		@(posedge FIFO_w_clk)  data_in = 16'h1113;
	end
	
	always FIFO_w_clk = #5 ~FIFO_w_clk;
	always FIFO_r_clk = #15 ~FIFO_r_clk;


endmodule