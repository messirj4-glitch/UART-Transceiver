
module uart_top #(
    parameter CLKS_PER_BIT = 10417
)(
    input wire clk,
    input wire rst,

    input wire tx_start,
    input wire [7:0] tx_data,

    input wire uart_rxd,
    output wire uart_txd,

    output wire tx_busy,
    output wire tx_done,

    output wire [7:0] rx_data,
    output wire rx_done,
    output wire rx_error
);

    uart_tx #(
        .CLKS_PER_BIT(CLKS_PER_BIT)
    ) transmitter (
        .clk(clk),
        .rst(rst),
        .tx_start(tx_start),
        .tx_data(tx_data),
        .tx(uart_txd),
        .tx_busy(tx_busy),
        .tx_done(tx_done)
    );

    uart_rx #(
        .CLKS_PER_BIT(CLKS_PER_BIT)
    ) receiver (
        .clk(clk),
        .rst(rst),
        .rx(uart_rxd),
        .rx_data(rx_data),
        .rx_done(rx_done),
        .rx_error(rx_error)
    );

endmodule
