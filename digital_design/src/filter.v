`timescale 1ns / 1ps


module filter(reset,clk_34,raw,show);
input reset,clk_34;
input [11:0] raw;
output [11:0] show;

parameter WIDTH = 32;
parameter SUM_BIT = 5;

//把raw转换成真正的数字
reg [9:0] num;
always @(*) begin
    num<={6'b0,raw[11:8]}+
    {3'b0,raw[7:4],3'b0}+{5'b0,raw[7:4],1'b0}+
    {raw[3:0],6'b0}+{1'b0,raw[3:0],5'b0}+{4'b0,raw[3:0],2'b0};
end

reg [9:0] shreg[0:WIDTH-1];

integer i;
always @(posedge clk_34 or posedge reset) begin
    if(reset) begin
        for (i = 0; i < WIDTH; i = i+1)  shreg[i] <= 10'b0;
    end
    for (i = 0; i < WIDTH-1; i = i+1)  shreg[i+1] <= shreg[i];
    shreg[0] <= num; 
end

reg [9+SUM_BIT:0] sum;
always @(*) begin
    sum='b0;
    for (i = 0; i < WIDTH; i = i+1)  sum=sum+shreg[i];
end

wire [9:0] result=sum[9+SUM_BIT:SUM_BIT];
//把结果在拆成百位十位个位
wire[3:0] hundreds,tens,ones;
assign hundreds=(result>=10'd900)?4'd9:
               (result>=10'd800)?4'd8:
               (result>=10'd700)?4'd7:
               (result>=10'd600)?4'd6:
               (result>=10'd500)?4'd5:
               (result>=10'd400)?4'd4:
               (result>=10'd300)?4'd3:
               (result>=10'd200)?4'd2:
               (result>=10'd100)?4'd1:
               4'b0;
//更新数据吐了
wire [9:0] result1;
assign result1=(result>=10'd900)?result-10'd900:
               (result>=10'd800)?result-10'd800:
               (result>=10'd700)?result-10'd700:
               (result>=10'd600)?result-10'd600:
               (result>=10'd500)?result-10'd500:
               (result>=10'd400)?result-10'd400:
               (result>=10'd300)?result-10'd300:
               (result>=10'd200)?result-10'd200:
               (result>=10'd100)?result-10'd100:
               result;

assign tens =  (result1>=10'd90)?4'd9:
               (result1>=10'd80)?4'd8:
               (result1>=10'd70)?4'd7:
               (result1>=10'd60)?4'd6:
               (result1>=10'd50)?4'd5:
               (result1>=10'd40)?4'd4:
               (result1>=10'd30)?4'd3:
               (result1>=10'd20)?4'd2:
               (result1>=10'd10)?4'd1:
               4'b0;

wire [9:0] result2;
assign result2=(result1>=10'd90)?result-10'd90:
               (result1>=10'd80)?result-10'd80:
               (result1>=10'd70)?result-10'd70:
               (result1>=10'd60)?result-10'd60:
               (result1>=10'd50)?result-10'd50:
               (result1>=10'd40)?result-10'd40:
               (result1>=10'd30)?result-10'd30:
               (result1>=10'd20)?result-10'd20:
               (result1>=10'd10)?result-10'd10:
               result1;

assign ones =  result2[3:0];

assign show={ones,tens,hundreds};
endmodule
