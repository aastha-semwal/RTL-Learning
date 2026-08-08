`timescale 1ns/1ps

module sync_fifo_tb;
    parameter DATA_WIDTH = 8;
    parameter FIFO_DEPTH = 8;
    reg clk, reset, wr_en, rd_en;
    reg [DATA_WIDTH-1:0] wr_data;
    wire [DATA_WIDTH-1:0] rd_data;
    wire full, empty, overflow, underflow;

    // Independent reference FIFO model used to check order and status.
    reg [DATA_WIDTH-1:0] ref_mem [0:FIFO_DEPTH-1];
    integer ref_wr_ptr, ref_rd_ptr, ref_count, checks, i;

    sync_fifo #(.DATA_WIDTH(DATA_WIDTH), .FIFO_DEPTH(FIFO_DEPTH)) dut (
        .clk(clk), .reset(reset), .wr_en(wr_en), .rd_en(rd_en),
        .wr_data(wr_data), .rd_data(rd_data), .full(full), .empty(empty),
        .overflow(overflow), .underflow(underflow)
    );

    always #5 clk = ~clk;

    task fail;
        input [8*100-1:0] message;
        begin
            $display("FAIL at time %0t: %0s", $time, message);
            $fatal(1, "Synchronous FIFO self-check failed");
        end
    endtask

    task check_status;
        input expected_overflow, expected_underflow;
        begin
            checks = checks + 1;
            $display("DEBUG: time=%0t ref_count=%0d DUT_count=%0d empty=%b full=%b wr_en=%b rd_en=%b",
                $time, ref_count, dut.count, empty, full, wr_en, rd_en);
            if (full !== (ref_count == FIFO_DEPTH)) fail("full flag mismatch");
            if (empty !== (ref_count == 0)) fail("empty flag mismatch");
            if (overflow !== expected_overflow) fail("overflow pulse mismatch");
            if (underflow !== expected_underflow) fail("underflow pulse mismatch");
        end
    endtask

    // Models exactly one FIFO clock operation before comparing DUT outputs.
    task fifo_cycle;
        input request_write, request_read;
        input [DATA_WIDTH-1:0] input_data;
        reg valid_write, valid_read;
        reg [DATA_WIDTH-1:0] expected_read_data;
        begin
            @(negedge clk);
            wr_en = request_write;
            rd_en = request_read;
            wr_data = input_data;
            valid_write = request_write && (ref_count < FIFO_DEPTH);
            valid_read = request_read && (ref_count > 0);
            if (valid_read) expected_read_data = ref_mem[ref_rd_ptr];
            @(posedge clk);
            #1;
            if (valid_read && rd_data !== expected_read_data)
                fail("read data ordering mismatch");
            if (valid_write) begin
                ref_mem[ref_wr_ptr] = input_data;
                if (ref_wr_ptr == FIFO_DEPTH-1) ref_wr_ptr = 0;
                else ref_wr_ptr = ref_wr_ptr + 1;
            end
            if (valid_read) begin
                if (ref_rd_ptr == FIFO_DEPTH-1) ref_rd_ptr = 0;
                else ref_rd_ptr = ref_rd_ptr + 1;
            end
            case ({valid_write, valid_read})
                2'b10: ref_count = ref_count + 1;
                2'b01: ref_count = ref_count - 1;
                default: ref_count = ref_count;
            endcase
            check_status(request_write && !valid_write, request_read && !valid_read);
        end
    endtask

    initial begin
        clk = 0; reset = 1; wr_en = 0; rd_en = 0; wr_data = 0;
        ref_wr_ptr = 0; ref_rd_ptr = 0; ref_count = 0; checks = 0;
        $dumpfile("fifo.vcd");
        $dumpvars(0, sync_fifo_tb);

        repeat (2) @(posedge clk);
        #1;
        if (empty !== 1'b1 || full !== 1'b0 || overflow !== 1'b0 || underflow !== 1'b0)
            fail("synchronous reset status mismatch");
        $display("PASS: reset and empty FIFO behavior");
        reset = 0;

        $display("Testing normal write/read ordering...");
        fifo_cycle(1, 0, 8'h11); fifo_cycle(1, 0, 8'h22); fifo_cycle(1, 0, 8'h33);
        fifo_cycle(0, 1, 0); fifo_cycle(0, 1, 0); fifo_cycle(0, 1, 0);
        $display("PASS: normal FIFO ordering");

        $display("Testing full flag and overflow protection...");
        for (i = 0; i < FIFO_DEPTH; i = i + 1) fifo_cycle(1, 0, 8'h80 + i);
        if (full !== 1'b1) fail("FIFO did not become full");
        fifo_cycle(1, 0, 8'hFF);
        for (i = 0; i < FIFO_DEPTH; i = i + 1) fifo_cycle(0, 1, 0);
        $display("PASS: full flag and overflow protection");

        $display("Testing empty flag and underflow protection...");
        if (empty !== 1'b1) fail("FIFO did not become empty");
        fifo_cycle(0, 1, 0);
        $display("PASS: empty flag and underflow protection");

        $display("Testing simultaneous read/write...");
        fifo_cycle(1, 0, 8'hA1); fifo_cycle(1, 0, 8'hA2);
        fifo_cycle(1, 1, 8'hB1);
        fifo_cycle(0, 1, 0); fifo_cycle(0, 1, 0);
        $display("PASS: simultaneous read/write keeps occupancy correct");

        $display("Testing pointer wraparound and FIFO ordering...");
        for (i = 0; i < 5; i = i + 1) fifo_cycle(1, 0, 8'hC0 + i);
        for (i = 0; i < 3; i = i + 1) fifo_cycle(0, 1, 0);
        for (i = 5; i < FIFO_DEPTH + 2; i = i + 1) fifo_cycle(1, 0, 8'hC0 + i);
        while (ref_count > 0) fifo_cycle(0, 1, 0);
        $display("PASS: pointer wraparound preserves FIFO ordering");

        @(negedge clk); wr_en = 0; rd_en = 0;
        $display("===============================================");
        $display("ALL SYNCHRONOUS FIFO TESTS PASSED (%0d checks)", checks);
        $display("===============================================");
        $finish;
    end
endmodule
