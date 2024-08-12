module read_ptr_controller(
	input r_clk,
	input r_en,
	input r_reset,
	input  [4:0]w_add_synched, // comes from write_ptr_controller(in binary after synchronization with rclk)
	output [4:0]r_add, 	// goes to FIFO mem
	output [4:0]r_add_gray_synch, // goes to read_ptr_controller
	output empty	
);
	assign empty = (w_add_synched == r_add)? 1'b1:1'b0;
	
	reg [4:0]r_add_reg;
	assign r_add = r_add_reg;
	always @ (posedge r_reset, posedge r_clk) begin
			if (r_reset) begin
				r_add_reg <= 5'd0;
			end
			else begin
				if (r_en & ~empty) begin
					if (r_add_reg == 5'd31) begin						
						r_add_reg <= 5'd0; // Rotate
					end
					else begin
						r_add_reg <= r_add_reg + 5'd1;
					end					
				end
				else if (r_en & empty) begin
					r_add_reg <= r_add_reg; // wait for full to go '0'
				end
				else begin
					r_add_reg <= r_add_reg; // removing write enable fixes the w_add to its last known position
				end
			end
	end

	
	wire [4:0]r_add_gray_asynch;
	BinaryToGray B2G(
					r_add_reg, // synchronized with w_clk
					r_add_gray_asynch
	);
	reg [4:0]r_add_gray_synch_reg;
	assign r_add_gray_synch = r_add_gray_synch_reg;
	always @ (posedge r_reset, posedge r_clk) begin
			if (r_reset) begin
				r_add_gray_synch_reg <= 5'd0;
			end
			else begin
				if (r_en) begin
					r_add_gray_synch_reg <= r_add_gray_asynch;
				end
				else begin
					r_add_gray_synch_reg <= r_add_gray_synch_reg;
				end
			end
	end

endmodule