module universal_shift_register(

    input clk,
    input reset,

    input [1:0] mode,

    input serial_left,
    input serial_right,

    input [3:0] D,

    output reg [3:0] Q

);

always @(posedge clk)
begin

    if(reset)
        Q <= 4'b0000;

    else
    begin

        case(mode)

            // Hold
            2'b00 :
                Q <= Q;

            // Shift Right
            2'b01 :
                Q <= {serial_right, Q[3], Q[2], Q[1]};

            // Shift Left
            2'b10 :
                Q <= {Q[2], Q[1], Q[0], serial_left};

            // Parallel Load
            2'b11 :
                Q <= D;

            default :
                Q <= Q;

        endcase

    end

end

endmodule