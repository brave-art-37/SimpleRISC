module second_operand_mux(
    input logic [3:0] destination_register,
    input logic [3:0] second_source_register,
    input logic is_store,
    output logic [3:0] second_operand_register
);

mux #(.WIDTH(4)) second_operand(
    .a(second_source_register),
    .b(destination_register),
    .s(is_store),
    .c(second_operand_register)
);

endmodule