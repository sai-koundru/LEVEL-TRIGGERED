`timescale 1ns/1ps

module tb_level_triggered_data_shift;

    reg clk;
    wire sclk;
    wire sda;

    // Instantiate the DUT (Design Under Test)
    level_timed_data_shift dut (
        .clk(clk),
        .sclk(sclk),
        .sda(sda)
    );

    // Generate system clock (10ns period = 100MHz)
    initial begin
        clk = 0;
        forever #5 clk = ~clk;
    end

    // Run simulation
    initial begin
        $dumpfile("waveform.vcd");  // For GTKWave
        $dumpvars(0, tb_level_timed_data_shift);

        #2000;  // Run simulation long enough to view several bits
        $finish;
    end

endmodule
