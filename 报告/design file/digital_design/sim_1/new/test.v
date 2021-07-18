`timescale 1ns / 1ps


module test();
reg clk,reset;
reg cathode;
wire[11:0] leds;
reg noise;
initial begin
    clk<=0;
    reset<=1;
    noise<=0;
    cathode<=0;
    #1000 reset<=0;
end
always #5 clk=~clk;
wire cathode1;
top top_1(.system_clk(clk),.reset(reset),.cathode(cathode1),.stimulus(stimulus),.leds(leds));
wire clk_34=top_1.clk_34;
wire[3:0] show1=top_1.show[11:8];
wire[3:0] show2=top_1.show[7:4];
wire[3:0] show3=top_1.show[3:0];
wire[3:0] raw1=top_1.raw[11:8];
wire[3:0] raw2=top_1.raw[7:4];
wire[3:0] raw3=top_1.raw[3:0];
integer  i;

always @(posedge clk_34) begin
    #5000000 cathode<=0;
    #(({$random} % 10)*10000) cathode<=1;
    #100 cathode<=0;
    for(i=0;i<100;i=i+1) begin
      #100 cathode<=1;
      #100 cathode<=0;
    end
end
always @(posedge clk_34) begin
    #(({$random} % 100)*100000) noise<=1;
    #100 noise<=0;
end
assign cathode1=cathode||0;
endmodule
