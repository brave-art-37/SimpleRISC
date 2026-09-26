module first_operand_mux(
    input logic [31:0] instruction,
    input logic [3:0] return_address,
    input logic is_return,
    output logic [3:0] first_operand_register
);

logic [3:0] first_source_register;

assign first_source_register = instruction[22:19];

mux #(.WIDTH(4)) first_operand(
    .a(first_source_register),
    .b(return_address),
    .s(is_return),
    .c(first_operand_register)
);

endmodule