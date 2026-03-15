module top(
	input wire 			clk,
	input wire 			rst,
	output wire [7:0] seg,
	output wire [7:0] sel
);

	wire [19:0] dsp_count;
	
	counter u_counter(
		.clk(clk),
		.rst(rst),
		.dsp_count(dsp_count)
	);
	
	display_logic u_display(
		.clk(clk),
		.rst(rst),
		.dsp_count(dsp_count),
		.seg(seg),
		.sel(sel)
	);
	
endmodule
