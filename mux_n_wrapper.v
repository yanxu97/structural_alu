module mux_n_wrapper #(parameter n = 32)
       (
           input sel,
           input [n-1:0] src0,
           input [n-1:0] src1,
           output [n-1:0] z
       );

mux_n #(.n(n)) mux_n_lib (
           .sel({n{sel}}),
           .src0(src0),
           .src1(src1),
           .z(z)
       );

endmodule
