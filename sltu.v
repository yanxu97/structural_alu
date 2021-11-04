module sltu
       (
           input [31:0] operand_a,
           input [31:0] operand_b,
           output [31:0] sltu_res
       );

genvar i;

wire [31:0] full_sltu_res;
wire temp_sltu_res;

// no shift
generate
    for (i = 0; i < 32; i = i+1)
    begin : generate_full_sltu_res
        comparator comparator_sltu (
                       .x(operand_a[i]),
                       .y(operand_b[i]),
                       .z(full_sltu_res[i])
                   );
    end
endgenerate

check_zero check_zero_1 (
               .a(full_sltu_res),
               .z(sltu_res[0])
           );

xor_gate_n #(.n(31)) xor_gate_n_1 (
               .x(31'b0),
               .y(31'b0),
               .z(sltu_res[31:1])
           );

endmodule
