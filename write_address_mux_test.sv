module test;

    logic is_call;
    logic [3:0] return_address;
    logic [3:0] destination_register;
    logic [3:0] write_port;

    write_address_mux dut(
        .is_call(is_call),
        .return_address(return_address),
        .destination_register(destination_register),
        .write_port(write_port)
    );

    initial begin

        return_address = 4'd15;
        destination_register = 4'd7;

        // normal instruction
        is_call = 0;

        #1;

        $display(
            "NORMAL: is_call=%b destination=%d return_address=%d | write_port=%d",
            is_call,
            destination_register,
            return_address,
            write_port
        );

        // CALL
        is_call = 1;

        #1;

        $display(
            "CALL: is_call=%b destination=%d return_address=%d | write_port=%d",
            is_call,
            destination_register,
            return_address,
            write_port
        );

        $finish;
    end

endmodule