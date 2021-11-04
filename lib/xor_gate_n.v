module xor_gate_n (x, y, z);
parameter n=4;
input [n-1:0] x;
input [n-1:0] y;
output [n-1:0] z;

assign z = (x^y) ;


endmodule





