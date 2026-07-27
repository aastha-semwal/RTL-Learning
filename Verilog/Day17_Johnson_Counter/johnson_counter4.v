module johnson_counter4(

    input clk,
    input reset,

    output reg [3:0] Q

);

always @(posedge clk)
begin

    if(reset)
        Q <= 4'b0000;

    else
        Q <= {~Q[0], Q[3:1]};

end

endmodule