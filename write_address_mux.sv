module write_address_mux (
    input logic is_call,
    input logic [3:0] return_address,
    input logic [3:0] destination_register,
    output logic [3:0] write_port
);

mux #(.WIDTH(4)) write_address(
    .a(destination_register),
    .b(return_address),
    .s(is_call),
    .c(write_port)
);

endmodule