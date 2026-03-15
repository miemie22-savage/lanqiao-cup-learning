module MUX_2to1
(
	in1,		//s3
	in2,		//s2
	sel,		//s1
	out   	//led1
);

input in1,in2,sel;
output out;

assign out = (~sel&in1) | (sel&in2);

endmodule
