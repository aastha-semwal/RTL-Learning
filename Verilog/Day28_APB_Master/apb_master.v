`timescale 1ns/1ps

module apb_master
#(
    parameter ADDR_WIDTH = 8,
    parameter DATA_WIDTH = 8
)
(
    input  wire clk,
    input  wire reset,

    // User Interface
    input  wire start,
    input  wire write,
    input  wire [ADDR_WIDTH-1:0] address,
    input  wire [DATA_WIDTH-1:0] write_data,

    output reg  [DATA_WIDTH-1:0] read_data,
    output reg  done,

    // APB Interface
    output reg PSEL,
    output reg PENABLE,
    output reg PWRITE,

    output reg [ADDR_WIDTH-1:0] PADDR,
    output reg [DATA_WIDTH-1:0] PWDATA,

    input wire [DATA_WIDTH-1:0] PRDATA,
    input wire PREADY
);

//==============================
// State Encoding
//==============================

parameter IDLE   = 2'b00;
parameter SETUP  = 2'b01;
parameter ACCESS = 2'b10;
parameter DONE   = 2'b11;

//==============================
// Internal Registers
//==============================

reg [1:0] state;

//==============================
// FSM
//==============================

always @(posedge clk or posedge reset)
begin

    if(reset)
    begin
        state     <= IDLE;

        PSEL      <= 1'b0;
        PENABLE   <= 1'b0;
        PWRITE    <= 1'b0;

        PADDR     <= 0;
        PWDATA    <= 0;

        read_data <= 0;
        done      <= 1'b0;
    end

    else
    begin
        case(state)

    //----------------------------------
    // IDLE
    //----------------------------------
    IDLE:
    begin

        done <= 1'b0;

        PSEL    <= 1'b0;
        PENABLE <= 1'b0;

        if(start)
        begin
            PADDR  <= address;
            PWDATA <= write_data;
            PWRITE <= write;

            state <= SETUP;
        end

    end

    //----------------------------------
    // SETUP
    //----------------------------------
    SETUP:
    begin

        PSEL    <= 1'b1;
        PENABLE <= 1'b0;

        state <= ACCESS;

    end

    //----------------------------------
    // ACCESS
    //----------------------------------
            ACCESS:
        begin

            PSEL    <= 1'b1;
            PENABLE <= 1'b1;

            if(PREADY)
            begin
                if(!PWRITE)
                    read_data <= PRDATA;

                state <= DONE;
            end

        end
            //----------------------------------
    // DONE
    //----------------------------------
    DONE:
    begin

        PSEL    <= 1'b0;
        PENABLE <= 1'b0;

        done <= 1'b1;

        state <= IDLE;

    end

    endcase

end

end
endmodule
