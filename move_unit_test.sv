module test;

    logic [31:0] operand;
    logic is_mov;
    logic [31:0] result;

    move_unit dut(
        .operand(operand),
        .is_mov(is_mov),
        .result(result)
    );

    initial begin

        operand = 32'h12345678;

        // MOV disabled
        is_mov = 0;

        #1;

        $display(
            "MOV disabled: operand=%h is_mov=%d result=%h",
            operand,
            is_mov,
            result
        );

        // MOV enabled
        is_mov = 1;

        #1;

        $display(
            "MOV enabled: operand=%h is_mov=%d result=%h",
            operand,
            is_mov,
            result
        );

        $finish;
    end

endmodule