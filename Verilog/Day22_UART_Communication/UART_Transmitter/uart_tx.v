module uart_tx(

    input clk,
    input reset,
    input tx_start,
    input [7:0] tx_data,

    output reg tx,
    output reg busy

);

// State Encoding
parameter IDLE = 2'b00;
parameter LOAD = 2'b01;
parameter TRANSMIT = 2'b10;
parameter DONE = 2'b11;

// Internal Registers
reg [1:0] state;
reg [3:0] bit_count;
reg [9:0] shift_reg;

always @(posedge clk)
begin

    if(reset)
    begin
        state <= IDLE;
        tx <= 1'b1;
        busy <= 1'b0;
        bit_count <= 4'd0;
        shift_reg <= 10'd0;
    end

    else
    begin

        case(state)

            IDLE:
            begin
                tx <= 1'b1;
                busy <= 1'b0;

                if(tx_start)
                    state <= LOAD;
            end

            LOAD:
            begin
                busy <= 1'b1;
                shift_reg <= {1'b1, tx_data, 1'b0};
                bit_count <= 4'd0;
                state <= TRANSMIT;
            end

            TRANSMIT:
            begin
                tx <= shift_reg[0];
                shift_reg <= shift_reg >> 1;
                bit_count <= bit_count + 1;

                if(bit_count == 9)
                    state <= DONE;
            end

            DONE:
            begin
                tx <= 1'b1;
                busy <= 1'b0;
                state <= IDLE;
            end

        endcase

    end

end

endmodule