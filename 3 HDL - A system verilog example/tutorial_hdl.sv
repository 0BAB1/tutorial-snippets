`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 07/20/2024 11:42:12 AM
// Design Name: 
// Module Name: tutorial_hdl
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


module tutorial_hdl(
        input logic sw1,
        input logic sw2,
        // (* clock_buffer_type="none" *)  ===> deal with the fact btn is not an actual clock
        (* clock_buffer_type="none" *) input logic btn,
        output logic led_out
    );

    always @(posedge btn) begin
        led_out <= sw1 & sw2;
    end
endmodule
