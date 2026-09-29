module branch_unit(
    input logic [31:0] branch_target,
    input logic [31:0] first_operand,
    input logic is_return,
    input logic is_branch_equal,
    input logic is_branch_greater,
    input logic is_unconditional_branch,
    input logic flags_equal,
    input logic flags_greater,
    output logic is_branch_taken,
    output logic [31:0] branch_program_counter
);

mux #(.WIDTH(32)) branch_unit(
    .a(branch_target),
    .b(first_operand),
    .s(is_return),
    .c(branch_program_counter)
);

assign is_branch_taken = (flags_equal && is_branch_equal) || (flags_greater && is_branch_greater) || is_unconditional_branch || is_return;

endmodule
