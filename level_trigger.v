module level_triggered_data_shift (
    input wire clk,        // Fast system clock
    output reg sclk,       // Serial clock (slower derived from clk)
    output reg sda         // Data line
);

    reg [7:0] data = 8'b1010_1101;  // Data to shift out
    reg [3:0] bit_cnt = 0;
    reg [7:0] clk_div = 0;
    reg state = 0; // 0: low level of sclk, 1: high level of sclk

    // Clock divider to generate slower sclk
    always @(posedge clk) begin
        clk_div <= clk_div + 1;

        // Toggle sclk every 50 system clocks (adjust as needed)
        if (clk_div == 50) begin
            clk_div <= 0;
            sclk <= ~sclk;

            state <= ~state;

            // On falling edge of sclk (just entered low level)
            if (~state) begin
                // Change sda in the **middle** of the low level
                sda <= data[7 - bit_cnt];
            end
            // On rising edge (just entered high level)
            else begin
                bit_cnt <= bit_cnt + 1;
                if (bit_cnt == 7)
                    bit_cnt <= 0; // wrap around for demo
            end
        end
    end

endmodule
