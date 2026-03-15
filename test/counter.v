module counter(
	input wire 			clk,
	input wire 			rst,
	output reg [19:0] dsp_count
);

localparam DSP_COUNT = 20'd50000;

always@(posedge clk or negedge rst)begin
	if(!rst)
		dsp_count <= 20'd0;
	else if(dsp_count == DSP_COUNT - 1)
		dsp_count <= 20'd0;
	else
		dsp_count <= dsp_count + 20'd1;
end

endmodule
