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
wire [2:0]   key_i;
reg          clk100_i;
wire [6:0]   hex0_o;
wire [6:0]   hex1_o;
wire [6:0]   hex2_o;

counter DUT 
  (
  .clk100_i ( clk100_i ),
  .sw_i     ( sw_i     ),
  .ledr_o   ( ledr_o   ),
  .key_i    ( key_i    ),
  .hex0_o   ( hex0_o   ),
  .hex1_o   ( hex1_o   ),
  .hex2_o   ( hex2_o   )
  );

reg [2:0] sw = 3'b111;

assign key_i = sw;

initial begin
  clk100_i = 1'b1;
  forever begin
    #CLK_SEMIPERIOD clk100_i = ~clk100_i;
  end
end

initial begin
  sw_i[9:0] = 10'd0;
  repeat(20)begin
    #(CLK_SEMIPERIOD - 1);
    sw_i[9:0] = $random();
  end
end

initial begin
  #10  sw[1] = 1'b0;
  #10;
  #10  sw[1] = 1'b1;
  #100;
       sw[2] = 1'b0;
       sw[0] = 1'b1;
  #100;
       sw[2] = 1'b0;
       sw[0] = 1'b0;
  #100;
       sw[2] = 1'b1;
       sw[0] = 1'b0;
  #50;
       sw[2] = 1'b1;
       sw[0] = 1'b1;
  #100;
       sw[2] = 1'b1;
       sw[0] = 1'b0;
  #100;
       sw[2] = 1'b0;
       sw[0] = 1'b0;
  #100;
       sw[2] = 1'b0;
       sw[0] = 1'b1;
  #50;
       sw[2] = 1'b1;
       sw[0] = 1'b1;
  #100;
       sw[2] = 1'b1;
       sw[0] = 1'b0;
  #100;
       sw[2] = 1'b0;
       sw[0] = 1'b0;
  #100;
       sw[2] = 1'b0;
       sw[0] = 1'b1;
  #50;
       sw[2] = 1'b1;
       sw[0] = 1'b1;
  #100;
       sw[2] = 1'b1;
       sw[1] = 1'b0;
       sw[0] = 1'b1;
  #100 sw[1] = 1'b1;
  #100 sw[2] = 1'b0;
  #100 sw[2] = 1'b1;
  #100 sw[0] = 1'b1;
  #100 sw[0] = 1'b0;
  #100 sw[2] = 1'b0;
  #100 sw[2] = 1'b1;
  #100 sw[0] = 1'b1;
  #100 sw[0] = 1'b0;
  #100 sw[2] = 1'b0;
  #100 sw[2] = 1'b1;
  #100 sw[0] = 1'b1;
  #100 sw[0] = 1'b0;
  #100 sw[2] = 1'b0;
  #100 sw[2] = 1'b1;
  #100 sw[0] = 1'b1;
  #100 sw[0] = 1'b0;
  #100 sw[2] = 1'b0;
  #100 sw[2] = 1'b1;
  #100 sw[0] = 1'b1;
  #100 sw[0] = 1'b0;
  #100 sw[2] = 1'b0;
  #100 sw[2] = 1'b1;
  #100 sw[0] = 1'b1;
  #100 sw[0] = 1'b0;
  #100 sw[2] = 1'b0;
  #100 sw[2] = 1'b1;
  #100 sw[0] = 1'b1;
  #100 sw[0] = 1'b0;
  #100 sw[2] = 1'b0;
  #100 sw[2] = 1'b1;
  #100 sw[0] = 1'b1;
  #100 sw[0] = 1'b0;
  #100 sw[2] = 1'b0;
  #100 sw[2] = 1'b1;
  #100 sw[0] = 1'b1;
  #100 sw[0] = 1'b0;
  #100 sw[2] = 1'b0;
  #100 sw[2] = 1'b1;
  #100 sw[0] = 1'b1;
  #100 sw[0] = 1'b0;
  #100 sw[2] = 1'b0;
  #100 sw[2] = 1'b1;
end

endmodule