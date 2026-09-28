module alu(
    input logic [31:0] first_operand,
    input logic [31:0] second_operand,
    input logic [31:0] immediate,
    input logic is_add,
    input logic is_sub,
    input logic is_mul,
    input logic is_div,
    input logic is_mod,
    input logic is_cmp,
    input logic is_and,
    input logic is_or,
    input logic is_not,
    input logic is_mov,
    input logic is_lsl,
    input logic is_lsr,
    input logic is_asr,
    input logic is_load,
    input logic is_store,
    input logic is_immediate,
    output logic flags_equal,
    output logic flags_greater,
    output logic [31:0] alu_result
);

logic [31:0] second_operand_vs_immediate;
logic [31:0] adder_line;
logic [31:0] multiplier_line;
logic [31:0] divider_line;
logic [31:0] shift_unit_line;
logic [31:0] logical_unit_line;
logic [31:0] move_unit_line;
logic is_it_equal;
logic is_it_greater;

mux #(.WIDTH(32)) alu_mux(
    .a(second_operand),
    .b(immediate),
    .s(is_immediate),
    .c(second_operand_vs_immediate)
);

adder alu_adder(
    .first_operand(first_operand),
    .second_operand(second_operand_vs_immediate),
    .is_add(is_add),
    .is_sub(is_sub),
    .is_cmp(is_cmp),
    .result(adder_line),
    .flags_equal(is_it_equal),
    .flags_greater(is_it_greater)
);

assign flags_equal = is_cmp ? is_it_equal : 1'b0;
assign flags_greater = is_cmp ? is_it_greater : 1'b0;

multiplier alu_multiplier(
    .first_operand(first_operand),
    .second_operand(second_operand_vs_immediate),
    .is_mul(is_mul),
    .result(multiplier_line)
);

divider alu_divider(
    .first_operand(first_operand),
    .second_operand(second_operand_vs_immediate),
    .is_div(is_div),
    .is_mod(is_mod),
    .result(divider_line)
);

shift_unit alu_shift_unit(
    .first_operand(first_operand),
    .second_operand(second_operand_vs_immediate),
    .is_lsl(is_lsl),
    .is_lsr(is_lsr),
    .is_asr(is_asr),
    .result(shift_unit_line)
);

logical_unit alu_logical_unit(
    .first_operand(first_operand),
    .second_operand(second_operand_vs_immediate),
    .is_or(is_or),
    .is_not(is_not),
    .is_and(is_and),
    .result(logical_unit_line)
);

move_unit alu_move_unit(
    .operand(second_operand_vs_immediate),
    .is_mov(is_mov),
    .result(move_unit_line)
);

logic [31:0] a[0:7];

assign a[0] = adder_line;
assign a[1] = multiplier_line;
assign a[2] = divider_line;
assign a[3] = shift_unit_line;
assign a[4] = logical_unit_line;
assign a[5] = move_unit_line;
assign a[6] = 32'b0;
assign a[7] = 32'b0;

logic s[0:2];

assign s[0] = is_mul | is_lsl | is_lsr | is_asr | is_mov;
assign s[1] = is_div | is_mod | is_lsl | is_lsr | is_asr;
assign s[2] = is_and | is_or | is_not | is_mov;

mux3 #(.WIDTH(32)) alu_mux3(
    .a(a),
    .s(s),
    .c(alu_result)
);

endmodule