

`timescale 1ns / 1ps

// game_state generator
// Grabs user inputs (buttons), detect the rising edge and
// outputs a pad_y state from that.
// Also internally generates a slower game_clock to automatically
// update the ball state.
//
// These varying states info are passed to actually put colors where pad & ball
// states are. Note that some vars like "pad_x" are constant so they are hardcoded
// inside drawings.v, there is no need to generates these constants here.

module game_state #(
        parameter SCREEN_W   = 640,
        parameter SCREEN_H   = 480,
        parameter BALL_SIZE  = 8,
        parameter PAD_X      = 50,
        parameter PAD_W      = 15,
        parameter PAD_H      = 60
    )(
        input clk,
        input rst_n, 
        input btn_up,
        input btn_down,
        output reg [9:0] ball_x,
        output reg [9:0] ball_y,
        output reg [9:0] pad_y
    );

    // Slow game clock
    // just like with buttons, we detect its rising edge to update ball states
    reg [20:0] game_clock_counter;
    reg game_tick_d;
    wire game_tick_rise;

    always @(posedge clk) begin
        if(~rst_n)
            game_clock_counter <= 0;
        else
            game_clock_counter <= game_clock_counter + 1;
    end

    wire game_tick = game_clock_counter[20];

    always @(posedge clk) begin
        if(~rst_n)
            game_tick_d <= 0;
        else
            game_tick_d <= game_tick;
    end

    assign game_tick_rise = game_tick & ~game_tick_d;

    //--------------------------------------------------
    // Ball velocity (signed)
    //--------------------------------------------------
    reg signed [9:0] ball_dx;
    reg signed [9:0] ball_dy;

    //--------------------------------------------------
    // Ball movement + collision (update only on game clock)
    //--------------------------------------------------
    always @(posedge clk) begin
        if(~rst_n) begin
            ball_x <= 200;
            ball_y <= 200;
            ball_dx <= 3;
            ball_dy <= 2;
        end else if (game_tick_rise) begin

            // Wall collision up
            if ((ball_y <= 15) && (ball_dy < 0))
                ball_dy <= -ball_dy;

            // Wall collision down
            if ((ball_y + BALL_SIZE >= SCREEN_H) && (ball_dy > 0))
                ball_dy <= -ball_dy;

            // Right wall collision
            if ((ball_x + BALL_SIZE >= SCREEN_W) && (ball_dx > 0))
                ball_dx <= -ball_dx;

            // pad collision (left side)
            if ((ball_x <= PAD_X + PAD_W/2 &&
                ball_x >= PAD_X - PAD_W/2 &&
                ball_y + BALL_SIZE >= pad_y - PAD_H/2 &&
                ball_y <= pad_y + PAD_H/2) && (ball_dx < 0))
                ball_dx <= -ball_dx;

            // Left wall (missed pad so reset)
            if (ball_x <= 15) begin
                ball_x <= 200;
                ball_y <= 200;
                ball_dx <= 3;
                ball_dy <= 2;
            end else begin
                ball_x <= ball_x + ball_dx;
                ball_y <= ball_y + ball_dy;
            end
        end
    end

    //--------------------------------------------------
    // Button edge detection (still synchronous to clk)
    //--------------------------------------------------
    wire btn_up_pulse, btn_down_pulse;
    reg btn_up_prev, btn_down_prev;

    assign btn_up_pulse   = btn_up & ~btn_up_prev;
    assign btn_down_pulse = btn_down & ~btn_down_prev;

    always @(posedge clk) begin
        if(~rst_n) begin
            pad_y <= 100;
            btn_up_prev <= 0;
            btn_down_prev <= 0;
        end else begin
            btn_up_prev <= btn_up;
            btn_down_prev <= btn_down;

            if(btn_down_pulse)
                pad_y <= pad_y + 10;
            else if(btn_up_pulse)
                pad_y <= pad_y - 10;
        end
    end

endmodule