module and_gate(y, a, b);

input a, b;
output y;

xnor g1(y, a, b);

endmodule