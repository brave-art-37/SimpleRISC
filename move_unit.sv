module move_unit(
    input logic [31:0] first_operand,
    input logic is_mov,
    output logic [31:0] result
);

mux #(.WIDTH(32)) move_unit_mux(
    .a(32'b0),
    .b(first_operand),
    .s(is_mov),
    .c(result)
);

endmodule