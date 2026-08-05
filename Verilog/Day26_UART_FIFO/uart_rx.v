`timescale 1ns/1ps

module uart_rx
#(
    parameter DATA_BITS = 8
)
(
    input  wire clk,
    input  wire reset,

    input  wire baud_tick,

    input  wire rx,

    output reg [DATA_BITS-1:0] rx_data,
    output reg data_ready
);

//=====================================
// State Encoding
//=====================================

localparam IDLE  = 2'd0;
localparam DATA  = 2'd1;
localparam STOP  = 2'd2;

//=====================================
// Registers
//=====================================

reg [1:0] state;

reg [DATA_BITS-1:0] shift_reg;

reg [3:0] bit_count;
//=====================================
// UART RX FSM
//=====================================

always @(posedge clk or posedge reset)
begin
    if (reset)
    begin
        state      <= IDLE;
        shift_reg  <= {DATA_BITS{1'b0}};
        bit_count  <= 4'd0;
        rx_data    <= {DATA_BITS{1'b0}};
        data_ready <= 1'b0;
    end
    else
    begin

        data_ready <= 1'b0;

        case(state)

        //---------------------------------
        // IDLE
        //---------------------------------
        IDLE:
        begin
            if(rx == 1'b0)
            begin
                bit_count <= 4'd0;
                state <= DATA;
            end
        end

        //---------------------------------
        // RECEIVE DATA
        //---------------------------------
        DATA:
        begin
            if(baud_tick)
            begin
                shift_reg[bit_count] <= rx;

                if(bit_count == DATA_BITS-1)
                    state <= STOP;
                else
                    bit_count <= bit_count + 1'b1;
            end
        end

        //---------------------------------
        // STOP BIT
        //---------------------------------
        STOP:
        begin
            if(baud_tick)
            begin
                rx_data    <= shift_reg;
                data_ready <= 1'b1;
                state      <= IDLE;
            end
        end

        default:
            state <= IDLE;

        endcase
    end
end

endmodule