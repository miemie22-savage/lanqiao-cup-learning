module key(
	input wire rst,		
	input wire clk,
	input wire key_in,
	output reg key_out
);

//两级同步，消除亚稳态（这个信号的变化刚好发生在时钟上升沿的“判决窗口”内，触发器既不是0也不是1）
reg key_sync1;
reg key_sync2;	//当前采样值
always@(posedge clk or negedge rst)	begin
	if(!rst)	begin
		key_sync1 <= 1'b1;			//用d也可以，b更直观
		key_sync2 <= 1'b1;
	end else begin
		key_sync1 <= key_in;
		key_sync2 <= key_sync1;		//将信号和系统时钟同步
	end
end

reg [20:0] cnt;						//计数1,600,000个周期，2的21次方
reg stable_state;
parameter DELAY_CNT = 21'd1_600_000-1'd1;

always@(posedge clk or negedge rst)	begin
	if(!rst)	begin		//复位，要复全
		cnt <= 21'd0;
		stable_state <= 1'b1;
		key_out <= 1'b1;
	end else begin
		if(key_sync2 == stable_state)	begin
			if(cnt < DELAY_CNT)	//没有记满
				cnt <= cnt + 1'b1;
			else
				key_out <= key_sync2;	//记满了，一段时间内保持同一个状态，可以输出
		end else begin
				cnt <= 21'd0;
				stable_state <= key_sync2;	//没记满，重开一轮
		end
	end
end

endmodule
