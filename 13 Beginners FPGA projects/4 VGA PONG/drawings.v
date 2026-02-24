`timescale 1ns / 1ps

module drawing #(
        parameter pad_height = 60,
        parameter pad_width = 15,
        parameter pad_x = 50,
        parameter screen_width = 640,
        parameter screen_height = 480,
        parameter ball_size  = 8,
        // FIXED
        parameter px_ctn_width = 10     
    )(
        input inDisplayArea,
        input [px_ctn_width-1:0] x,
        input [px_ctn_width-1:0] y,
        input [9:0] pad_y,
        input [9:0] ball_x,
        input [9:0] ball_y,
        output reg r,
        output reg g,
        output reg b
    );

    assign inPad =  (x > pad_x - (pad_width/2)) && (x <  pad_x + (pad_width/2))
                    &&
                    (y > pad_y - (pad_height/2)) && (y <  pad_y + (pad_height/2));   

    assign inBall = (x > ball_x - (ball_size/2)) && (x <  ball_x + (ball_size/2))
                    &&
                    (y > ball_y - (ball_size/2)) && (y <  ball_y + (ball_size/2));        
          
    always @(*)
        begin
            if (inDisplayArea) begin
                r <= inPad || inBall ? 1'b1 : 1'b0;
                g <= 1'b1;
                b <= inPad || inBall ? 1'b0 : 1'b1 ;
            end else begin
                r <= 1'b0;
                g <= 1'b0;
                b <= 1'b0;
            end
        end

endmodule
