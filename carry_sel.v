module carry_sel_32
       (
           input [32-1:0] a,
           input [32-1:0] b,
           input carry_in,
           output carry_out,
           output overflow,
           output [32-1:0] sum
       );

genvar i;

wire [32-1:0] temp_sum_0, temp_sum_1;
wire [32/4-1:0] temp_carry_out_0, temp_carry_out_1;
wire [32/4-1:0] temp_sel;

//initial block
fulladder_4 initial_block(
                .a(a[3:0]),
                .b(b[3:0]),
                .carry_in(carry_in),
                .sum(temp_sum_0[3:0]),
                .carry_out(temp_sel[0])
            );

// prepare for some bits
// assign sum[3:0] = temp_sum_0[3:0];
or_gate_n #(.n(4)) sum_lsb4 (
              .x(4'b0),
              .y(temp_sum_0[3:0]),
              .z(sum[3:0])
          );

// assign temp_sum_1[3:0] = temp_sum_0[3:0];
or_gate_n #(.n(4)) temp_sum_1_lsb4 (
              .x(4'b0),
              .y(temp_sum_0[3:0]),
              .z(temp_sum_1[3:0])
          );

// assign temp_carry_out_0[0] = temp_sel[0];
or_gate temp_carry_out_0_lsb1 (
            .x(1'b0),
            .y(temp_sel[0]),
            .z(temp_carry_out_0[0])
        );

// assign temp_carry_out_1[0] = temp_sel[0];
or_gate temp_carry_out_1_lsb1 (
            .x(1'b0),
            .y(temp_sel[0]),
            .z(temp_carry_out_1[0])
        );

// // assign temp_sel[7] = 1'b0;
// or_gate temp_sel_msb1 (
//     .x(1'b0),
//     .y(1'b0),
//     .z(temp_sel[7])
// );

// assume initial carry_in is 0
generate
    for (i = 1; i < 32/4; i = i+1)
    begin : generate_carry_in_0
        fulladder_4 fulladder_carry_in_0 (
                        .a(a[i*4+3:i*4]),
                        .b(b[i*4+3:i*4]),
                        .carry_in(1'b0),
                        .sum(temp_sum_0[i*4+3:i*4]),
                        .carry_out(temp_carry_out_0[i])
                    );
    end
endgenerate

// assume initial carry_in is 1
generate
    for (i = 1; i < 32/4; i = i+1)
    begin : generate_carry_in_1
        fulladder_4 fulladder_carry_in_1 (
                        .a(a[i*4+3:i*4]),
                        .b(b[i*4+3:i*4]),
                        .carry_in(1'b1),
                        .sum(temp_sum_1[i*4+3:i*4]),
                        .carry_out(temp_carry_out_1[i])
                    );
    end
endgenerate

// choose partial sum between temp_sum_0 and temp_sum_1
generate
    for (i = 1; i < 32/4; i = i+1)
    begin : generate_sum
        // mux_n #(.n(4)) mux_4 (
        //           .sel({3'b0,temp_sel[i-1]}),
        //           .src0(temp_sum_0[i*4+3:i*4]),
        //           .src1(temp_sum_1[i*4+3:i*4]),
        //           .z(sum[i*4+3:i*4])
        //       );

        mux_n_wrapper #(.n(4)) mux_4 (
                          .sel(temp_sel[i-1]),
                          .src0(temp_sum_0[i*4+3:i*4]),
                          .src1(temp_sum_1[i*4+3:i*4]),
                          .z(sum[i*4+3:i*4])
                      );

        mux selector (
                .sel(temp_sel[i-1]),
                .src0(temp_carry_out_0[i]),
                .src1(temp_carry_out_1[i]),
                .z(temp_sel[i])
            );
    end
endgenerate

// assign output signals
assign carry_out = temp_sel[7];

xor_gate detect_overflow (
             .x(temp_sel[7]),
             .y(temp_sel[6]),
             .z(overflow)
         );

endmodule
