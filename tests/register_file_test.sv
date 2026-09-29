module test;

    logic clk;
    logic reset;

    logic [3:0] first_read_port;
    logic [3:0] second_read_port;

    logic is_write_back;
    logic [3:0] write_port;
    logic [31:0] write_data;

    logic [31:0] first_operand;
    logic [31:0] second_operand;

    register_file dut(
        .clk(clk),
        .reset(reset),
        .first_read_port(first_read_port),
        .second_read_port(second_read_port),
        .is_write_back(is_write_back),
        .write_port(write_port),
        .write_data(write_data),
        .first_operand(first_operand),
        .second_operand(second_operand)
    );

    always #5 clk = ~clk;

    initial begin
        clk = 0;
        reset = 1;
        is_write_back = 0;
        write_port = 0;
        write_data = 0;
        first_read_port = 0;
        second_read_port = 1;

        // synchronous reset happens at the rising edge
        #10;

        reset = 0;

        // after reset, R0 and R1 should both be 0
        #1;
        $display(
            "after reset: R0=%d R1=%d",
            first_operand,
            second_operand
        );

        // write 123 into R3
        write_port = 3;
        write_data = 123;
        is_write_back = 1;

        #10;

        is_write_back = 0;

        // read R3 and R0
        first_read_port = 3;
        second_read_port = 0;

        #1;
        $display(
            "after R3 write: R3=%d R0=%d",
            first_operand,
            second_operand
        );

        // write 456 into R7
        write_port = 7;
        write_data = 456;
        is_write_back = 1;

        #10;

        is_write_back = 0;

        // two simultaneous reads
        first_read_port = 3;
        second_read_port = 7;

        #1;
        $display(
            "two reads: R3=%d R7=%d",
            first_operand,
            second_operand
        );

        // verify write enable: attempt to write R5 without write-back
        write_port = 5;
        write_data = 999;
        is_write_back = 0;

        #10;

        first_read_port = 5;

        #1;
        $display(
            "write disabled: R5=%d",
            first_operand
        );

        $finish;
    end

endmodule