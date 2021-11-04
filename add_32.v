module add_32
       (
           input [31:0] operand_a,
           input [31:0] operand_b,
           output carry_out,
           output overflow,
           output [31:0] sum
       );

wire overflow_pos_res, overflow_neg_res;
wire pos_res, neg_res;
wire sign_pos_overflow;
wire temp_overflow;
// wire temp_carry_out;
wire a_b_diff_sign;

// implement by carry select adder
carry_sel_32 carry_sel (
                 .a(operand_a),
                 .b(operand_b),
                 .carry_in(1'b0),
                 .carry_out(carry_out),
                 .overflow(overflow),
                 .sum(sum)
             );

// a and b have different signs
xnor_gate diff_sign (
              .x(operand_a[31]),
              .y(operand_b[31]),
              .z(a_b_diff_sign)
          );

// and_gate final_carry_out (
//     .x(a_b_diff_sign),
//     .y(temp_carry_out),
//     .z(carry_out)
// );

// // check positive overflow
// or_gate overflow_pos_1 (
//     .x(operand_a[31]),
//     .y(operand_b[31]),
//     .z(pos_res)
// );

// or_gate overflow_pos_2 (
//     .x(pos_res),
//     .y(sum[31]),
//     .z(overflow_pos_res)
// );

// // check negative overflow
// and_gate overflow_neg_1 (
//     .x(operand_a[31]),
//     .y(operand_b[31]),
//     .z(neg_res)
// );

// and_gate overflow_neg_2 (
//     .x(neg_res),
//     .y(sum[31]),
//     .z(overflow_neg_res)
// );

// or_gate overflow_pos (
//     .x(overflow_pos_res),
//     .y(overflow_neg_res),
//     .z(temp_overflow)
// );

// // assign the output
// and_gate final_overflow (
//     .x(a_b_diff_sign),
//     .y(temp_overflow),
//     .z(overflow)
// );

endmodule
