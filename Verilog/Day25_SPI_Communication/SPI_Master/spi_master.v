`timescale 1ns/1ps

module spi_master
#(
    parameter DATA_WIDTH = 8,
    parameter CLK_DIV    = 4
)
(
    input  wire clk,
    input  wire reset,

    input  wire start,
    input  wire [DATA_WIDTH-1:0] tx_data,

    input  wire miso,

    output reg mosi,
    output reg sclk,
    output reg cs_n,

    output reg busy,
    output reg done,

    output reg [DATA_WIDTH-1:0] rx_data
);

//======================================
// State Encoding
//======================================

localparam IDLE     = 2'd0;
localparam LOAD     = 2'd1;
localparam TRANSFER = 2'd2;
localparam FINISH   = 2'd3;

//======================================
// Registers
//======================================

reg [1:0] state;

reg [DATA_WIDTH-1:0] tx_shift;
reg [DATA_WIDTH-1:0] rx_shift;

reg [3:0] bit_count;

reg [15:0] clk_div_cnt;

wire tick;

// Clock divider tick
assign tick = (clk_div_cnt == (CLK_DIV-1));

//======================================
// Clock Divider
//======================================

always @(posedge clk or posedge reset)
begin
    if(reset)
    begin
        clk_div_cnt <= 16'd0;
    end
    else if(busy)
    begin
        if(tick)
            clk_div_cnt <= 16'd0;
        else
            clk_div_cnt <= clk_div_cnt + 16'd1;
    end
    else
    begin
        clk_div_cnt <= 16'd0;
    end
end
//======================================
// SPI Master FSM
//======================================

always @(posedge clk or posedge reset)
begin
    if(reset)
    begin
        state     <= IDLE;

        tx_shift  <= {DATA_WIDTH{1'b0}};
        rx_shift  <= {DATA_WIDTH{1'b0}};
        rx_data   <= {DATA_WIDTH{1'b0}};

        bit_count <= 4'd0;

        mosi <= 1'b0;
        sclk <= 1'b0;
        cs_n <= 1'b1;

        busy <= 1'b0;
        done <= 1'b0;
    end
    else
    begin

        done <= 1'b0;

        case(state)

        //----------------------------------
        // IDLE
        //----------------------------------
        IDLE:
        begin
            busy <= 1'b0;
            cs_n <= 1'b1;
            sclk <= 1'b0;

            if(start)
                state <= LOAD;
        end

        //----------------------------------
        // LOAD
        //----------------------------------
        LOAD:
        begin
            tx_shift  <= tx_data;
            rx_shift  <= {DATA_WIDTH{1'b0}};

            bit_count <= DATA_WIDTH;

            busy <= 1'b1;
            cs_n <= 1'b0;
            sclk <= 1'b0;

            state <= TRANSFER;
        end

        //----------------------------------
        // TRANSFER
        //----------------------------------
        TRANSFER:
        begin
            if(tick)
            begin
                sclk <= ~sclk;

                if(sclk == 1'b0)
                begin
                    mosi <= tx_shift[DATA_WIDTH-1];
                    tx_shift <= {tx_shift[DATA_WIDTH-2:0],1'b0};
                end
                else
                begin
                    rx_shift <= {rx_shift[DATA_WIDTH-2:0],miso};

                    if(bit_count > 0)
                        bit_count <= bit_count - 1'b1;

                    if(bit_count == 1)
                    begin
                        rx_data <= {rx_shift[DATA_WIDTH-2:0],miso};
                        state <= FINISH;
                    end
                end
            end
        end

        //----------------------------------
        // FINISH
        //----------------------------------
        FINISH:
        begin
            busy <= 1'b0;
            done <= 1'b1;

            cs_n <= 1'b1;
            sclk <= 1'b0;

            state <= IDLE;
        end

        //----------------------------------
        // DEFAULT
        //----------------------------------
        default:
        begin
            state <= IDLE;
        end

        endcase
    end
end

endmodule