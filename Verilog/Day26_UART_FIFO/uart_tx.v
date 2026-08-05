`timescale 1ns/1ps

module uart_tx
#(
    parameter DATA_BITS = 8
)
(
    input  wire clk,
    input  wire reset,

    input  wire baud_tick,

    input  wire tx_start,
    input  wire [DATA_BITS-1:0] tx_data,

    output reg tx,
    output reg busy
);

//=====================================
// State Encoding
//=====================================

localparam IDLE  = 2'd0;
localparam START = 2'd1;
localparam DATA  = 2'd2;
localparam STOP  = 2'd3;

//=====================================
// Registers
//=====================================

reg [1:0] state;

reg [DATA_BITS-1:0] shift_reg;

reg [3:0] bit_count;
//=====================================
// UART TX FSM
//=====================================

always @(posedge clk or posedge reset)
begin
    if (reset)
    begin
        state     <= IDLE;
        tx        <= 1'b1;
        busy      <= 1'b0;
        shift_reg <= {DATA_BITS{1'b0}};
        bit_count <= 4'd0;
    end
    else
    begin
        case(state)

        //---------------------------------
        // IDLE
        //---------------------------------
        IDLE:
        begin
            tx   <= 1'b1;
            busy <= 1'b0;

            if(tx_start)
            begin
                shift_reg <= tx_data;
                bit_count <= 4'd0;
                busy <= 1'b1;
                state <= START;
            end
        end

        //---------------------------------
        // START BIT
        //---------------------------------
        START:
        begin
            if(baud_tick)
            begin
                tx <= 1'b0;
                state <= DATA;
            end
        end

        //---------------------------------
        // DATA BITS
        //---------------------------------
        DATA:
        begin
            if(baud_tick)
            begin
                tx <= shift_reg[0];
                shift_reg <= shift_reg >> 1;

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
                tx <= 1'b1;
                busy <= 1'b0;
                state <= IDLE;
            end
        end

        default:
            state <= IDLE;

        endcase
    end
end

endmodule