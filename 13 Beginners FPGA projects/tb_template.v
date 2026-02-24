`timescale 1ns/1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 02/17/2026 12:07:57 PM
// Design Name: 
// Module Name: tb 
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

// just a shitty tb template in raw verilog, just enough to explore waveforms.
// no need for complicated assertions (I'm trash at raw verilog testbenches anyway lol)

module tb;

    parameter CLK_PERIOD  = 10;   // 100 MHz
    parameter NUM_CYCLES  = 25000;

    reg clk;
    reg reset;

    // gen a clock
    initial clk = 0;
    always #(CLK_PERIOD/2.0) clk = ~clk;

    // reset
    initial begin
        reset = 1;
        repeat (10) @(posedge clk);
        reset = 0;
    end

    // block design (top DUT)
    design_1_wrapper dut(
        .sys_clock(clk),
        .reset(reset)
    );

    // run
    initial begin
        repeat (NUM_CYCLES) @(posedge clk);
        $finish;
    end

endmodule
