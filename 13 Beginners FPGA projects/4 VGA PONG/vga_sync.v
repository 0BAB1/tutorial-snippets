`timescale 1ns / 1ps

// Actual drwing zone : 640x480px
// balayage total : 800x525px

// misc : HOR / VER
// front porch : 16 / 10
// back porch : 48 / 33
// sync width : 96 / 2

// practical ordering :
// ACTIVE / FRONT PORCH / SYNC / BACK PORCH

// Role of VGA SYNC : Gen x,y coords + sync signals
// Also generates a flag inDisplayArea indicating if we are currently in
// drawing area
// x and y will be used by "drawings.v" module, along side game state, to toggle colors
// where necessary, thus drawing the elements (pong pad and ball)

module vga_sync #(
        parameter hpixels = 800, 
        parameter vlines = 525,
        parameter hpulse = 96,
        parameter vpulse = 2, 
        parameter hbp = 48,
        parameter hfp = 16,
        parameter vbp = 33,
        parameter vfp = 10,
        // FIXED
        parameter px_ctn_width = 10     
    )(
        // input clk for 60hz : 25.2MHz
        input clk,
        input rst_n,
        output wire [px_ctn_width-1:0] x,
        output wire [px_ctn_width-1:0] y,
        output inDisplayArea,
        output hsync,
        output vsync
    );


    // Keep track of current pixel
    reg [px_ctn_width-1:0] counter_x;
    reg [px_ctn_width-1:0] counter_y;

    always @(posedge clk) begin
        if(~rst_n)begin
            counter_x <= 0;
            counter_y <= 0;
        end 
        else begin
            // count pixels
            if(counter_x < hpixels -1)begin
                counter_x <= counter_x + 1;
            end
            // go to next line when x is done
            // also same logic for y
            else begin
                counter_x <= 0;
                if(counter_y < vlines - 1) begin
                    counter_y <= counter_y + 1;
                end else begin
                    counter_y <= 0;
                end
            end
        end
    end

    // generate hsync high IF not in HSYNC range
    // which satarts @ total px - backp - sync width
    // and end @ total px - backp
    assign hsync = ~(counter_x >= (hpixels - hbp - hpulse) && counter_x < (hpixels - hbp));
    assign vsync = ~(counter_y >= (vlines - vbp - vpulse) && counter_y < (vlines - vbp));

    // generate inDisplayArea flag
    assign inDisplayArea = counter_x < (hpixels - hbp - hpulse - hfp) && counter_y < (vlines - vbp - vpulse - vfp);

    assign x = counter_x;
    assign y = counter_y;

endmodule
