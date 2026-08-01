`timescale 1ns/1ps

module uart_rx(

    input clk,
    input reset,
    input rx,

    output reg [7:0] rx_data,
    output reg data_ready

);

// State Encoding
parameter IDLE      = 2'b00;
parameter RECEIVE   = 2'b01;
parameter DONE      = 2'b10;

// Internal Registers
reg [1:0] state;
reg [3:0] bit_count;
reg [7:0] shift_reg;

always @(posedge clk)
begin

    if(reset)
    begin
        state <= IDLE;
        bit_count <= 0;
        shift_reg <= 0;
        rx_data <= 0;
        data_ready <= 0;
    end

    else
    begin

        case(state)

            IDLE:
            begin
                data_ready <= 0;

                if(rx == 0)
                begin
                    bit_count <= 0;
                    state <= RECEIVE;
                end
            end

            RECEIVE:
            begin

                shift_reg[bit_count] <= rx;
                bit_count <= bit_count + 1;

                if(bit_count == 7)
                    state <= DONE;

            end

            DONE:
            begin

                rx_data <= shift_reg;
                data_ready <= 1;
                state <= IDLE;

            end

        endcase

    end

end

endmodule