`timescale 1ns/1ps

module pwm_generator_tb;

reg clk;
reg reset;
reg [7:0] duty_cycle;

wire pwm_out;

// DUT
pwm_generator uut(

    .clk(clk),
    .reset(reset),
    .duty_cycle(duty_cycle),
    .pwm_out(pwm_out)

);

// Clock Generation
always #5 clk = ~clk;

initial
begin

    $dumpfile("pwm_generator.vcd");
    $dumpvars(0, pwm_generator_tb);

    $monitor("Time=%0t Reset=%b Duty=%d PWM=%b",
              $time, reset, duty_cycle, pwm_out);

    clk = 0;
    reset = 1;
    duty_cycle = 8'd64;     // 25%

    @(posedge clk);
    reset = 0;

    repeat(260)
        @(posedge clk);

    duty_cycle = 8'd128;    // 50%

    repeat(260)
        @(posedge clk);

    duty_cycle = 8'd192;    // 75%

    repeat(260)
        @(posedge clk);

    duty_cycle = 8'd255;    // 100%

    repeat(260)
        @(posedge clk);

    duty_cycle = 8'd0;      // 0%

    repeat(260)
        @(posedge clk);

    $finish;

end

endmodule