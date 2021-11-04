module sll
       (
           input [31:0] operand_a,
           input [31:0] operand_b,
           output [31:0] sll_res
       );

genvar i;

wire [31:0] sll_res_no_shift;
wire [31:0] sll_res_0;
wire [31:0] sll_res_1;
wire [31:0] sll_res_2;
wire [31:0] sll_res_3;
wire [31:0] sll_res_4;

// no shift
generate
    for (i = 0; i < 32; i = i+1)
    begin : generate_no_shift
        mux copy_paste (
                .sel(1'b0),
                .src0(operand_a[i]),
                .src1(1'b0),
                .z(sll_res_no_shift[i])
            );
    end
endgenerate

// shift starts
// operand_b[0]
mux shift_0_0 (
        .sel(operand_b[0]),
        .src0(sll_res_no_shift[0]),
        .src1(1'b0),
        .z(sll_res_0[0])
    );

generate
    for (i = 1; i < 32; i = i+1)
    begin : generate_shift_0
        mux shift_0 (
                .sel(operand_b[0]),
                .src0(sll_res_no_shift[i]),
                .src1(sll_res_no_shift[i-1]),
                .z(sll_res_0[i])
            );
    end
endgenerate

// operand_b[1]
generate
    for (i = 0; i < 2; i = i+1)
    begin : generate_shift_1_0
        mux shift_1_0 (
                .sel(operand_b[1]),
                .src0(sll_res_0[i]),
                .src1(1'b0),
                .z(sll_res_1[i])
            );
    end
endgenerate

generate
    for (i = 2; i < 32; i = i+1)
    begin : generate_shift_1
        mux shift_1 (
                .sel(operand_b[1]),
                .src0(sll_res_0[i]),
                .src1(sll_res_0[i-2]),
                .z(sll_res_1[i])
            );
    end
endgenerate

// operand_b[2]
generate
    for (i = 0; i < 4; i = i+1)
    begin : generate_shift_2_0
        mux shift_1_0 (
                .sel(operand_b[2]),
                .src0(sll_res_1[i]),
                .src1(1'b0),
                .z(sll_res_2[i])
            );
    end
endgenerate

generate
    for (i = 4; i < 32; i = i+1)
    begin : generate_shift_2
        mux shift_1 (
                .sel(operand_b[2]),
                .src0(sll_res_1[i]),
                .src1(sll_res_1[i-4]),
                .z(sll_res_2[i])
            );
    end
endgenerate

// operand_b[3]
generate
    for (i = 0; i < 8; i = i+1)
    begin : generate_shift_3_0
        mux shift_3_0 (
                .sel(operand_b[3]),
                .src0(sll_res_2[i]),
                .src1(1'b0),
                .z(sll_res_3[i])
            );
    end
endgenerate

generate
    for (i = 8; i < 32; i = i+1)
    begin : generate_shift_3
        mux shift_3 (
                .sel(operand_b[3]),
                .src0(sll_res_2[i]),
                .src1(sll_res_2[i-8]),
                .z(sll_res_3[i])
            );
    end
endgenerate

// operand_b[4]
generate
    for (i = 0; i < 16; i = i+1)
    begin : generate_shift_4_0
        mux shift_4_0 (
                .sel(operand_b[4]),
                .src0(sll_res_3[i]),
                .src1(1'b0),
                .z(sll_res[i])
            );
    end
endgenerate

generate
    for (i = 16; i < 32; i = i+1)
    begin : generate_shift_4
        mux shift_4 (
                .sel(operand_b[4]),
                .src0(sll_res_3[i]),
                .src1(sll_res_3[i-16]),
                .z(sll_res[i])
            );
    end
endgenerate

endmodule
