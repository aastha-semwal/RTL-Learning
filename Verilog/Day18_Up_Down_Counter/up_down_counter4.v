module up_down_counter4(

    input clk,
    input reset,
    input up_down,

    output reg [3:0] Q

);

always @(posedge clk)
begin

    if(reset)
        Q <= 4'b0000;

    else if(up_down)
        Q <= Q + 1;

    else
        Q <= Q - 1;

end

endmodule