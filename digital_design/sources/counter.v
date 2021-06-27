`timescale 1ns / 1ps

module counter(ena,reset,clk,show);
input ena,reset,clk;
output reg[11:0] show;
reg[3:0] show1,show2,show3;
always @(posedge clk or posedge reset)
  begin
    if (reset)
      begin
        show3 <= 4'd0;
        show2 <= 4'd0;
        show1 <= 4'd0;
      end
    else
      begin
        if (ena)
          begin
            show1 <= show1 + 1;
            if (show1 == 4'd9)
              begin
                show1 <= 4'd0;
                show2 <= show2 + 1;
                if (show2 == 4'd9)
                  begin
                    show2 <= 4'd0;
                    show3 <= show3 + 1;
                    if (show3 == 4'd9)
                      begin
                        show3 <= 4'd0;
                      end
                  end
              end
          end
      end
  end
  always @(negedge ena) begin
      show<={show1,show2,show3};
      show1<=0;
      show2<=0;
      show3<=0;
  end
endmodule
