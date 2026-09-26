module test;

    logic [31:0] first_operand;
    logic [31:0] second_operand;
    logic is_mul;
    logic [31:0] result;

    multiplier dut(
        .first_operand(first_operand),
        .second_operand(second_operand),
        .is_mul(is_mul),
        .result(result)
    );

    initial begin

        // 10 * 20 = 200
        first_operand = 32'd10;
        second_operand = 32'd20;
        is_mul = 1;

        #1;

        $display(
            "MUL: first=%d second=%d result=%d",
            first_operand,
            second_operand,
            result
        );

        // 2^32 * 2^32
        // full result = 2^64, but only low 32 bits are exposed
        first_operand = 32'hFFFFFFFF;
        second_operand = 32'd2;

        #1;

        $display(
            "MUL: first=%d second=%d result=%d",
            first_operand,
            second_operand,
            result
        );

        // multiplication disabled
        is_mul = 0;

        #1;

        $display(
            "MUL disabled: result=%d",
            result
        );

        $finish;
    end

endmodule