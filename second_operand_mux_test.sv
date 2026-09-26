module test;

    logic [31:0] instruction;
    logic is_store;
    logic [3:0] second_operand_register;

    second_operand_mux dut(
        .instruction(instruction),
        .is_store(is_store),
        .second_operand_register(second_operand_register)
    );

    initial begin

        // normal instruction
        // instruction[22:19] = 5
        // instruction[26:23] = 12
        instruction = 32'b0;
        instruction[18:15] = 4'd5;
        instruction[26:23] = 4'd12;
        is_store = 0;

        #1;

        $display(
            "normal: second_source_register=%d destination_register=%d is_store=%d second_operand=%d",
            instruction[18:15],
            instruction[26:23],
            is_store,
            second_operand_register
        );

        // store instruction
        // should select destination_register
        is_store = 1;

        #1;

        $display(
            "store: second_source_register=%d destination_register=%d is_store=%d second_operand=%d",
            instruction[18:15],
            instruction[26:23],
            is_store,
            second_operand_register
        );

        $finish;
    end

endmodule