module second_operand_mux(
    input logic [31:0] instruction,
    input logic is_store,
    output logic [3:0] second_operand_register
);

logic [3:0] destination_register;
logic [3:0] second_source_register;

assign destination_register = instruction[26:23];
assign second_source_register = instruction[18:15];

mux #(.WIDTH(4)) second_operand(
    .a(second_source_register),
    .b(destination_register),
    .s(is_store),
    .c(second_operand_register)
);

endmodule