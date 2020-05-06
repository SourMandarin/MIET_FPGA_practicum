`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 06.05.2020 15:14:33
// Design Name: 
// Module Name: counter
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


module counter(

    input        clk100_i,
    input        rstn_i,
    input  [9:0] sw_i,
    input  [1:0] key_i,
    output [9:0] ledr_o,
    output [6:0] hex0_o,
    output [6:0] hex1_o
    
    );
    
reg  [9:0] q       = 10'b0;  
reg  [7:0] counter = 8'd0 ;

always @ ( posedge clk100_i ) begin				
    if  ( key_i[1] ) begin
        q = 10'b0;
        counter = 8'd0;
    end
    else if ( key_i[0] ) begin
            q = sw_i;
            counter = counter +1;
         end
end

assign ledr_o = q;

dec_hex dec0
( .in(counter[7:4]),
  .OUT(hex0_o)    );

dec_hex dec1
( .in(counter[3:0]),
  .OUT(hex1_o)    );
  
endmodule
