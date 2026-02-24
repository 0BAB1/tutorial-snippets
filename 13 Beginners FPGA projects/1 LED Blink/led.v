`timescale 1ns / 1ps

module led(
        // 25MHz
        input wire clk,
        input wire rst_n,
        output wire led_state
    );
    
    reg [24:0] counter; 
    
    always @(posedge clk) begin
        if(~rst_n) begin
            counter <= 25'b0;
        end else begin
            counter <= counter + 1;
        end
    end
    
    assign led_state = counter[24];
    
endmodule
