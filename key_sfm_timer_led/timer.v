module timer(
	input wire clk,
	input wire rst,
	output reg pulse
);

reg [22:0] cnt;
parameter MAX_CNT = 23'd7_999_999;

always@(posedge clk or negedge rst)	begin
	if(!rst)	begin
		cnt <= 23'd0;
		pulse <= 1'b0;
	end else begin
		if(cnt == MAX_CNT)	begin
			cnt <= 23'd0;
			pulse <= 1'b1;
		end else begin
			cnt <= cnt + 1'd1;
			pulse <= 1'b0; 
		end
	end
end

endmodule
