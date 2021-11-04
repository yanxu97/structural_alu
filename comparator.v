module comparator
       (
           input x,
           input y,
           output z
       );

wire n_y;
wire and_2_res;

xor_gate flip_bit_y (
                .x(y),
                .y(1'b1),
                .z(n_y)
            );

and_gate and_1 (
             .x(x),
             .y(n_y),
             .z(z)
         );


endmodule
