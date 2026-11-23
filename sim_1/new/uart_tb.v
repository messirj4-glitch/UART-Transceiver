
`timescale 1ns / 1ps

module uart_tb;

    reg clk;
    reg rst;
    reg tx_start;
    reg [7:0] tx_data;

    wire uart_txd;
    wire tx_busy;
    wire tx_done;

    wire [7:0] rx_data;
    wire rx_done;
    wire rx_error;

    uart_top #(
        .CLKS_PER_BIT(16)
    ) uut (
        .clk(clk),
        .rst(rst),
        .tx_start(tx_start),
        .tx_data(tx_data),
        .uart_rxd(uart_txd),
        .uart_txd(uart_txd),
        .tx_busy(tx_busy),
        .tx_done(tx_done),
        .rx_data(rx_data),
        .rx_done(rx_done),
        .rx_error(rx_error)
    );

    always #5 clk = ~clk;

    initial begin
        clk = 0;
        rst = 1;
        tx_start = 0;
        tx_data = 8'h00;

        #100;
        rst = 0;

        #50;
        tx_data = 8'hA5;
        tx_start = 1;

        #10;
        tx_start = 0;

        wait(rx_done);

        #20;

        $display("Transmitted Data = %h", tx_data);
        $display("Received Data    = %h", rx_data);

        if (rx_data == tx_data)
            $display("TEST PASSED");
        else
            $display("TEST FAILED");

        #100;
        $finish;
    end

endmodule
