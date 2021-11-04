module alu_tb;

reg [31:0] operand_a;
reg [31:0] operand_b;
reg [3:0] control;
wire carry_out, overflow, zero;
wire [31:0] result;
wire [31:0] opcode_ascii [8:0];
reg [31:0] curr_opcode;

assign opcode_ascii[0] = " add";
assign opcode_ascii[1] = " sub";
assign opcode_ascii[2] = " and";
assign opcode_ascii[3] = " xor";
assign opcode_ascii[4] = "  or";
assign opcode_ascii[5] = " sll";
assign opcode_ascii[6] = " srl";
assign opcode_ascii[7] = " slt";
assign opcode_ascii[8] = "sltu";

// arithmetic: add, sub
// logical: and, xor, or, sll, srl
// conditional: slt, sltu

alu dut (
        .operand_a(operand_a),
        .operand_b(operand_b),
        .control(control),
        .carryout(carry_out),
        .overflow(overflow),
        .zero(zero),
        .result(result)
    );

initial
begin

    // testing normal add: 1+1=2
    #50;
    operand_a = 32'd1;
    operand_b = 32'd1;
    control = 4'b0000;
    curr_opcode = opcode_ascii[control];

    // testing normal add: 8+8=16
    #50;
    operand_a = 32'd8;
    operand_b = 32'd8;
    control = 4'b0000;
    curr_opcode = opcode_ascii[control];

    // testing normal add: 31+31=62
    #50;
    operand_a = 32'd31;
    operand_b = 32'd31;
    control = 4'b0000;
    curr_opcode = opcode_ascii[control];

    // testing normal add: 32+32=64
    #50;
    operand_a = 32'd32;
    operand_b = 32'd32;
    control = 4'b0000;
    curr_opcode = opcode_ascii[control];

    // testing normal add: -1+1=0
    #50;
    operand_a = 32'hffffffff;
    operand_b = 32'd1;
    control = 4'b0000;
    curr_opcode = opcode_ascii[control];

    // testing normal add: -2+1=-1
    #50;
    operand_a = 32'hfffffffe;
    operand_b = 32'd1;
    control = 4'b0000;
    curr_opcode = opcode_ascii[control];

    // testing normal add: 0+-1=-1
    #50;
    operand_a = 32'h00000000;
    operand_b = 32'hffffffff;
    control = 4'b0000;
    curr_opcode = opcode_ascii[control];

    // testing overflow add: 32'h7fffffff+32'h7fffffff
    #50;
    operand_a = 32'h7fffffff;
    operand_b = 32'h7fffffff;
    control = 4'b0000;
    curr_opcode = opcode_ascii[control];

    // testing overflow add: 32'h10000000+32'h10000000
    #50;
    operand_a = 32'h10000000;
    operand_b = 32'h10000000;
    control = 4'b0000;
    curr_opcode = opcode_ascii[control];

    // testing normal sub: 16-8=8
    #50;
    operand_a = 32'd16;
    operand_b = 32'd8;
    control = 4'b0001;
    curr_opcode = opcode_ascii[control];

    // testing normal sub: 8-16=-8
    #50;
    operand_a = 32'd8;
    operand_b = 32'd16;
    control = 4'b0001;
    curr_opcode = opcode_ascii[control];

    // testing normal sub: 60-61=-1
    #50;
    operand_a = 32'd60;
    operand_b = 32'd61;
    control = 4'b0001;
    curr_opcode = opcode_ascii[control];

    // testing normal sub: 0-1=-1
    #50;
    operand_a = 32'd0;
    operand_b = 32'd1;
    control = 4'b0001;
    curr_opcode = opcode_ascii[control];

    // testing normal and: 32'hffffffff and 32'hffffffff
    #50;
    operand_a = 32'hffffffff;
    operand_b = 32'hffffffff;
    control = 4'b0010;
    curr_opcode = opcode_ascii[control];

    // testing normal and: 32'h00000000 and 32'h00000000
    #50;
    operand_a = 32'h00000000;
    operand_b = 32'h00000000;
    control = 4'b0010;
    curr_opcode = opcode_ascii[control];

    // testing normal xor: 32'h00000000 and 32'h00000000
    #50;
    operand_a = 32'h00000000;
    operand_b = 32'h00000000;
    control = 4'b0011;
    curr_opcode = opcode_ascii[control];

    // testing normal xor: 32'hffffffff and 32'hffffffff
    #50;
    operand_a = 32'hffffffff;
    operand_b = 32'hffffffff;
    control = 4'b0011;
    curr_opcode = opcode_ascii[control];

    // testing normal or: 32'hffffffff and 32'h00000000
    #50;
    operand_a = 32'hffffffff;
    operand_b = 32'h00000000;
    control = 4'b0100;
    curr_opcode = opcode_ascii[control];

    // testing normal or: 32'h00000000 and 32'h00000000
    #50;
    operand_a = 32'h00000000;
    operand_b = 32'h00000000;
    control = 4'b0100;
    curr_opcode = opcode_ascii[control];

    // testing normal sll: 32'hfffffff0 and 32'h0000000c
    #50;
    operand_a = 32'hfffffff0;
    operand_b = 32'h0000000c;
    control = 4'b0101;
    curr_opcode = opcode_ascii[control];

    // testing normal sll: 32'h0000ffff and 32'h00000010
    #50;
    operand_a = 32'h0000ffff;
    operand_b = 32'h00000010;
    control = 4'b0101;
    curr_opcode = opcode_ascii[control];

    // testing normal sll: 32'h0000ffff and 32'h00000010
    #50;
    operand_a = 32'h0000ffff;
    operand_b = 32'h00000010;
    control = 4'b0101;
    curr_opcode = opcode_ascii[control];

    // testing normal srl:
    #50;
    operand_a = 32'h0000ffff;
    operand_b = 32'h00000010;
    control = 4'b0110;
    curr_opcode = opcode_ascii[control];

    // testing normal srl:
    #50;
    operand_a = 32'h0000ffff;
    operand_b = 32'h00000010;
    control = 4'b0110;
    curr_opcode = opcode_ascii[control];

    // testing normal slt:
    #50;
    operand_a = 32'h0000ffff;
    operand_b = 32'hffffffff;
    control = 4'b0111;
    curr_opcode = opcode_ascii[control];

    // testing normal slt:
    #50;
    operand_a = 32'h0000ffff;
    operand_b = 32'hffffffff;
    control = 4'b0111;
    curr_opcode = opcode_ascii[control];

    // testing normal slt:
    #50;
    operand_a = 32'h0000ffff;
    operand_b = 32'h00000010;
    control = 4'b0111;
    curr_opcode = opcode_ascii[control];

    // testing normal sltu:
    #50;
    operand_a = 32'h0000ffff;
    operand_b = 32'hffffffff;
    control = 4'b1000;
    curr_opcode = opcode_ascii[control];

    // testing normal sltu:
    #50;
    operand_a = 32'h0000ffff;
    operand_b = 32'h00000010;
    control = 4'b1000;
    curr_opcode = opcode_ascii[control];

    // testing normal sltu:
    #50;
    operand_a = 32'hffffffff;
    operand_b = 32'h00000010;
    control = 4'b1000;
    curr_opcode = opcode_ascii[control];
end

endmodule
