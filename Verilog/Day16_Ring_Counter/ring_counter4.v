module ring_counter4(

    input clk,
    input reset,

    output reg [3:0] Q

);

always @(posedge clk)
begin

    if(reset)
        Q <= 4'b0001;

    else
        Q <= {Q[2:0], Q[3]};

end

endmodule