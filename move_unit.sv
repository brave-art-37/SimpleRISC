module move_unit(
    input logic [31:0] operand,
    input logic is_mov,
    output logic [31:0] result
);

mux #(.WIDTH(32)) move_unit_mux(
    .a(32'b0),
    .b(operand),
    .s(is_mov),
    .c(result)
);

endmodule