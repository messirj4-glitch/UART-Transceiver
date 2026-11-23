
module uart_rx #(
    parameter CLKS_PER_BIT = 10417
)(
    input wire clk,
    input wire rst,
    input wire rx,
    output reg [7:0] rx_data,
    output reg rx_done,
    output reg rx_error
);

    localparam IDLE  = 2'b00;
    localparam START = 2'b01;
    localparam DATA  = 2'b10;
    localparam STOP  = 2'b11;

    reg [1:0] state;
    reg [13:0] clk_count;
    reg [2:0] bit_index;
    reg [7:0] data_reg;

    reg rx_sync1, rx_sync2;

    always @(posedge clk) begin
        if (rst) begin
            rx_sync1 <= 1'b1;
            rx_sync2 <= 1'b1;
        end
        else begin
            rx_sync1 <= rx;
            rx_sync2 <= rx_sync1;
        end
    end

    always @(posedge clk) begin
        if (rst) begin
            state <= IDLE;
            clk_count <= 0;
            bit_index <= 0;
            data_reg <= 0;
            rx_data <= 0;
            rx_done <= 0;
            rx_error <= 0;
        end
        else begin
            rx_done <= 0;
            rx_error <= 0;

            case (state)

                IDLE: begin
                    clk_count <= 0;

                    if (rx_sync2 == 0)
                        state <= START;
                end

                START: begin
                    if (clk_count == (CLKS_PER_BIT / 2)) begin
                        clk_count <= 0;

                        if (rx_sync2 == 0) begin
                            bit_index <= 0;
                            state <= DATA;
                        end
                        else
                            state <= IDLE;
                    end
                    else
                        clk_count <= clk_count + 1;
                end

                DATA: begin
                    if (clk_count < CLKS_PER_BIT - 1)
                        clk_count <= clk_count + 1;
                    else begin
                        clk_count <= 0;
                        data_reg[bit_index] <= rx_sync2;

                        if (bit_index < 7)
                            bit_index <= bit_index + 1;
                        else
                            state <= STOP;
                    end
                end

                STOP: begin
                    if (clk_count < CLKS_PER_BIT - 1)
                        clk_count <= clk_count + 1;
                    else begin
                        clk_count <= 0;

                        if (rx_sync2 == 1'b1) begin
                            rx_data <= data_reg;
                            rx_done <= 1;
                        end
                        else
                            rx_error <= 1;

                        state <= IDLE;
                    end
                end

            endcase
        end
    end

endmodule
