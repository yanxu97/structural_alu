module fulladder_4 #(parameter SIZE = 4)
       (
           input [SIZE-1:0] a,
           input [SIZE-1:0] b,
           input carry_in,
           output [SIZE-1:0] sum,
           output carry_out
       );

genvar i;
wire [SIZE:0] temp_carry_in;

assign temp_carry_in[0] = carry_in;

generate
    for (i = 0; i < SIZE; i = i+1)
    begin : generate_full_adder_4
        fulladder fulladder_1 (
                      .a(a[i]),
                      .b(b[i]),
                      .carry_in(temp_carry_in[i]),
                      .sum(sum[i]),
                      .carry_out(temp_carry_in[i+1])
                  );
    end
endgenerate

or_gate select_carry_out (
            .x(temp_carry_in[SIZE]),
            .y(1'b0),
            .z(carry_out)
        );

endmodule
