module shift_register4(

    input clk,
    input reset,
    input serial_in,

    output reg [3:0] Q

);

always @(posedge clk)
begin
    if(reset)
        Q <= 4'b0000;
    else
        Q <= {serial_in, Q[3], Q[2], Q[1]};
end

endmodule