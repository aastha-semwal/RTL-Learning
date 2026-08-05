`timescale 1ns/1ps

module baud_gen
#(
    parameter CLK_FREQ  = 50000000,
    parameter BAUD_RATE = 9600
)
(
    input  wire clk,
    input  wire reset,

    output reg baud_tick
);

//=====================================
// Local Parameters
//=====================================

localparam integer BAUD_DIV = CLK_FREQ / BAUD_RATE;

//=====================================
// Registers
//=====================================

reg [31:0] counter;
always @(posedge clk or posedge reset)
begin
    if (reset)
    begin
        counter   <= 32'd0;
        baud_tick <= 1'b0;
    end
    else
    begin
        if (counter == BAUD_DIV-1)
        begin
            counter   <= 32'd0;
            baud_tick <= 1'b1;
        end
        else
        begin
            counter   <= counter + 1'b1;
            baud_tick <= 1'b0;
        end
    end
end

endmodule