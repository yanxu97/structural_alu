module mux16_to_1 #(parameter SIZE = 32)
       (
           input [3:0] control,
           input [SIZE-1:0] a,
           input [SIZE-1:0] b,
           input [SIZE-1:0] c,
           input [SIZE-1:0] d,
           input [SIZE-1:0] e,
           input [SIZE-1:0] f,
           input [SIZE-1:0] g,
           input [SIZE-1:0] h,
           input [SIZE-1:0] i,
           input [SIZE-1:0] j,
           input [SIZE-1:0] k,
           input [SIZE-1:0] l,
           input [SIZE-1:0] m,
           input [SIZE-1:0] n,
           input [SIZE-1:0] o,
           input [SIZE-1:0] p,
           output [SIZE-1:0] z
       );

wire [SIZE-1:0] mux_1_0_res;
wire [SIZE-1:0] mux_1_1_res;
wire [SIZE-1:0] mux_1_2_res;
wire [SIZE-1:0] mux_1_3_res;
wire [SIZE-1:0] mux_1_4_res;
wire [SIZE-1:0] mux_1_5_res;
wire [SIZE-1:0] mux_1_6_res;
wire [SIZE-1:0] mux_1_7_res;

wire [SIZE-1:0] mux_2_0_res;
wire [SIZE-1:0] mux_2_1_res;
wire [SIZE-1:0] mux_2_2_res;
wire [SIZE-1:0] mux_2_3_res;

wire [SIZE-1:0] mux_3_0_res;
wire [SIZE-1:0] mux_3_1_res;

// get 8
mux_32_wrapper mux_1_0 (
           .sel(control[0]),
           .src0(a),
           .src1(b),
           .z(mux_1_0_res)
       );
mux_32_wrapper mux_1_1 (
           .sel(control[0]),
           .src0(c),
           .src1(d),
           .z(mux_1_1_res)
       );
mux_32_wrapper mux_1_2 (
           .sel(control[0]),
           .src0(e),
           .src1(f),
           .z(mux_1_2_res)
       );
mux_32_wrapper mux_1_3 (
           .sel(control[0]),
           .src0(g),
           .src1(h),
           .z(mux_1_3_res)
       );
mux_32_wrapper mux_1_4 (
           .sel(control[0]),
           .src0(i),
           .src1(j),
           .z(mux_1_4_res)
       );
mux_32_wrapper mux_1_5 (
           .sel(control[0]),
           .src0(k),
           .src1(l),
           .z(mux_1_5_res)
       );
mux_32_wrapper mux_1_6 (
           .sel(control[0]),
           .src0(m),
           .src1(n),
           .z(mux_1_6_res)
       );
mux_32_wrapper mux_1_7 (
           .sel(control[0]),
           .src0(o),
           .src1(p),
           .z(mux_1_7_res)
       );

// get 4
mux_32_wrapper mux_2_0 (
           .sel(control[1]),
           .src0(mux_1_0_res),
           .src1(mux_1_1_res),
           .z(mux_2_0_res)
       );
mux_32_wrapper mux_2_1 (
           .sel(control[1]),
           .src0(mux_1_2_res),
           .src1(mux_1_3_res),
           .z(mux_2_1_res)
       );
mux_32_wrapper mux_2_2 (
           .sel(control[1]),
           .src0(mux_1_4_res),
           .src1(mux_1_5_res),
           .z(mux_2_2_res)
       );
mux_32_wrapper mux_2_3 (
           .sel(control[1]),
           .src0(mux_1_6_res),
           .src1(mux_1_7_res),
           .z(mux_2_3_res)
       );

// get 2
mux_32_wrapper mux_3_0 (
           .sel(control[2]),
           .src0(mux_2_0_res),
           .src1(mux_2_1_res),
           .z(mux_3_0_res)
       );
mux_32_wrapper mux_3_1 (
           .sel(control[2]),
           .src0(mux_2_2_res),
           .src1(mux_2_3_res),
           .z(mux_3_1_res)
       );

// get 1
mux_32_wrapper mux_4_0 (
           .sel(control[3]),
           .src0(mux_3_0_res),
           .src1(mux_3_1_res),
           .z(z)
       );

endmodule
