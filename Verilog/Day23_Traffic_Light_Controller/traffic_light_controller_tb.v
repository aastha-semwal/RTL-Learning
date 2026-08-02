`timescale 1ns/1ps

module traffic_light_controller_tb;

reg clk;
reg reset;
reg pedestrian;
reg emergency;

wire red;
wire yellow;
wire green;

// DUT

traffic_light_controller uut(

    .clk(clk),
    .reset(reset),
    .pedestrian(pedestrian),
    .emergency(emergency),

    .red(red),
    .yellow(yellow),
    .green(green)

);

// Clock Generation

always #5 clk = ~clk;

initial
begin

    $dumpfile("traffic_light_controller.vcd");
    $dumpvars(0, traffic_light_controller_tb);

    $monitor("Time=%0t Reset=%b Ped=%b Emg=%b RED=%b YELLOW=%b GREEN=%b",
             $time,
             reset,
             pedestrian,
             emergency,
             red,
             yellow,
             green);

    clk = 0;
    reset = 1;
    pedestrian = 0;
    emergency = 0;

    #20;
    reset = 0;

    // Normal Traffic
    #120;
    // Pedestrian Request
    pedestrian = 1;
    #10;
    pedestrian = 0;

    #120;

    // Emergency Vehicle
    emergency = 1;

    #60;

    emergency = 0;

    #120;

    // Pedestrian + Emergency Together
    pedestrian = 1;
    #10;
    pedestrian = 0;

    #30;

    emergency = 1;

    #50;

    emergency = 0;

    #120;

    $finish;

end

endmodule
