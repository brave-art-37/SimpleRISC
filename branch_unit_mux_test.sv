module test;

    logic [31:0] branch_target;
    logic [31:0] first_operand;
    logic is_return;
    logic [31:0] branch_program_counter;

    branch_unit_mux dut(
        .branch_target(branch_target),
        .first_operand(first_operand),
        .is_return(is_return),
        .branch_program_counter(branch_program_counter)
    );

    initial begin

        // normal instruction
        // should select branch_target

        branch_target = 32'd100;
        first_operand = 32'd12;
        is_return = 0;

        #1;

        $display(
            "normal: branch_target=%d first_operand=%d is_return=%d branch_program_counter=%d",
            branch_target,
            first_operand,
            is_return,
            branch_program_counter
        );

        // return instruction
        // should select first_operand

        is_return = 1;

        #1;

        $display(
            "return: branch_target=%d first_operand=%d is_return=%d branch_program_counter=%d",
            branch_target,
            first_operand,
            is_return,
            branch_program_counter
        );

        $finish;
    end

endmodule