module test;

    logic is_load;
    logic is_store;
    logic [31:0] memory_address_register;
    logic [31:0] memory_data_register [0:1];

    logic [31:0] address;
    logic store_enable;
    logic [31:0] store_data;
    logic [31:0] load_result;

    memory_access_unit dut(
        .is_load(is_load),
        .is_store(is_store),
        .memory_address_register(memory_address_register),
        .memory_data_register(memory_data_register),
        .address(address),
        .store_enable(store_enable),
        .store_data(store_data),
        .load_result(load_result)
    );

    initial begin

        // initial values
        is_load = 0;
        is_store = 0;
        memory_address_register = 32'd100;
        memory_data_register[0] = 32'h12345678; // data from memory
        memory_data_register[1] = 32'hABCDEF01; // data for memory

        #1;

        // no operation
        $display(
            "NOP: address=%0d store_enable=%b store_data=%h load_result=%h",
            address, store_enable, store_data, load_result
        );

        // LOAD
        is_load = 1;
        is_store = 0;

        #1;

        $display(
            "LOAD: address=%0d store_enable=%b store_data=%h load_result=%h",
            address, store_enable, store_data, load_result
        );

        // STORE
        is_load = 0;
        is_store = 1;

        #1;

        $display(
            "STORE: address=%0d store_enable=%b store_data=%h load_result=%h",
            address, store_enable, store_data, load_result
        );

        // simultaneous store and load
        is_load = 1;
        is_store = 1;

        #1;

        $display(
            "STORE: address=%0d store_enable=%b store_data=%h load_result=%h",
            address, store_enable, store_data, load_result
        );

        $finish;
    end

endmodule