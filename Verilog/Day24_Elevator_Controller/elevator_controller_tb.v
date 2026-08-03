`timescale 1ns/1ps

module elevator_controller_tb;

reg clk;
reg reset;
reg [1:0] request_floor;

wire [1:0] current_floor;
wire moving_up;
wire moving_down;
wire door_open;

// DUT
elevator_controller uut(

    .clk(clk),
    .reset(reset),
    .request_floor(request_floor),

    .current_floor(current_floor),

    .moving_up(moving_up),
    .moving_down(moving_down),
    .door_open(door_open)

);

// Clock Generation
always #5 clk = ~clk;

initial
begin

    $dumpfile("elevator_controller.vcd");
    $dumpvars(0, elevator_controller_tb);

    $monitor("Time=%0t Reset=%b Req=%d Floor=%d UP=%b DOWN=%b DOOR=%b",
             $time,
             reset,
             request_floor,
             current_floor,
             moving_up,
             moving_down,
             door_open);

    clk = 0;
    reset = 1;
    request_floor = 0;

    #20;
    reset = 0;

    //-------------------------
    // Move to Floor 3
    //-------------------------

    request_floor = 3;

    #120;
        //-------------------------
    // Move to Floor 1
    //-------------------------

    request_floor = 1;

    #120;

    //-------------------------
    // Stay on Floor 1
    //-------------------------

    request_floor = 1;

    #80;

    //-------------------------
    // Move to Floor 0
    //-------------------------

    request_floor = 0;

    #120;

    //-------------------------
    // Move to Floor 2
    //-------------------------

    request_floor = 2;

    #120;

    $finish;

end

endmodule