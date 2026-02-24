// probably the worst piece of music you'll ever hear.
// revolves arouns a unecessary detailled state machine below.
//
// brh

`timescale 1ns / 1ps

module music #(
    parameter FREQ = 25000000
) (
    // 25MHz input clock
    input wire clk,
    input wire rst_n,
    output reg toggle_speaker
);

    // Objective : play "Au clair de la lune"
    // Notes :
    // C
    // C
    // C
    // D
    // E
    // D
    // C
    // E
    // D 
    // D
    // C

    // FREQUENCIES
    localparam C_FREQ = 130; //Hz
    localparam D_FREQ = 146; //Hz
    localparam E_FREQ = 155; //Hz

    // HALF PERIOD CYCLES
    localparam C_HALF_CYLCLES = FREQ / C_FREQ / 2;
    localparam D_HALF_CYLCLES = FREQ / D_FREQ / 2;
    localparam E_HALF_CYLCLES = FREQ / E_FREQ / 2;

    // Current playing note state
    reg [3:0]   current_note;
    // each note should last ~0.5sec
    reg [24:0]  note_timer;


    // NOTES SELECTION AND TIMERS LOGIC
    always @(posedge clk) begin
        if(~rst_n)begin
            current_note <= 0;
            note_timer <= 0;
        end else begin
            note_timer <= note_timer + 1;

            if(note_timer[24]) begin
                note_timer <= 0;
                current_note <= current_note + 1;
            end
        end
    end

    // OUTPUT SPEAKER TOGGLE LOGIC DEPENDING ON CURRENT NOTE
    reg [18:0] frequency_counter;

    always @(posedge clk) begin
        if(~rst_n)begin
            frequency_counter <= 0;
            toggle_speaker <= 0;
        end else begin
            toggle_speaker <= toggle_speaker;
            case (current_note)
                // C
                4'b0000: begin
                    frequency_counter <= frequency_counter + 1;
                    if(frequency_counter > C_HALF_CYLCLES) begin
                        toggle_speaker <= ~toggle_speaker;
                        frequency_counter <= 0; 
                    end
                end
                // C
                4'b0001: begin
                    frequency_counter <= frequency_counter + 1;
                    if(frequency_counter > C_HALF_CYLCLES) begin
                        toggle_speaker <= ~toggle_speaker;
                        frequency_counter <= 0; 
                    end
                end
                // C
                4'b0010: begin
                    frequency_counter <= frequency_counter + 1;
                    if(frequency_counter > C_HALF_CYLCLES) begin
                        toggle_speaker <= ~toggle_speaker;
                        frequency_counter <= 0; 
                    end
                end
                // D
                4'b0011: begin
                    frequency_counter <= frequency_counter + 1;
                    if(frequency_counter > D_HALF_CYLCLES) begin
                        toggle_speaker <= ~toggle_speaker;
                        frequency_counter <= 0; 
                    end
                end
                // E
                4'b0100: begin
                    frequency_counter <= frequency_counter + 1;
                    if(frequency_counter > E_HALF_CYLCLES) begin
                        toggle_speaker <= ~toggle_speaker;
                        frequency_counter <= 0; 
                    end
                end
                // D
                4'b0101: begin
                    frequency_counter <= frequency_counter + 1;
                    if(frequency_counter > D_HALF_CYLCLES) begin
                        toggle_speaker <= ~toggle_speaker;
                        frequency_counter <= 0; 
                    end
                end
                // C
                4'b0110: begin
                    frequency_counter <= frequency_counter + 1;
                    if(frequency_counter > C_HALF_CYLCLES) begin
                        toggle_speaker <= ~toggle_speaker;
                        frequency_counter <= 0; 
                    end
                end
                // E
                4'b0111: begin
                    frequency_counter <= frequency_counter + 1;
                    if(frequency_counter > E_HALF_CYLCLES) begin
                        toggle_speaker <= ~toggle_speaker;
                        frequency_counter <= 0; 
                    end
                end
                // D
                4'b1000: begin
                    frequency_counter <= frequency_counter + 1;
                    if(frequency_counter > D_HALF_CYLCLES) begin
                        toggle_speaker <= ~toggle_speaker;
                        frequency_counter <= 0; 
                    end
                end
                // D
                4'b1001: begin
                    frequency_counter <= frequency_counter + 1;
                    if(frequency_counter > D_HALF_CYLCLES) begin
                        toggle_speaker <= ~toggle_speaker;
                        frequency_counter <= 0; 
                    end
                end
                // C
                4'b1010: begin
                    frequency_counter <= frequency_counter + 1;
                    if(frequency_counter > C_HALF_CYLCLES) begin
                        toggle_speaker <= ~toggle_speaker;
                        frequency_counter <= 0; 
                    end
                end
                
                default: begin
                    // play C by default
                    frequency_counter <= frequency_counter + 1;
                    if(frequency_counter > C_HALF_CYLCLES) begin
                        toggle_speaker <= ~toggle_speaker;
                        frequency_counter <= 0; 
                    end
                end
            endcase
        end
    end

endmodule
