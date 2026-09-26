module test;

    logic clk;
    logic [31:0] memory_data_register;
    logic [31:0] memory_address_register;
    logic is_load;
    logic is_store;
    logic [31:0] load_result;

    memory_access_unit dut(
        .clk(clk),
        .memory_data_register(memory_data_register),
        .memory_address_register(memory_address_register),
        .is_load(is_load),
        .is_store(is_store),
        .load_result(load_result)
    );

    always #5 clk = ~clk;

    initial begin
        clk = 0;
        memory_data_register = 32'b0;
        memory_address_register = 32'b0;
        is_load = 0;
        is_store = 0;

        // store 0x12345678 at address 100
        memory_address_register = 32'd100;
        memory_data_register = 32'h12345678;
        is_store = 1;

        #10;

        is_store = 0;
        is_load = 1;

        #1;
        $display("address=%d load_result=%h",
                 memory_address_register, load_result);

        // store 0xABCDEF01 at address 200
        is_load = 0;
        memory_address_register = 32'd200;
        memory_data_register = 32'hABCDEF01;
        is_store = 1;

        #10;

        is_store = 0;
        is_load = 1;

        #1;
        $display("address=%d load_result=%h",
                 memory_address_register, load_result);

        // load address 100 again
        memory_address_register = 32'd100;

        #1;
        $display("address=%d load_result=%h",
                 memory_address_register, load_result);

        $finish;
    end

endmodule