module test;

    logic is_return;
    logic [3:0] first_source_register;
    logic [3:0] return_address;
    logic [3:0] first_operand_register;

    first_operand_mux dut(
        .is_return(is_return),
        .first_source_register(first_source_register),
        .return_address(return_address),
        .first_operand_register(first_operand_register)
    );

    initial begin

        // normal instruction
        is_return = 0;
        first_source_register = 4'd5;
        return_address = 4'd15;

        #1;

        $display(
            "NORMAL: is_return=%b first_source=%d return_address=%d | output=%d",
            is_return,
            first_source_register,
            return_address,
            first_operand_register
        );

        // RET instruction
        is_return = 1;

        #1;

        $display(
            "RETURN: is_return=%b first_source=%d return_address=%d | output=%d",
            is_return,
            first_source_register,
            return_address,
            first_operand_register
        );

        $finish;
    end

endmodule