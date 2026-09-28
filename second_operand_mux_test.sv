module test;

    logic [3:0] destination_register;
    logic [3:0] second_source_register;
    logic is_store;
    logic [3:0] second_operand_register;

    second_operand_mux dut(
        .destination_register(destination_register),
        .second_source_register(second_source_register),
        .is_store(is_store),
        .second_operand_register(second_operand_register)
    );

    initial begin

        // normal instruction
        is_store = 0;
        second_source_register = 4'd7;
        destination_register = 4'd12;

        #1;

        $display(
            "NORMAL: is_store=%b second_source=%d destination=%d | output=%d",
            is_store,
            second_source_register,
            destination_register,
            second_operand_register
        );

        // store instruction
        is_store = 1;

        #1;

        $display(
            "STORE: is_store=%b second_source=%d destination=%d | output=%d",
            is_store,
            second_source_register,
            destination_register,
            second_operand_register
        );

        $finish;
    end

endmodule