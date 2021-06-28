`timescale 1ns / 1ps

module clock(system_clk,reset,clk_1k,clk_17k,stimulus,clk_34);
input system_clk,reset;
output stimulus;
output reg clk_1k,clk_17k,clk_34;
integer  cnt_40k,cnt_1k,cnt_34,cnt_17k;
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

always @(posedge system_clk or posedge reset) begin
    if (reset) begin
        clk_1k <= 0;
        cnt_1k<=0;
      end
    else begin
        if (cnt_1k >= 49999) begin
            cnt_1k <= 0;
            clk_1k <= ~clk_1k;
          end
        else begin
            cnt_1k <= cnt_1k + 1;
          end
      end
end

always @(posedge system_clk or posedge reset) begin
    if (reset) begin
        clk_17k <= 0;
        cnt_17k <= 0;
      end
    else begin
        if (cnt_17k >= 2940) begin
            cnt_17k <= 0;
            clk_17k <= ~clk_17k;
          end
        else begin
            cnt_17k <= cnt_17k + 1;
          end
      end
end

always @(posedge clk_17k or posedge reset) begin
    if(reset) begin
      cnt_34<=0;
      clk_34<=0;
    end
    else begin
      if(cnt_34 < 5) clk_34=1;
      else clk_34=0;
      if(cnt_34<499) cnt_34=cnt_34+1;
      else cnt_34=0;
    end
end

assign stimulus=clk_34&&clk_40k;
endmodule
