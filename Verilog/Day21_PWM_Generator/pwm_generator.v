module pwm_generator(

    input clk,
    input reset,
    input [7:0] duty_cycle,

    output reg pwm_out

);

// 8-bit Counter
reg [7:0] counter;

// Counter
always @(posedge clk)
begin

    if(reset)
        counter <= 8'd0;

    else
        counter <= counter + 1;

end

// PWM Logic
always @(*)
begin

    if(counter < duty_cycle)
        pwm_out = 1'b1;

    else
        pwm_out = 1'b0;

end

endmodule