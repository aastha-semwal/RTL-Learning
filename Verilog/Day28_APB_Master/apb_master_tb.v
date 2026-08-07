`timescale 1ns/1ps

module apb_master_tb;

//==============================
// Parameters
//==============================

parameter ADDR_WIDTH = 8;
parameter DATA_WIDTH = 8;

//==============================
// Testbench Signals
//==============================

reg clk;
reg reset;

reg start;
reg write;

reg [ADDR_WIDTH-1:0] address;
reg [DATA_WIDTH-1:0] write_data;

wire [DATA_WIDTH-1:0] read_data;
wire done;

wire PSEL;
wire PENABLE;
wire PWRITE;

wire [ADDR_WIDTH-1:0] PADDR;
wire [DATA_WIDTH-1:0] PWDATA;

reg [DATA_WIDTH-1:0] PRDATA;
reg PREADY;

//==============================
// DUT
//==============================

apb_master uut
(
    .clk(clk),
    .reset(reset),

    .start(start),
    .write(write),

    .address(address),
    .write_data(write_data),

    .read_data(read_data),
    .done(done),

    .PSEL(PSEL),
    .PENABLE(PENABLE),
    .PWRITE(PWRITE),

    .PADDR(PADDR),
    .PWDATA(PWDATA),

    .PRDATA(PRDATA),
    .PREADY(PREADY)
);

//==============================
// Clock Generation
//==============================

always #10 clk = ~clk;
//==============================
// VCD Dump
//==============================

initial
begin
    $dumpfile("apb_master.vcd");
    $dumpvars(0, apb_master_tb);
end
//==============================
// Test Sequence
//==============================

initial
begin

    // Initialize
    clk = 0;
    reset = 1;

    start = 0;
    write = 0;

    address = 8'h00;
    write_data = 8'h00;

    PRDATA = 8'h55;
    PREADY = 0;

    // Reset
    #20;
    reset = 0;

    //--------------------------
    // Write Transaction
    //--------------------------
    #20;
    address = 8'h10;
    write_data = 8'hA5;
    write = 1'b1;

    start = 1'b1;
    #20;
    start = 1'b0;

    #40;
    PREADY = 1'b1;

    #20;
    PREADY = 1'b0;

    //--------------------------
    // Read Transaction
    //--------------------------
    #40;

    address = 8'h20;
    write = 1'b0;
    PRDATA = 8'h5A;

    start = 1'b1;
    #20;
    start = 1'b0;

    #40;
    PREADY = 1'b1;

    #20;
    PREADY = 1'b0;

    //--------------------------
    // Finish
    //--------------------------
        #100;

    $finish;

end
//==============================
// Monitor
//==============================

initial
begin

    $monitor(
        "T=%0t START=%b WRITE=%b PSEL=%b PENABLE=%b PWRITE=%b PADDR=%h PWDATA=%h RDATA=%h DONE=%b",
        $time,
        start,
        write,
        PSEL,
        PENABLE,
        PWRITE,
        PADDR,
        PWDATA,
        read_data,
        done
    );

end

endmodule