`timescale 1ns/1ps

module alu4bit_tb;

reg [3:0] A;
reg [3:0] B;
reg [2:0] OP;

wire [3:0] Y;

alu4bit uut(
    .A(A),
    .B(B),
    .OP(OP),
    .Y(Y)
);

initial begin

    $monitor("Time=%0t A=%b B=%b OP=%b Y=%b",
             $time, A, B, OP, Y);

    A = 4'b0101;
    B = 4'b0011;

    OP = 3'b000;  // ADD
    #10;

    OP = 3'b001;  // SUB
    #10;

    OP = 3'b010;  // AND
    #10;

    OP = 3'b011;  // OR
    #10;

    OP = 3'b100;  // XOR
    #10;

    OP = 3'b101;  // NOT A
    #10;

    OP = 3'b110;  // Default case
    #10;

    $finish;

end

endmodule