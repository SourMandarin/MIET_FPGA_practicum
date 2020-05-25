`timescale 1ns / 1ps

module stopwatch_tb(
);

localparam CLK_FREQ_MHZ   = 50;
localparam CLK_SEMIPERIOD = ( 1000 / CLK_FREQ_MHZ) / 2;

reg          clk100_i;
reg          rstn_i;
reg          change_i;
reg          set_i;
reg          start_stop_i;
wire [6:0]   hex1_o;
wire [6:0]   hex0_o;
wire [6:0]   hex2_o;
wire [6:0]   hex3_o;

stopwatch DUT (
  .clk100_i        ( clk100_i       ),
  .rstn_i          ( rstn_i         ),
  .change_i        ( change_i       ),
  .set_i           ( set_i          ),
  .start_stop_i    ( start_stop_i   ),
  .hex0_o          ( hex0_o         ),
  .hex1_o          ( hex1_o         ),
  .hex2_o          ( hex2_o         ),
  .hex3_o          ( hex3_o         )
);

initial begin
  clk100_i = 1'b1;
  forever begin
    #CLK_SEMIPERIOD
    clk100_i=~clk100_i;
  end
end

initial begin
        rstn_i = 1;
        change_i = 1;
        set_i = 1;
        start_stop_i = 1;
  #100;
        rstn_i = 0;
  #100;
        rstn_i = 1;
  #1000;
        start_stop_i = 0;
        set_i = 0;
  #100;
        start_stop_i = 1;
  #100;
        set_i = 0;
  #100
        set_i = 1;

  repeat( 3 ) begin
    #100;
          change_i = 0;
    #100
          change_i = 1;
  end 

  #1000;
        start_stop_i = 0;
  #100;
        start_stop_i = 1;

  #100;
        set_i = 0;
        change_i = 0;
  #100
        set_i = 1;

  repeat( 16 ) begin
    #100;
          change_i = 0;
    #100
          change_i = 1;
  end 

  #100;
        start_stop_i = 0;
  #100;
        start_stop_i = 1;

  repeat( 4 ) begin
    #100;
          set_i = 0;
    #100
          set_i = 1;
  end

  #100;
        start_stop_i = 0;
  #100;
        start_stop_i = 1;

end

endmodule