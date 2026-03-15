module key_led
(
	key,
	led
);

input key;
output led;

assign led = key;	//led与key相连接

endmodule
