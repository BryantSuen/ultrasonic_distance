`timescale 1ns / 1ps

module bcd(
	din,
	dout
);
input 	[3:0]	din;
output 	[3:0] 	dout;

assign	dout=(din==4'h0)?4'b0000:
             (din==4'h1)?4'b0001:
             (din==4'h2)?4'b0010:
             (din==4'h3)?4'b0011:
             (din==4'h4)?4'b0100:
             (din==4'h5)?4'b0101:
             (din==4'h6)?4'b0110:
             (din==4'h7)?4'b0111:
             (din==4'h8)?4'b1000:
             (din==4'h9)?4'b1001:4'b0;
endmodule

