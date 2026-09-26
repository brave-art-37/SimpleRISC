module test;

    logic [31:0] first_operand;
    logic is_mov;
    logic [31:0] result;

    move_unit dut(
        .first_operand(first_operand),
        .is_mov(is_mov),
        .result(result)
    );

    initial begin

        first_operand = 32'h12345678;

        // MOV disabled
        is_mov = 0;

        #1;

        $display(
            "MOV disabled: first=%h is_mov=%d result=%h",
            first_operand,
            is_mov,
            result
        );

        // MOV enabled
        is_mov = 1;

        #1;

        $display(
            "MOV enabled: first=%h is_mov=%d result=%h",
            first_operand,
            is_mov,
            result
        );

        $finish;
    end

endmodule