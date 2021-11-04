module mux_32_wrapper
       (
           input sel,
           input [31:0] src0,
           input [31:0] src1,
           output [31:0] z
       );

mux_32 mux_32_lib (
           .sel({31'b0, sel}),
           .src0(src0),
           .src1(src1),
           .z(z)
       );

endmodule
