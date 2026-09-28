module test;

    logic [31:0] branch_target;
    logic [31:0] first_operand;
    logic is_return;
    logic is_branch_equal;
    logic is_branch_greater;
    logic flags_equal;
    logic flags_greater;
    logic is_unconditional_branch;

    logic is_branch_taken;
    logic [31:0] branch_program_counter;

    branch_unit dut(
        .branch_target(branch_target),
        .first_operand(first_operand),
        .is_return(is_return),
        .is_branch_equal(is_branch_equal),
        .is_branch_greater(is_branch_greater),
        .flags_equal(flags_equal),
        .flags_greater(flags_greater),
        .is_unconditional_branch(is_unconditional_branch),
        .is_branch_taken(is_branch_taken),
        .branch_program_counter(branch_program_counter)
    );

    task clear_controls;
        begin
            is_return = 0;
            is_branch_equal = 0;
            is_branch_greater = 0;
            flags_equal = 0;
            flags_greater = 0;
            is_unconditional_branch = 0;
        end
    endtask

    initial begin

        branch_target = 32'd100;
        first_operand = 32'd12;

        // BEQ, condition false
        clear_controls();
        is_branch_equal = 1;
        flags_equal = 0;
        #1;
        $display(
            "BEQ false: taken=%b pc=%0d",
            is_branch_taken,
            branch_program_counter
        );

        // BEQ, condition true
        clear_controls();
        is_branch_equal = 1;
        flags_equal = 1;
        #1;
        $display(
            "BEQ true: taken=%b pc=%0d",
            is_branch_taken,
            branch_program_counter
        );

        // BGT, condition false
        clear_controls();
        is_branch_greater = 1;
        flags_greater = 0;
        #1;
        $display(
            "BGT false: taken=%b pc=%0d",
            is_branch_taken,
            branch_program_counter
        );

        // BGT, condition true
        clear_controls();
        is_branch_greater = 1;
        flags_greater = 1;
        #1;
        $display(
            "BGT true: taken=%b pc=%0d",
            is_branch_taken,
            branch_program_counter
        );

        // unconditional branch
        clear_controls();
        is_unconditional_branch = 1;
        #1;
        $display(
            "B: taken=%b pc=%0d",
            is_branch_taken,
            branch_program_counter
        );

        // RET
        clear_controls();
        is_return = 1;
        #1;
        $display(
            "RET: taken=%b pc=%0d",
            is_branch_taken,
            branch_program_counter
        );

        // normal branch target
        clear_controls();
        #1;
        $display(
            "normal: taken=%b pc=%0d",
            is_branch_taken,
            branch_program_counter
        );

        $finish;
    end

endmodule