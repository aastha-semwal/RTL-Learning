module register4bit(

    input clk,
    input reset,
    input [3:0] D,

    output reg [3:0] Q

);

always @(posedge clk)
begin
    if(reset)
        Q <= 4'b0000;
    else
        Q <= D;
end

endmodule