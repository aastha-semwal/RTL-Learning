`timescale 1ns/1ps

module i2c_master
(
    input wire clk,
    input wire reset,

    input wire start,

    input wire [6:0] slave_addr,
    input wire rw,

    output reg scl,
    output reg sda,

    output reg busy,
    output reg done
);

//=====================================
// State Encoding
//=====================================

parameter IDLE      = 3'd0;
parameter START     = 3'd1;
parameter ADDRESS   = 3'd2;
parameter ACK       = 3'd3;
parameter STOP      = 3'd4;
parameter FINISH    = 3'd5;

//=====================================
// Registers
//=====================================

reg [2:0] state;

reg [3:0] bit_count;

reg [7:0] shift_reg;

//=====================================
// FSM
//=====================================

always @(posedge clk or posedge reset)
begin

    if(reset)
    begin
        state     <= IDLE;
        scl       <= 1'b1;
        sda       <= 1'b1;
        busy      <= 1'b0;
        done      <= 1'b0;
        bit_count <= 4'd0;
        shift_reg <= 8'd0;
    end

    else
    begin

        case(state)

        //---------------------------------
        // IDLE
        //---------------------------------

        IDLE:
        begin
            scl  <= 1'b1;
            sda  <= 1'b1;
            busy <= 1'b0;
            done <= 1'b0;

            if(start)
            begin
                busy      <= 1'b1;
                shift_reg <= {slave_addr, rw};
                state     <= START;
            end
        end

        //---------------------------------
        // START Condition
        //---------------------------------

        START:
        begin
            sda <= 1'b0;
            scl <= 1'b1;

            bit_count <= 4'd7;

            state <= ADDRESS;
        end

        //---------------------------------
        // ADDRESS Transmission
        //---------------------------------

        ADDRESS:
        begin
            scl <= 1'b0;
            sda <= shift_reg[bit_count];

            scl <= 1'b1;

            if(bit_count == 0)
                state <= ACK;
            else
                bit_count <= bit_count - 1'b1;
        end

        //---------------------------------
        // ACK State
        //---------------------------------

        ACK:
        begin
            state <= STOP;
        end

        //---------------------------------
        // STOP Condition
        //---------------------------------

        STOP:
        begin
            scl <= 1'b1;
            sda <= 1'b1;

            state <= FINISH;
        end

        //---------------------------------
        // FINISH
        //---------------------------------

        FINISH:
        begin
            busy <= 1'b0;
            done <= 1'b1;

            state <= IDLE;
        end

        default:
            state <= IDLE;

        endcase

    end

end

endmodule