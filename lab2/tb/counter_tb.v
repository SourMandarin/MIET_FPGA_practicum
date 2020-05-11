`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 06.05.2020 15:20:19
// Design Name: 
// Module Name: counter_tb
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


module counter_tb
  (
  );

localparam CLK_FREQ_MHZ   = 50;
localparam CLK_SEMIPERIOD = ( 1000 / CLK_FREQ_MHZ ) / 2;

reg  [9:0]   sw_i;
wire [9:0]   ledr_o;
wire [1:0]   key_i;
reg          clk100_i;
wire [6:0]   hex0_o;
wire [6:0]   hex1_o;

counter DUT 
  (
  .clk100_i ( clk100_i ),
  .sw_i     ( sw_i     ),
  .ledr_o   ( ledr_o   ),
  .key_i    ( key_i    ),
  .hex1_o   ( hex0_o   ),
  .hex0_o   ( hex1_o   )
  );

reg [1:0] sw = 2'b11;

initial begin
  clk100_i = 1'b1;
  forever begin
    #CLK_SEMIPERIOD clk100_i = ~clk100_i;
  end
end

initial begin
  sw_i[9:0] = 10'd0;
  forever begin
    #(CLK_SEMIPERIOD - 1);
    sw_i[9:0] = $random();
  end
end

initial begin
  repeat ( 16 )
  begin
    #50;
    sw = $random();
  end
end

assign key_i = sw;

endmodule