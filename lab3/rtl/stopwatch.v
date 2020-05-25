module stopwatch(
  input        clk100_i,
  input        rstn_i,
  input        start_stop_i,
  input        set_i,
  input        change_i,
  output [6:0] hex0_o,
  output [6:0] hex1_o,
  output [6:0] hex2_o,
  output [6:0] hex3_o
);

reg          device_running;
reg  [3:0]   cnt;
reg  [17:0]  pulse_counter;
reg  [3:0]   hundredths_counter;
reg  [3:0]   tenths_counter;
reg  [3:0]   ten_seconds_counter;
reg  [3:0]   seconds_counter;
wire         change_down;
wire         set_down;
wire         start_down;
wire         device_stopped;
wire         hundredth_of_second_passed;
wire         tens_of_second_passed;
wire         ten_seconds_passed;
wire         second_passed;

debouncer bt0(
  .btn_i   ( !start_stop_i ),
  .ondn_o  ( start_down    ),
  .rst_i   ( rstn_i        ),
  .clk_i   ( clk100_i      )
);

debouncer bt1(
  .btn_i   ( !set_i   ),
  .ondn_o  ( set_down ),
  .rst_i   ( rstn_i   ),
  .clk_i   ( clk100_i )
);

debouncer bt3(
  .btn_i   ( !change_i   ),
  .ondn_o  ( change_down ),
  .rst_i   ( rstn_i      ),
  .clk_i   ( clk100_i    )
);

assign device_stopped = ( device_running ) ? 1'b0 : 1'b1;

always @( posedge clk100_i or negedge rstn_i ) begin
  if( !rstn_i )
    device_running = 1'b0;
  else
    begin
      if( start_down & device_running )
        device_running = 1'b0;
      else
        if( start_down & device_stopped & cnt == 0)
          device_running = 1'b1;
    end
end

assign hundredth_of_second_passed = ( pulse_counter == 18'd259999 );

always @( posedge clk100_i or negedge rstn_i ) begin
  if( !rstn_i )
    pulse_counter <= 18'd0;
  else
    if( device_running | hundredth_of_second_passed )
      if( hundredth_of_second_passed )
        pulse_counter <= 18'd0;
      else
        pulse_counter <= pulse_counter + 1;
end

assign tens_of_second_passed = ( ( hundredths_counter == 4'd9 ) & hundredth_of_second_passed );

always @( posedge clk100_i or negedge rstn_i ) begin
  if( !rstn_i )
    hundredths_counter <= 4'd0;
  else
    if( !set_down & change_down & device_stopped ) begin
      if( cnt == 1 & ( hundredths_counter < 4'd9 ) )
        hundredths_counter <= hundredths_counter + 1;
      else
        if( cnt == 1 )
          hundredths_counter <= 0;
    end
    else
      if( hundredth_of_second_passed )
        if( tens_of_second_passed )
          hundredths_counter <= 4'd0;
        else
          hundredths_counter <= hundredths_counter + 1;
end

assign second_passed = ( ( tenths_counter == 4'd9 ) & tens_of_second_passed );

always @( posedge clk100_i or negedge rstn_i ) begin
  if( !rstn_i )
    tenths_counter <= 4'd0;
  else
    if( !set_down & change_down & device_stopped ) begin
      if( cnt == 2 & tenths_counter < 4'd9 )
        tenths_counter <= tenths_counter + 1;
      else
        if( cnt == 2 )
          tenths_counter <= 0;
    end
    else
      if( tens_of_second_passed )
        if( second_passed )
          tenths_counter <= 4'd0;
        else
          tenths_counter <= tenths_counter + 1;
end

assign ten_seconds_passed = ( ( seconds_counter == 4'd9 ) & second_passed );

always @( posedge clk100_i or negedge rstn_i ) begin
  if( !rstn_i )
    seconds_counter <= 4'd0;
  else
    if( !set_down & change_down & device_stopped ) begin
      if( cnt == 3 & seconds_counter < 4'd9 )
        seconds_counter <= seconds_counter + 1;
      else
        if( cnt == 3 )
          seconds_counter <= 0;
    end
    else
      if( second_passed )
        if( ten_seconds_passed )
          seconds_counter <= 4'd0;
        else
          seconds_counter <= seconds_counter + 1;
end

always @( posedge clk100_i or negedge rstn_i ) begin
  if( !rstn_i )
    ten_seconds_counter <= 4'd0;
  else
    if( !set_down & change_down & device_stopped ) begin
      if( cnt == 4 & ten_seconds_counter < 4'd9 )
        ten_seconds_counter <= ten_seconds_counter + 1;
      else
        if( cnt == 4 )
          ten_seconds_counter <= 0;
    end
    else
      if( ten_seconds_passed )
        if( ten_seconds_counter == 4'd9 )
          ten_seconds_counter <= 4'd0;
        else
          ten_seconds_counter <= ten_seconds_counter + 1;
end

always @( posedge clk100_i or negedge rstn_i ) begin
  if( !rstn_i ) begin
    cnt <= 4'd0;
  end
  else
    if( device_stopped ) begin
      if( !start_down & set_down & cnt < 4 )
        cnt <= cnt + 1;
      else
        if( set_down & cnt == 4 )
          cnt <= 4'd0;
    end
end

dec_hex dec0(
  .in ( hundredths_counter ),
  .out( hex0_o             )
);

dec_hex dec1(
  .in ( tenths_counter     ),
  .out( hex1_o             )
);

dec_hex dec2(
  .in ( seconds_counter     ),
  .out( hex2_o              )
);

dec_hex dec3(
  .in ( ten_seconds_counter ),
  .out( hex3_o              )
);

endmodule