//偶数分频器
module clk_devider(
	input sys_clk,	//基准时钟
	input reset,//复位

	output reg clk_devided);//输出分频时钟
 
	parameter divide=10000;//分频系数，可设置
 
	reg [15:0] count;//计数器
 
initial begin
	count<=16'd0;		
	clk_devided<=1'b0;
end

always @(posedge sys_clk or negedge reset)begin
	if(reset)begin//复位将状态初始化
		count<=16'd0;		
		clk_devided<=1'b0;
	end
	else begin 
		if(count<divide/2-1)begin//每计数divide/2个时钟，则将输出反转，然后计时器清零
			count<=count+1'b1;
			clk_devided<=clk_devided;
		end
		else begin
			count<=16'd0;
			clk_devided<=~clk_devided;	
		end
	end
end
 
endmodule 
