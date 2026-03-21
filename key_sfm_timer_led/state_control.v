module state_control(
	input wire clk,
	input wire rst,
	input wire key1_db,	//当前时刻的电平
	input wire key2_db,
	output reg locked,
	output reg unlocked
);

//状态定义
reg state;
parameter LOCKED	= 1'b0;
parameter UNLOCKED = 1'b1;

//按键边沿检测(下降沿）
reg key1_r,key2_r;		//上一时刻的电平
wire key1_fall = (key1_r == 1'b1 && key1_db == 1'b0);		//按键按下
wire key2_fall = (key2_r == 1'b1 && key2_db == 1'b0);

always@(posedge clk or negedge rst)	begin
	if(!rst)	begin
		state <= LOCKED;
		locked <= 1'b1;	//ld8亮
		unlocked <= 1'b0;	//ld1灭
		key1_r <= 1'b1;
		key2_r <= 1'b1;
	end else begin
		//寄存上一个时刻的电平
		key1_r <= key1_db;	//按键是刚刚按下的还是一直按着的?
		key2_r <= key2_db;
		
		//状态切换
		if(key1_fall)	begin
			state <= 1'b1;
		end else if(key2_fall) begin
			state <= 1'b0;
		end
		
		//根据当前状态输出led
		if(state == UNLOCKED)	begin
			locked <= 1'b0;
			unlocked <= 1'b1; 
		end else begin		//锁定
			locked <= 1'b1;	//ld8亮
			unlocked <= 1'b0;	//ld1灭
		end
	end
end

endmodule
