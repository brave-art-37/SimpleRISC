module write_data_mux(
    input logic is_load,
    input logic is_call,
    input logic [31:0] alu_result,
    input logic [31:0] load_result,
    input logic [31:0] program_counter,
    output logic [31:0] write_data
);

logic [31:0] a[0:3];

assign a[0] = alu_result;
assign a[1] = load_result;
assign a[2] = program_counter + 32'd4;
assign a[3] = 32'd0;

logic s[0:1];

assign s[0] = is_load;
assign s[1] = is_call;

mux2 #(.WIDTH(32)) write_data_mux(
    .a(a),
    .s(s),
    .c(write_data)
);

endmodule