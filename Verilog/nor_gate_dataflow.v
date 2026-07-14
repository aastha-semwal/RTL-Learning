module nor_gate_dataflow(

input a,
input b,

output y

);

assign y = ~(a | b);

endmodule