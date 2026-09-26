module test;

    logic [31:0] first_operand;
    logic [31:0] second_operand;
    logic is_div;
    logic is_mod;
    logic [31:0] result;

    divider dut(
        .first_operand(first_operand),
        .second_operand(second_operand),
        .is_div(is_div),
        .is_mod(is_mod),
        .result(result)
    );

    initial begin

        // 20 / 4 = 5
        first_operand = 32'd20;
        second_operand = 32'd4;
        is_div = 1;
        is_mod = 0;

        #1;

        $display(
            "DIV: first=%d second=%d result=%d",
            first_operand,
            second_operand,
            result
        );

        // 20 % 6 = 2
        is_div = 0;
        is_mod = 1;

        #1;

        $display(
            "MOD: first=%d second=%d result=%d",
            first_operand,
            second_operand,
            result
        );

        // division by zero
        // 20 / 0 = 0xFFFFFFFF
        is_div = 1;
        is_mod = 0;
        second_operand = 0;

        #1;

        $display(
            "DIV zero: first=%d second=%d result=%h",
            first_operand,
            second_operand,
            result
        );

        // modulo by zero
        // 20 % 0 = 20
        is_div = 0;
        is_mod = 1;

        #1;

        $display(
            "MOD zero: first=%d second=%d result=%d",
            first_operand,
            second_operand,
            result
        );

        $finish;
    end

endmodule