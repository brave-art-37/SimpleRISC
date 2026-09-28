module first_operand_mux(
    input logic is_return,
    input logic [3:0] first_source_register,
    input logic [3:0] return_address,
    output logic [3:0] first_operand_register
);

mux #(.WIDTH(4)) first_operand(
    .a(first_source_register),
    .b(return_address),
    .s(is_return),
    .c(first_operand_register)
);

endmodule