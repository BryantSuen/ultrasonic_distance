`timescale 1ns / 1ps

module stimulus(system_clk,reset,clk_17k,stimulus,clk_34);
input system_clk,reset;
input clk_17k;
output stimulus;
output reg clk_34;
integer  cnt_40k,cnt_34,cnt_17k;
reg clk_40k;
always @(posedge system_clk or posedge reset) begin
    if (reset) begin
        clk_40k <= 0;
        cnt_40k<=0;
      end
    else begin
        if (cnt_40k >= 1249) begin
            cnt_40k <= 0;
            clk_40k <= ~clk_40k;
          end
        else begin
            cnt_40k <= cnt_40k + 1;
          end
      end
end

always @(posedge clk_17k or posedge reset) begin
    if(reset) begin
      cnt_34<=0;
      clk_34<=0;
    end
    else begin
      if(cnt_34==0) clk_34=1;
      else clk_34=0;
      if(cnt_34<499) cnt_34=cnt_34+1;
      else cnt_34=0;
    end
end

assign stimulus=clk_34&&clk_40k;
endmodule
