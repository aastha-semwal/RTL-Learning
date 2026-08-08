`timescale 1ns/1ps

// FIFO_DEPTH must be a power of two and at least 2. The pointer width and
// natural pointer wraparound rely on this assumption.
module sync_fifo #(
    parameter DATA_WIDTH = 8,
    parameter FIFO_DEPTH = 8
) (
    input wire clk, input wire reset,
    input wire wr_en, input wire rd_en,
    input wire [DATA_WIDTH-1:0] wr_data,
    output reg [DATA_WIDTH-1:0] rd_data,
    output wire full, output wire empty,
    output reg overflow, output reg underflow
);
    localparam FIFO_DEPTH_IS_VALID = (FIFO_DEPTH >= 2) &&
                                     ((FIFO_DEPTH & (FIFO_DEPTH - 1)) == 0);
    localparam PTR_WIDTH = $clog2(FIFO_DEPTH);

    // This elaboration-time guard rejects unsupported parameter values without
    // adding non-synthesizable logic to a valid FIFO configuration.
    generate
        if (!FIFO_DEPTH_IS_VALID) begin : g_invalid_fifo_depth
            INVALID_FIFO_DEPTH_MUST_BE_POWER_OF_TWO invalid_fifo_depth();
        end
    endgenerate
    reg [DATA_WIDTH-1:0] mem [0:FIFO_DEPTH-1];
    reg [PTR_WIDTH-1:0] wr_ptr, rd_ptr;
    reg [PTR_WIDTH:0] count;
    wire do_write = wr_en && !full;
    wire do_read  = rd_en && !empty;

    assign full  = (count == FIFO_DEPTH);
    assign empty = (count == 0);

    always @(posedge clk) begin
        if (reset) begin
            wr_ptr <= {PTR_WIDTH{1'b0}};
            rd_ptr <= {PTR_WIDTH{1'b0}};
            count <= {(PTR_WIDTH+1){1'b0}};
            rd_data <= {DATA_WIDTH{1'b0}};
            overflow <= 1'b0;
            underflow <= 1'b0;
        end else begin
            overflow <= wr_en && full;
            underflow <= rd_en && empty;
            if (do_write) begin
                mem[wr_ptr] <= wr_data;
                wr_ptr <= wr_ptr + 1'b1;
            end
            if (do_read) begin
                rd_data <= mem[rd_ptr];
                rd_ptr <= rd_ptr + 1'b1;
            end
            case ({do_write, do_read})
                2'b10: count <= count + 1'b1;
                2'b01: count <= count - 1'b1;
                default: count <= count;
            endcase
        end
    end
endmodule
