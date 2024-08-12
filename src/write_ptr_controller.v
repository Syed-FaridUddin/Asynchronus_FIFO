module write_ptr_controller(
	input w_clk,
	input w_en,
	input w_reset,
	input  [4:0]r_add_synched, // comes from read_ptr_controller(in binary after synchronization with wclk)
	output [4:0]w_add, 	// goes to FIFO mem
	output [4:0]w_add_gray_synch, // goes to read_ptr_controller
	output full
);
	assign full = ({~w_add[4], w_add[3:0]} == r_add_synched)? 1'b1:1'b0;
	
	reg [4:0]w_add_reg;
	assign w_add = w_add_reg;
	always @ (posedge w_reset, posedge w_clk) begin
			if (w_reset) begin
				w_add_reg <= 5'd0;
			end
			else begin
				if (w_en & ~full) begin
					if (w_add_reg == 5'd31) begin						
						w_add_reg <= 5'd0; // Rotate
					end
					else begin
						w_add_reg <= w_add_reg + 5'd1;
					end					
				end
				else if (w_en & full) begin
					w_add_reg <= w_add_reg; // wait for full to go '0'
				end
				else begin
					w_add_reg <= w_add_reg; // removing write enable fixes the w_add to its last known position
				end
			end
	end

	
	wire [4:0]w_add_gray_asynch;
	BinaryToGray B2G(
					w_add_reg, // synchronized with w_clk
					w_add_gray_asynch
	);
	reg [4:0]w_add_gray_synch_reg;
	assign w_add_gray_synch = w_add_gray_synch_reg;
	always @ (posedge w_reset, posedge w_clk) begin
			if (w_reset) begin
				w_add_gray_synch_reg <= 5'd0;
			end
			else begin
				if (w_en) begin
					w_add_gray_synch_reg <= w_add_gray_asynch;
				end
				else begin
					w_add_gray_synch_reg <= w_add_gray_synch_reg;
				end
			end
	end

endmodule