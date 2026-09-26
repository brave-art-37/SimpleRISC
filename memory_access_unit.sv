module memory_access_unit(
    input logic clk,
    input logic [31:0] memory_data_register,
    input logic [31:0] memory_address_register,
    input logic is_load,
    input logic is_store,
    output logic [31:0] load_result
);

logic [31:0] read_result;

memory ram(
    .address(memory_address_register),
    .clk(clk),
    .write_enable(is_store),
    .write_data(memory_data_register),
    .read_data(read_result)
);

always_comb begin
    load_result = 32'b0;
    if(is_load) load_result = read_result;
end

endmodule