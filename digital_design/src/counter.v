`timescale 1ns / 1ps

module counter(ena,reset,clk,show);
input ena,reset,clk;
output [11:0] show;
reg[3:0] show1,show2,show3;
//reg[3:0] show1_reg,show2_reg,show3_reg;
//reg reset_clk;
always @(posedge clk or posedge reset)
  begin
    if (reset) //|| reset_clk)
      begin
        show3 <= 4'd0;
        show2 <= 4'd0;
        show1 <= 4'd0;
        //reset_clk<=0;
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
  assign show = {show1,show2,show3};
  // always @(negedge ena) begin
  //     show<={show1,show2,show3};
  //     reset_clk<=1;
  // end
endmodule
