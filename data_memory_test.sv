module test;

    logic [31:0] address;
    logic clk;
    logic store_enable;
    logic [31:0] store_data;
    logic [31:0] read_data;

    data_memory dut(
        .address(address),
        .clk(clk),
        .store_enable(store_enable),
        .store_data(store_data),
        .read_data(read_data)
    );

    always #5 clk = ~clk;

    initial begin
        clk = 0;
        address = 0;
        store_enable = 0;
        store_data = 0;

        // store 0x12345678 to location 100
        address = 32'd100;
        store_data = 32'h12345678;
        store_enable = 1;
        #10;

        store_enable = 0;
        #1;
        $display("address=%d read_data=%h", address, read_data);

        // store 0xABCDEF01 to location 200
        address = 32'd200;
        store_data = 32'hABCDEF01;
        store_enable = 1;
        #10;

        store_enable = 0;
        #1;
        $display("address=%d read_data=%h", address, read_data);

        // read location 100 again
        address = 32'd100;
        #1;
        $display("address=%d read_data=%h", address, read_data);

        $finish;
    end

endmodule