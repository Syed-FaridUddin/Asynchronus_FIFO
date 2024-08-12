module synchronizer(
	input [4:0]asynch_data,
	input gen_clk,
	input reset,
	output [4:0]synch_data
);
	reg [4:0]out_FF1;
	reg [4:0]out_FF2;
	assign synch_data = out_FF2;
	always @ (posedge reset, posedge gen_clk) begin
		if (reset) begin
			out_FF1 <= 5'd0;
		end
		else begin
			out_FF1 <= asynch_data;
		end
	end
	
	always @ (posedge reset, posedge gen_clk) begin
		if (reset) begin
			out_FF2 <= 5'd0;
		end
		else begin
			out_FF2 <= out_FF1;
		end
	end


endmodule