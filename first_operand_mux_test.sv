module test;

    logic [31:0] instruction;
    logic [3:0] return_address;
    logic is_return;
    logic [3:0] first_operand_register;

    first_operand_mux dut(
        .instruction(instruction),
        .return_address(return_address),
        .is_return(is_return),
        .first_operand_register(first_operand_register)
    );

    initial begin

        // normal instruction
        // instruction[26:23] = 5
        instruction = 32'b0;
        instruction[22:19] = 4'd5;
        return_address = 4'd12;
        is_return = 0;

        #1;

        $display(
            "normal: first_source_register=%d return_address=%d is_return=%d first_operand=%d",
            instruction[22:19],
            return_address,
            is_return,
            first_operand_register
        );

        // return instruction
        // should select return_address
        is_return = 1;

        #1;

        $display(
            "return: first_source_register=%d return_address=%d is_return=%d first_operand=%d",
            instruction[22:19],
            return_address,
            is_return,
            first_operand_register
        );

        $finish;
    end

endmodule