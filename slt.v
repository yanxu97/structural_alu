module slt
       (
           input [31:0] operand_a,
           input [31:0] operand_b,
           output [31:0] slt_res
       );

wire [31:0] not_operand_b;
wire add_flip_bit_out, add_flip_bit_overflow;
wire [31:0] add_flip_bit_res;
wire sub_carry_out, sub_overflow;
wire [31:0] sub_res;

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
           .carry_out(sub_carry_out),
           .overflow(sub_overflow),
           .sum(sub_res)
       );

// and_gate and_gate_1 (
//              .x(sub_res[31]),
//              .y(1'b1),
//              .z(slt_res)
//          );
assign slt_res = sub_res[31];
endmodule
