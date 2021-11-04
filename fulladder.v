// `include "include.v"
// `include "lib/xor_gate.v"
// `include "lib/and_gate.v"
// `include "lib/or_gate.v"

module fulladder (
           input a,
           input b,
           input carry_in,
           output sum,
           output carry_out
       );

wire xor_1_out;
wire and_gate_1_out, and_gate_2_out, and_gate_3_out;
wire or_gate_1_out;

// sum = a^b^carry_in
xor_gate xor_1(
             .x(a),
             .y(b),
             .z(xor_1_out)
         );

xor_gate xor2(
             .x(xor_1_out),
             .y(carry_in),
             .z(sum)
         );

// carry_out = (a & b) | (a & carry_in) | (b & carry_in);
and_gate and_gate_1(
             .x(a),
             .y(b),
             .z(and_gate_1_out)
         );

and_gate and_gate_2(
             .x(a),
             .y(carry_in),
             .z(and_gate_2_out)
         );

and_gate and_gate_3(
             .x(b),
             .y(carry_in),
             .z(and_gate_3_out)
         );

or_gate or_gate_1(
            .x(and_gate_1_out),
            .y(and_gate_2_out),
            .z(or_gate_1_out)
        );

or_gate or_gate_2(
            .x(or_gate_1_out),
            .y(and_gate_3_out),
            .z(carry_out)
        );

endmodule
