module branch_unit_mux(
    input logic [31:0] branch_target,
    input logic [31:0] first_operand,
    input logic is_return,
    output logic [31:0] branch_program_counter
);

mux #(.WIDTH(32)) branch_unit(
    .a(branch_target),
    .b(first_operand),
    .s(is_return),
    .c(branch_program_counter)
);

endmodule