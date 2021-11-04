module check_zero
       (
           input [31:0] a,
           output z
       );

genvar i;

wire [15:0] res_0;
wire [7:0] res_1;
wire [3:0] res_2;
wire [1:0] res_3;

// get 16
generate
    for (i = 0; i < 16; i = i+1)
    begin : generate_and_0
        or_gate or_0 (
                     .x(a[2*i]),
                     .y(a[2*i+1]),
                     .z(res_0[i])
                 );
    end
endgenerate

// get 8
generate
    for (i = 0; i < 8; i = i+1)
    begin : generate_and_1
        or_gate or_1 (
                     .x(res_0[2*i]),
                     .y(res_0[2*i+1]),
                     .z(res_1[i])
                 );
    end
endgenerate

// get 4
generate
    for (i = 0; i < 4; i = i+1)
    begin : generate_and_2
        or_gate or_2 (
                     .x(res_1[2*i]),
                     .y(res_1[2*i+1]),
                     .z(res_2[i])
                 );
    end
endgenerate

// get 2
generate
    for (i = 0; i < 2; i = i+1)
    begin : generate_and_3
        or_gate or_3 (
                     .x(res_2[2*i]),
                     .y(res_2[2*i+1]),
                     .z(res_3[i])
                 );
    end
endgenerate

// get 1
nor_gate nor_1 (
             .x(res_3[0]),
             .y(res_3[1]),
             .z(z)
         );

endmodule
