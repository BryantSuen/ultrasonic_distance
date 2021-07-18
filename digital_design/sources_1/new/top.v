


`timescale 1ns / 1ps
module top(system_clk,reset,cathode,stimulus,leds);

input system_clk,reset,cathode;
output stimulus;
output reg[11:0] leds;

wire[11:0] show;
wire clk_34,clk_17k;
reg ena;
wire [11:0] raw;

stimulus stimulus_1(.system_clk(system_clk),.reset(reset),.stimulus(stimulus),.clk_17k(clk_17k),.clk_34(clk_34));

clk_devider #(.divide(5882))clk_devider_17k(.sys_clk(system_clk),.reset(reset),.clk_devided(clk_17k));

counter counter_1(.ena(ena),.reset(clk_34),.clk(clk_17k),.show(raw));

filter #(.WIDTH(8),.SUM_BIT(3))filter_1(.reset(reset),.clk_34(clk_34),.raw(raw),.show(show));

always @(posedge cathode or posedge reset or posedge clk_34)
  begin
    if(reset)
      ena<=0;
    else
      begin
        if(cathode)
          ena<=0;
        else
          ena<=1;
      end
  end
//assign leds=show;
always @(posedge clk_34) begin
  leds <= show;
end
endmodule