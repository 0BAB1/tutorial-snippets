// A harwadwired UART TX sender
//
// brh

module uart_tx_hello (
    input wire clk,        // 25 MHz clock
    input wire reset,      // Active high reset
    output reg tx          // UART TX line
);

    // UART parameters
    parameter BAUD_RATE = 115200;
    parameter CLK_FREQ = 25_000_000;
    parameter CLKS_PER_BIT = CLK_FREQ / BAUD_RATE;
    
    // Message to send: "hello world\r\n"
    // we hardcode it here, nothing too fancy,
    // to focus on the protocols states
    parameter MSG_LEN = 13;
    reg [7:0] message [0:MSG_LEN-1];
    
    initial begin
        message[0]  = "h";
        message[1]  = "e";
        message[2]  = "l";
        message[3]  = "l";
        message[4]  = "o";
        message[5]  = " ";
        message[6]  = "w";
        message[7]  = "o";
        message[8]  = "r";
        message[9]  = "l";
        message[10] = "d";
        message[11] = 8'h0D; // \r
        message[12] = 8'h0A; // \n
    end
    
    // https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTviWK7KOkWKGd8Tjn5hc-vWR4UyKjOajtscg&s
    // UART is about 2 wires: RX and TX, both respect the same protocol:
    // @BAUD RATE Frequencies, we first send a start bit (1->0 transition)
    // so the chip on the other side knows data is comming
    // Then we start sending a single BYTE of data (8bits)
    // After that, we signal its's over with a stop bit (1)
    // each of these steps will be a state in our circuitery.
    // we declare these state below.
    // State machine
    localparam IDLE       = 3'd0;
    localparam START_BIT  = 3'd1;
    localparam DATA_BITS  = 3'd2;
    localparam STOP_BIT   = 3'd3;
    localparam DELAY      = 3'd4;
    
    reg [2:0] state;
    reg [2:0] bit_index;
    reg [3:0] char_index;
    reg [7:0] current_byte;
    reg [19:0] delay_counter;

    // clk counter is used to send at the right baud rate.
    // you may know that UART devices have to be setlled on the same baud rate, which is declared above as a parameter.
    // we also computed CLKS_PER_BIT, which will serve as a compaator whith a counter, once this value is reached, that
    // means a baud has been reached, and we can transition state / send next bit (if we are in "send_data" state)
    // It's just like the previous clock divders you did in the previous projects ;)
    reg [15:0] clk_counter;
    
    // Initialize everything
    initial begin
        state = IDLE;
        tx = 1'b1;
        clk_counter = 0;
        bit_index = 0;
        char_index = 0;
        current_byte = 0;
        delay_counter = 0;
    end
    
    always @(posedge clk) begin
        if (reset) begin
            state <= IDLE;
            tx <= 1'b1;
            clk_counter <= 0;
            bit_index <= 0;
            char_index <= 0;
            delay_counter <= 0;
            current_byte <= 0;
        end
        else begin
            case (state)
                IDLE: begin
                    tx <= 1'b1; // line is high by defaut when in IDLE
                    bit_index <= 0;
                    
                    if (char_index < MSG_LEN) begin
                        current_byte <= message[char_index];
                        clk_counter <= 0;
                        state <= START_BIT;
                    end
                    else begin
                        char_index <= 0;
                        delay_counter <= 0;
                        state <= DELAY; // Small delay before repeating
                    end
                end
                
                START_BIT: begin
                    tx <= 1'b0; // Start bit is low
                    
                    if (clk_counter < CLKS_PER_BIT - 1) begin
                        clk_counter <= clk_counter + 1;
                        state <= START_BIT;
                    end
                    else begin
                        clk_counter <= 0;
                        bit_index <= 0;
                        state <= DATA_BITS;
                    end
                end
                
                DATA_BITS: begin
                    tx <= current_byte[bit_index];
                    
                    if (clk_counter < CLKS_PER_BIT - 1) begin
                        clk_counter <= clk_counter + 1;
                        state <= DATA_BITS;
                    end
                    else begin
                        clk_counter <= 0;
                        
                        if (bit_index < 7) begin
                            bit_index <= bit_index + 1;
                            state <= DATA_BITS;
                        end
                        else begin
                            state <= STOP_BIT;
                        end
                    end
                end
                
                STOP_BIT: begin
                    tx <= 1'b1; // Stop bit is high
                    
                    if (clk_counter < CLKS_PER_BIT - 1) begin
                        clk_counter <= clk_counter + 1;
                        state <= STOP_BIT;
                    end
                    else begin
                        clk_counter <= 0;
                        char_index <= char_index + 1;
                        state <= IDLE;
                    end
                end
                
                DELAY: begin
                    tx <= 1'b1;
                    // Short delay between messages (about 50ms at 25MHz)
                    if (delay_counter < 1_250_000) begin
                        delay_counter <= delay_counter + 1;
                        state <= DELAY;
                    end
                    else begin
                        delay_counter <= 0;
                        state <= IDLE;
                    end
                end
                
                default: begin
                    state <= IDLE;
                    tx <= 1'b1;
                end
            endcase
        end
    end

endmodule