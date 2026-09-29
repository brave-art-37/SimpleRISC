module test;

    logic [31:0] first_operand;
    logic [31:0] second_operand;
    logic is_or;
    logic is_not;
    logic is_and;
    logic [31:0] result;

    logical_unit dut(
        .first_operand(first_operand),
        .second_operand(second_operand),
        .is_or(is_or),
        .is_not(is_not),
        .is_and(is_and),
        .result(result)
    );

    initial begin

        first_operand = 32'hF0F0F0F0;
        second_operand = 32'h0F0F0F0F;

        // OR
        is_or = 1;
        is_not = 0;
        is_and = 0;

        #1;

        $display(
            "OR: first=%h second=%h result=%h",
            first_operand,
            second_operand,
            result
        );

        // NOT
        is_or = 0;
        is_not = 1;
        is_and = 0;

        #1;

        $display(
            "NOT: second=%h result=%h",
            second_operand,
            result
        );

        // AND
        is_or = 0;
        is_not = 0;
        is_and = 1;

        #1;

        $display(
            "AND: first=%h second=%h result=%h",
            first_operand,
            second_operand,
            result
        );

        $finish;
    end

endmodule