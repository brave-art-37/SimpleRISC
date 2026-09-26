module test;

    logic [31:0] first_operand;
    logic [31:0] second_operand;
    logic is_add;
    logic is_sub;
    logic is_cmp;

    logic [31:0] result;
    logic flags_equal;
    logic flags_greater;

    adder dut(
        .first_operand(first_operand),
        .second_operand(second_operand),
        .is_add(is_add),
        .is_sub(is_sub),
        .is_cmp(is_cmp),
        .result(result),
        .flags_equal(flags_equal),
        .flags_greater(flags_greater)
    );

    initial begin

        // ADD: 10 + 20 = 30
        first_operand = 32'd10;
        second_operand = 32'd20;
        is_add = 1;
        is_sub = 0;
        is_cmp = 0;

        #1;

        $display(
            "ADD: first=%d second=%d result=%d",
            first_operand,
            second_operand,
            result
        );


        // SUB: 20 - 10 = 10
        is_add = 0;
        is_sub = 1;

        #1;

        $display(
            "SUB: first=%d second=%d result=%d",
            first_operand,
            second_operand,
            result
        );


        // CMP equal: 10 == 10
        first_operand = 32'd10;
        second_operand = 32'd10;
        is_sub = 0;
        is_cmp = 1;

        #1;

        $display(
            "CMP equal: first=%d second=%d equal=%d greater=%d",
            first_operand,
            second_operand,
            flags_equal,
            flags_greater
        );


        // CMP greater: 20 > 10
        first_operand = 32'd20;
        second_operand = 32'd10;

        #1;

        $display(
            "CMP greater: first=%d second=%d equal=%d greater=%d",
            first_operand,
            second_operand,
            flags_equal,
            flags_greater
        );


        // CMP smaller: 10 < 20
        first_operand = 32'd10;
        second_operand = 32'd20;

        #1;

        $display(
            "CMP smaller: first=%d second=%d equal=%d greater=%d",
            first_operand,
            second_operand,
            flags_equal,
            flags_greater
        );


        $finish;

    end

endmodule