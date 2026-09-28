module test;

    logic [31:0] address;
    logic clk;
    logic write_enable;
    logic [31:0] write_data;
    logic [31:0] read_data;

    data_memory dut(
        .address(address),
        .clk(clk),
        .write_enable(write_enable),
        .write_data(write_data),
        .read_data(read_data)
    );

    always #5 clk = ~clk;

    initial begin
        clk = 0;
        address = 0;
        write_enable = 0;
        write_data = 0;

        // write 0x12345678 to location 100
        address = 32'd100;
        write_data = 32'h12345678;
        write_enable = 1;
        #10;

        write_enable = 0;
        #1;
        $display("address=%d read_data=%h", address, read_data);

        // write 0xABCDEF01 to location 200
        address = 32'd200;
        write_data = 32'hABCDEF01;
        write_enable = 1;
        #10;

        write_enable = 0;
        #1;
        $display("address=%d read_data=%h", address, read_data);

        // read location 100 again
        address = 32'd100;
        #1;
        $display("address=%d read_data=%h", address, read_data);

        $finish;
    end

endmodule