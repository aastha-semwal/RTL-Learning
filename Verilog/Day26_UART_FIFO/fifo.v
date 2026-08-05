`timescale 1ns/1ps

module fifo
#(
    parameter DATA_WIDTH = 8,
    parameter DEPTH      = 8
)
(
    input  wire clk,
    input  wire reset,

    input  wire wr_en,
    input  wire rd_en,

    input  wire [DATA_WIDTH-1:0] data_in,
    output reg  [DATA_WIDTH-1:0] data_out,

    output wire full,
    output wire empty
);

//=====================================
// Internal Memory
//=====================================

reg [DATA_WIDTH-1:0] mem [0:DEPTH-1];

reg [2:0] wr_ptr;
reg [2:0] rd_ptr;
reg [3:0] count;

//=====================================
// Status Flags
//=====================================

assign full  = (count == DEPTH);
assign empty = (count == 0);

//=====================================
// FIFO Logic
//=====================================

always @(posedge clk or posedge reset)
begin
    if(reset)
    begin
        wr_ptr   <= 0;
        rd_ptr   <= 0;
        count    <= 0;
        data_out <= 0;
    end
    else
    begin

        //-----------------------------
        // Write
        //-----------------------------
        if(wr_en && !full)
        begin
            mem[wr_ptr] <= data_in;
            wr_ptr <= wr_ptr + 1'b1;
            count  <= count + 1'b1;
        end

        //-----------------------------
        // Read
        //-----------------------------
        if(rd_en && !empty)
        begin
            data_out <= mem[rd_ptr];
            rd_ptr   <= rd_ptr + 1'b1;
            count    <= count - 1'b1;
        end

    end
end

endmodule