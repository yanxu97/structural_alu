module slr
       (
           input [31:0] operand_a,
           input [31:0] operand_b,
           output [31:0] slr_res
       );

genvar i;

wire [31:0] slr_res_no_shift;
wire [31:0] slr_res_0;
wire [31:0] slr_res_1;
wire [31:0] slr_res_2;
wire [31:0] slr_res_3;
wire [31:0] slr_res_4;

// no shift
generate
    for (i = 0; i < 32; i = i+1)
    begin : generate_no_shift
        mux copy_paste (
                .sel(1'b0),
                .src0(operand_a[i]),
                .src1(1'b0),
                .z(slr_res_no_shift[i])
            );
    end
endgenerate

// shift starts
// operand_b[0]
mux shift_0_0 (
        .sel(operand_b[0]),
        .src0(slr_res_no_shift[31]),
        .src1(1'b0),
        .z(slr_res_0[31])
    );

generate
    for (i = 30; i >= 0; i = i-1)
    begin : generate_shift_0
        mux shift_0 (
                .sel(operand_b[0]),
                .src0(slr_res_no_shift[i]),
                .src1(slr_res_no_shift[i+1]),
                .z(slr_res_0[i])
            );
    end
endgenerate

// operand_b[1]
generate
    for (i = 31; i > 29; i = i-1)
    begin : generate_shift_1_0
        mux shift_1_0 (
                .sel(operand_b[1]),
                .src0(slr_res_0[i]),
                .src1(1'b0),
                .z(slr_res_1[i])
            );
    end
endgenerate

generate
    for (i = 29; i >= 0; i = i-1)
    begin : generate_shift_1
        mux shift_1 (
                .sel(operand_b[1]),
                .src0(slr_res_0[i]),
                .src1(slr_res_0[i+2]),
                .z(slr_res_1[i])
            );
    end
endgenerate

// operand_b[2]
generate
    for (i = 31; i > 27; i = i-1)
    begin : generate_shift_2_0
        mux shift_1_0 (
                .sel(operand_b[2]),
                .src0(slr_res_1[i]),
                .src1(1'b0),
                .z(slr_res_2[i])
            );
    end
endgenerate

generate
    for (i = 27; i >= 0; i = i-1)
    begin : generate_shift_2
        mux shift_1 (
                .sel(operand_b[2]),
                .src0(slr_res_1[i]),
                .src1(slr_res_1[i+4]),
                .z(slr_res_2[i])
            );
    end
endgenerate

// operand_b[3]
generate
    for (i = 31; i > 23; i = i-1)
    begin : generate_shift_3_0
        mux shift_3_0 (
                .sel(operand_b[3]),
                .src0(slr_res_2[i]),
                .src1(1'b0),
                .z(slr_res_3[i])
            );
    end
endgenerate

generate
    for (i = 23; i >= 0; i = i-1)
    begin : generate_shift_3
        mux shift_3 (
                .sel(operand_b[3]),
                .src0(slr_res_2[i]),
                .src1(slr_res_2[i+8]),
                .z(slr_res_3[i])
            );
    end
endgenerate

// operand_b[4]
generate
    for (i = 31; i > 15; i = i-1)
    begin : generate_shift_4_0
        mux shift_4_0 (
                .sel(operand_b[4]),
                .src0(slr_res_3[i]),
                .src1(1'b0),
                .z(slr_res[i])
            );
    end
endgenerate

generate
    for (i = 15; i >= 0; i = i-1)
    begin : generate_shift_4
        mux shift_4 (
                .sel(operand_b[4]),
                .src0(slr_res_3[i]),
                .src1(slr_res_3[i+16]),
                .z(slr_res[i])
            );
    end
endgenerate

endmodule
