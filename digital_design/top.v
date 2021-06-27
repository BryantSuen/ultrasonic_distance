`timescale 1ns / 1ps



module top(system_clk,reset,cathode,stimulus,leds);
input system_clk,reset,cathode;
output stimulus;
output[11:0] leds;
wire[11:0] show;
wire clk_34,clk_17k;
reg ena;
clock clock_1(.system_clk(system_clk),.reset(reset),.clk_1k(clk_1k),.clk_17k(clk_17k),.stimulus(stimulus),.clk_34(clk_34));
counter counter_1(.ena(ena),.reset(reset),.clk(clk_17k),.show(show));
always @(posedge cathode or posedge reset or posedge clk_34) begin
    if(reset) ena<=0;
    else begin
      if(cathode) ena<=0;
      else ena<=1;
    end
end
assign leds=show;
endmodule