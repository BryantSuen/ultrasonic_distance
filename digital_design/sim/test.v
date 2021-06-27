`timescale 1ns / 1ps


module test();
reg clk,reset;
reg cathode;
wire[11:0] leds;
initial begin
    clk<=0;
    reset<=1;
    //sim_ena<=0;
    cathode<=0;
    #100 reset<=0;
end
always #5 clk=~clk;
top top_1(.system_clk(clk),.reset(reset),.cathode(cathode),.stimulus(stimulus),.leds(leds));
wire clk_34=top_1.clk_34;
wire[3:0] show1=top_1.show[11:8];
wire[3:0] show2=top_1.show[7:4];
wire[3:0] show3=top_1.show[3:0];
always @(posedge clk_34) begin
    #3000000 cathode<=0;
    #(({$random} % 100)*100000) cathode<=1;
    #100 cathode<=0;
end
endmodule
