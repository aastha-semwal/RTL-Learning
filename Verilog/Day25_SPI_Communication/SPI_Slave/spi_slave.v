`timescale 1ns/1ps

module spi_slave
#(
    parameter DATA_WIDTH = 8
)
(
    input  wire reset,

    input  wire sclk,
    input  wire cs_n,

    input  wire mosi,
    output reg  miso,

    input  wire [DATA_WIDTH-1:0] tx_data,
    output reg [DATA_WIDTH-1:0] rx_data,

    output reg done
);

//======================================
// Registers
//======================================

reg [DATA_WIDTH-1:0] tx_shift;
reg [DATA_WIDTH-1:0] rx_shift;

reg [3:0] bit_count;

//======================================
// Load Shift Register
//======================================

always @(negedge cs_n or posedge reset)
begin
    if(reset)
    begin
        tx_shift  <= {DATA_WIDTH{1'b0}};
        rx_shift  <= {DATA_WIDTH{1'b0}};
        rx_data   <= {DATA_WIDTH{1'b0}};

        bit_count <= DATA_WIDTH;

        miso <= 1'b0;
        done <= 1'b0;
    end
    else
    begin
        tx_shift  <= tx_data;
        rx_shift  <= {DATA_WIDTH{1'b0}};

        bit_count <= DATA_WIDTH;

        done <= 1'b0;

        // First bit available before first clock
        miso <= tx_data[DATA_WIDTH-1];
    end
end
//======================================
// Receive Data (Sample MOSI)
// Rising Edge
//======================================

always @(posedge sclk or posedge reset)
begin
    if(reset)
    begin
        rx_shift  <= {DATA_WIDTH{1'b0}};
        bit_count <= DATA_WIDTH;
        done      <= 1'b0;
    end
    else if(!cs_n)
    begin
        rx_shift <= {rx_shift[DATA_WIDTH-2:0], mosi};

        if(bit_count > 0)
            bit_count <= bit_count - 1'b1;

        if(bit_count == 1)
        begin
            rx_data <= {rx_shift[DATA_WIDTH-2:0], mosi};
            done    <= 1'b1;
        end
    end
end

//======================================
// Transmit Data (Drive MISO)
// Falling Edge
//======================================

always @(negedge sclk or posedge reset)
begin
    if(reset)
    begin
        tx_shift <= {DATA_WIDTH{1'b0}};
        miso     <= 1'b0;
    end
    else if(!cs_n)
    begin
        miso <= tx_shift[DATA_WIDTH-1];
        tx_shift <= {tx_shift[DATA_WIDTH-2:0], 1'b0};
    end
end

endmodule