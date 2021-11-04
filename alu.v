module alu
       (
           input [31:0] operand_a,
           input [31:0] operand_b,
           input [3:0] control,
           output carryout,
           output overflow,
           output zero,
           output [31:0] result
       );

// arithmetic: add, sub
// logical: and, xor, or, sll, srl
// conditional: slt, sltu

// add
wire add_carry_out, add_overflow;
wire [31:0] add_res;
// sub
wire add_flip_bit_out, add_flip_bit_overflow;
wire sub_carry_out, sub_carry_out_1, sub_overflow;
wire [31:0] add_flip_bit_res;
wire [31:0] not_operand_b, sub_res;
// and
wire [31:0] and_res;
// xor
wire [31:0] xor_res;
// or
wire [31:0] or_res;
// sll
wire [31:0] sll_res;
// slr_res
wire [31:0] slr_res;
// slt_res
wire [31:0] slt_res;
// sltu_res
wire [31:0] sltu_res;

// decode
wire [15:0] option_onehot;

// add: carry_sel adder
add_32 add_ins (
           .operand_a(operand_a),
           .operand_b(operand_b),
           .carry_out(add_carry_out),
           .overflow(add_overflow),
           .sum(add_res)
       );

// sub:
xor_gate_32 flip_bit (
                .x(operand_b),
                .y({32{1'b1}}),
                .z(not_operand_b)
            );
add_32 add_flip_bit (
           .operand_a(not_operand_b),
           .operand_b(32'b1),
           .carry_out(add_flip_bit_out),
           .overflow(add_flip_bit_overflow),
           .sum(add_flip_bit_res)
       );
add_32 sub_ins (
           .operand_a(operand_a),
           .operand_b(add_flip_bit_res),
           .carry_out(sub_carry_out_1),
           .overflow(sub_overflow),
           .sum(sub_res)
       );

// and:
and_gate_32 and_ins (
                .x(operand_a),
                .y(operand_b),
                .z(and_res)
            );

// xor:
xor_gate_32 xor_ins (
                .x(operand_a),
                .y(operand_b),
                .z(xor_res)
            );

// or:
or_gate_32 or_ins (
               .x(operand_a),
               .y(operand_b),
               .z(or_res)
           );

// sll:
sll sll_ins (
        .operand_a(operand_a),
        .operand_b(operand_b),
        .sll_res(sll_res)
    );

// slr:
slr slr_ins (
        .operand_a(operand_a),
        .operand_b(operand_b),
        .slr_res(slr_res)
    );

// slt:
slt slt_ins (
        .operand_a(operand_a),
        .operand_b(operand_b),
        .slt_res(slt_res)
    );

// sltu:
sltu sltu_ins (
         .operand_a(operand_a),
         .operand_b(operand_b),
         .sltu_res(sltu_res)
     );

// decode
// 0000  add
// 0001  sub
// 0010  and
// 0011  xor
// 0100  or
// 0101  sll
// 0110  srl
// 0111  slt
// 1000  sltu

mux16_to_1 deliver_res (
               .control(control),
               .a(add_res),
               .b(sub_res),
               .c(and_res),
               .d(xor_res),
               .e(or_res),
               .f(sll_res),
               .g(slr_res),
               .h(slt_res),
               .i(sltu_res),
               .j(32'b0),
               .k(32'b0),
               .l(32'b0),
               .m(32'b0),
               .n(32'b0),
               .o(32'b0),
               .p(32'b0),
               .z(result)
           );

// mux select_carry_out (
//         .sel(control[0]),
//         .src0(add_carry_out),
//         .src1(sub_carry_out),
//         .z(carryout)
//     );

or_gate carry_out (
    .x(sub_carry_out_1),
    .y(slt_res[0]),
    .z(sub_carry_out)
);

mux16_to_1 #(.SIZE(1)) select_carry_out (
               .control(control),
               .a(add_carry_out),
               .b(sub_carry_out),
               .c(1'b0),
               .d(1'b0),
               .e(1'b0),
               .f(1'b0),
               .g(1'b0),
               .h(1'b0),
               .i(1'b0),
               .j(1'b0),
               .k(1'b0),
               .l(1'b0),
               .m(1'b0),
               .n(1'b0),
               .o(1'b0),
               .p(1'b0),
               .z(carryout)
           );

mux16_to_1 #(.SIZE(1)) select_overflow (
               .control(control),
               .a(add_overflow),
               .b(sub_overflow),
               .c(1'b0),
               .d(1'b0),
               .e(1'b0),
               .f(1'b0),
               .g(1'b0),
               .h(1'b0),
               .i(1'b0),
               .j(1'b0),
               .k(1'b0),
               .l(1'b0),
               .m(1'b0),
               .n(1'b0),
               .o(1'b0),
               .p(1'b0),
               .z(overflow)
           );

check_zero get_zero_bit (
               .a(result),
               .z(zero)
           );

endmodule
