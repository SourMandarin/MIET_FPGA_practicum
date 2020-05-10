`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10.05.2020 12:21:18
// Design Name: 
// Module Name: button_check
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


module button_check
  (
    input  clk_i,
    input  btn_i,
    output ondn_o
  );
  
reg [1:0] sync;

initial begin
  sync[0] = 0;
  sync[1] = 0;
end

always @ ( posedge clk_i ) begin
  sync[0] <= btn_i;
  sync[1] <= sync[0];
end

assign ondn_o = ~sync[1] & sync[0];

endmodule
