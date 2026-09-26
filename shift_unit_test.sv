module test;

    logic [31:0] first_operand;
    logic [31:0] second_operand;
    logic is_lsl;
    logic is_lsr;
    logic is_asr;
    logic [31:0] result;

    shift_unit dut(
        .first_operand(first_operand),
        .second_operand(second_operand),
        .is_lsl(is_lsl),
        .is_lsr(is_lsr),
        .is_asr(is_asr),
        .result(result)
    );

    initial begin

        // LSL: 5 << 2 = 20
        first_operand = 32'd5;
        second_operand = 32'd2;
        is_lsl = 1;
        is_lsr = 0;
        is_asr = 0;

        #1;

        $display(
            "LSL: first=%d shift=%d result=%d",
            first_operand,
            second_operand,
            result
        );


        // LSR: 20 >> 2 = 5
        first_operand = 32'd20;
        second_operand = 32'd2;
        is_lsl = 0;
        is_lsr = 1;

        #1;

        $display(
            "LSR: first=%d shift=%d result=%d",
            first_operand,
            second_operand,
            result
        );


        // ASR with MSB = 0
        // 20 >> 2 = 5
        first_operand = 32'd20;
        second_operand = 32'd2;
        is_lsr = 0;
        is_asr = 1;

        #1;

        $display(
            "ASR positive: first=%h shift=%d result=%h",
            first_operand,
            second_operand,
            result
        );


        // ASR with MSB = 1
        // 0x80000000 >>> 2 = 0xE0000000
        first_operand = 32'h80000000;
        second_operand = 32'd2;

        #1;

        $display(
            "ASR MSB=1: first=%h shift=%d result=%h",
            first_operand,
            second_operand,
            result
        );


        $finish;
    end

endmodule