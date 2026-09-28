module memory_access_unit(
    input logic is_load,
    input logic is_store,
    input logic [31:0] memory_address_register,
    input logic [31:0] memory_data_register[0:1],
    output logic [31:0] address,
    output logic write_enable,
    output logic [31:0] write_data,
    output logic [31:0] load_result
);

always_comb begin
    address = memory_address_register;
    write_enable = 0;
    write_data = 0;
    load_result = 0;
    if(is_store) begin
        write_enable = 1;
        write_data = memory_data_register[1];
    end
    else if(is_load) begin
        load_result = memory_data_register[0];
    end
end

endmodule