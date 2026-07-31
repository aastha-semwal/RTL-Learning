module pwm_generator(

    input clk,
    input reset,
    input [7:0] duty_cycle,

    output reg pwm_out

);

reg [7:0] counter;

always @(posedge clk)
begin

    if(reset)
    begin
        counter <= 8'd0;
        pwm_out <= 1'b0;
    end

    else
    begin
        counter <= counter + 1;

        if(counter < duty_cycle)
            pwm_out <= 1'b1;
        else
            pwm_out <= 1'b0;
    end

end

endmodule