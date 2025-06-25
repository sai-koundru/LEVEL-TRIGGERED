`timescale 1ns/1ps

module tb_level_trigger;

    reg clk;
    wire sclk;
    wire sda;

    level_trigger dut ( .clk(clk), .sclk(sclk), .sda(sda) );

    initial 
        begin
            clk = 0;
            forever #5 clk = ~clk;
        end

    initial 
        begin
          #2000;  
          $finish;
        end

endmodule
