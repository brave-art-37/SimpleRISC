module memory_access_unit(
    input logic is_load,
    input logic is_store,
    input logic [31:0] memory_address_register,
    input logic [31:0] memory_data_register[0:1],
    output logic [31:0] address,
    output logic store_enable,
    output logic [31:0] store_data,
    output logic [31:0] load_result
);

always_comb begin
    address = memory_address_register;
    store_enable = 0;
    store_data = 0;
    load_result = 0;
    //store get precedence in case of simultaneous access
    if(is_store) begin
        store_enable = 1;
        store_data = memory_data_register[1];
    end
    else if(is_load) begin
        load_result = memory_data_register[0];
    end
end

endmodule