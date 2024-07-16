`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 07/10/2024 06:40:48 PM
// Design Name: 
// Module Name: led_axi_ip
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


module led_axi_ip(
        input wire [31:0] slv_reg,
        input wire clk,
        output reg led_out
    );

    // CHANGES TO MY CODE

    always @(posedge clk) begin
        if(slv_reg[0] == 1) begin
            led_out <= 1;
        end else begin
            led_out <= 0;
        end
    end

endmodule
