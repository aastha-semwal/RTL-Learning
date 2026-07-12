module inverter(Q, A);

input A;
output Q;

supply1 vdd;
supply0 vss;

pmos p(Q, vdd, A);
nmos n(Q, vss, A);

endmodule