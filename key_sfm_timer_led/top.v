module top(
	input wire clk,
	input wire rst_n,	//低电平复位按键
	input wire key1,
	input wire key2,
	input wire key3,
	input wire key4,
	output reg ld1,
	output reg ld2,
	output reg ld3,
	output reg ld8
);

//按键消抖模块
wire s1_db,s2_db,s3_db,s4_db;		//?
key u_deb1 (
 .clk(clk),
 .rst(rst_n),
 .key_in (key1),
 .key_out(s1_db)
); 
key u_deb2 (
  .clk(clk),
  .rst(rst_n),
  .key_in (key2),
  .key_out(s2_db)
);
key u_deb3 (
  .clk(clk),
  .rst(rst_n),
  .key_in (key3),
  .key_out(s3_db)
);
key u_deb4 (
  .clk(clk),
  .rst(rst_n),
  .key_in (key4),
  .key_out(s4_db)
);

//实例化状态机模块
wire locked,unlocked;
state_control u_state(
  .clk(clk),
  .rst(rst_n),
  .key1_db(s1_db),	
  .key2_db(s2_db),
  .locked(locked),	//？这是和谁连接了
  .unlocked(unlocked)
);

wire pulse_100ms;
timer u_timer(
  .clk(clk),
  .rst(rst_n),
  .pulse(pulse_100ms)
);

//ld控制逻辑
reg ld3_reg;
always@(posedge clk or negedge rst_n)	begin
	if(!rst_n)	begin
		ld3_reg <= 1'b0;
	end else begin
		if(unlocked && !s4_db)	begin
			if(pulse_100ms)
				ld3_reg <= ~ld3_reg;
		end else begin
			ld3_reg <= 1'b0;
		end
	end
end

always@(*)	begin		//不用*，用posedge clk or negedge rst_n可以吗
	ld1 = unlocked;
	ld2 = unlocked && !s3_db;
	ld3 = ld3_reg;
	ld8 = locked;		//为啥不用<=
end
endmodule
