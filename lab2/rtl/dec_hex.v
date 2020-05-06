`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 06.05.2020 15:15:49
// Design Name: 
// Module Name: dec_hex
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module dec_hex (
			input        [3:0]    in,
			output reg   [6:0]    OUT );

always @ (*) begin

case (in)
		5'h0 : OUT = 7'b1000000;
		5'h1 : OUT = 7'b1111001;
		5'h2 : OUT = 7'b0100100;
		5'h3 : OUT = 7'b0110000;
		5'h4 : OUT = 7'b0011001;
		5'h5 : OUT = 7'b0010010;
		5'h6 : OUT = 7'b0000010;
		5'h7 : OUT = 7'b1111000;
		5'h8 : OUT = 7'b0000000;
		5'h9 : OUT = 7'b0010000;
		5'ha : OUT = 7'b0001000;
		5'hb : OUT = 7'b0000011;
		5'hc : OUT = 7'b1000110;
		5'hd : OUT = 7'b0100001;
		5'he : OUT = 7'b0000110;
		5'hf : OUT = 7'b0001110; 
		
default : OUT = 7'b1111111;

endcase
end

endmodule
