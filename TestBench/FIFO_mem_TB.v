module FIFO_mem_TB();

	reg [3:0]w_add;
	reg [15:0]w_data;
	reg w_en;
	reg w_clk;
	////////////////////////
	reg [3:0]r_add;
	wire [15:0]r_data;
	reg r_en;
	reg r_clk;
	
	reg full,empty;
	FIFO_mem UUT(
	w_add,
	w_data,
	w_en,
	w_clk,
	////////////////////////
	r_add,
	r_data,
	r_en,
	r_clk,
	full,
	empty
	);
	
	initial begin
		w_clk = 1'b0; r_clk = 1'b0; w_en = 1'b0; r_en = 1'b0; full = 1'b0; empty = 1'b0; //neither full nor empty
		#10 r_en = 1; r_add = 16'h5; 
		#20 r_add = 16'hF;
		#10 w_en = 1'b1; w_add = 16'h2; w_data = 16'hA;
		#10 r_add = 16'h2;
		#10 			 w_add = 16'h5; w_data = 16'hC;
		#20 r_add = 16'h5;
		
		/*
			r_data = 0;
			r_data = A;
			r_data = C;
		*/
	end
	
	always w_clk = #5  ~w_clk;  //Period 10
	always r_clk = #15 ~r_clk;  //Period 30
	


endmodule