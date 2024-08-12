/*  #Parallel read and write operation
	#User needs to control the addresses when writting and reading 
	is happening on the same address simultaneously.
	#RAM is a 16x16 mem unit initialized to all 0.
*/
module FIFO_mem (
	input [3:0]w_add,
	input [15:0]w_data,
	input w_en,
	input w_clk,
	////////////////////////
	input [3:0]r_add,
	output [15:0]r_data,
	input r_en,
	input r_clk,
	
	input full,
	input empty
);

	reg [15:0]RAM[15:0];
	integer i;
	initial begin	// initialize RAM
		for (i=0; i<16; i=i+1) begin
			RAM[i] = 16'h0;
		end
	end
	
	////////////////***************Writing in RAM
	always @ (posedge w_clk) begin
		if (w_en & ~full) begin
			RAM[w_add] <= w_data;     // write operation
		end
		else begin
			RAM[w_add] <= RAM[w_add]; // latch
		end 		
	end
	
	////////////////***************Reading from RAM
	reg [15:0]r_data_reg;
	assign r_data = r_data_reg;
	always @ (posedge r_clk) begin
		if (r_en & ~empty) begin
			r_data_reg <= RAM[r_add];
		end
		else begin
			r_data_reg <= r_data_reg;
		end		
	end
	
	


endmodule