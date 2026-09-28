module test;

    logic [31:0] first_operand;
    logic [31:0] second_operand;
    logic [31:0] immediate;

    logic is_add;
    logic is_sub;
    logic is_mul;
    logic is_div;
    logic is_mod;
    logic is_cmp;
    logic is_and;
    logic is_or;
    logic is_not;
    logic is_mov;
    logic is_lsl;
    logic is_lsr;
    logic is_asr;
    logic is_load;
    logic is_store;
    logic is_immediate;

    logic flags_equal;
    logic flags_greater;
    logic [31:0] alu_result;

    alu dut(
        .first_operand(first_operand),
        .second_operand(second_operand),
        .immediate(immediate),
        .is_add(is_add),
        .is_sub(is_sub),
        .is_mul(is_mul),
        .is_div(is_div),
        .is_mod(is_mod),
        .is_cmp(is_cmp),
        .is_and(is_and),
        .is_or(is_or),
        .is_not(is_not),
        .is_mov(is_mov),
        .is_lsl(is_lsl),
        .is_lsr(is_lsr),
        .is_asr(is_asr),
        .is_load(is_load),
        .is_store(is_store),
        .is_immediate(is_immediate),
        .flags_equal(flags_equal),
        .flags_greater(flags_greater),
        .alu_result(alu_result)
    );

    task clear_controls;
        begin
            is_add = 0;
            is_sub = 0;
            is_mul = 0;
            is_div = 0;
            is_mod = 0;
            is_cmp = 0;
            is_and = 0;
            is_or = 0;
            is_not = 0;
            is_mov = 0;
            is_lsl = 0;
            is_lsr = 0;
            is_asr = 0;
            is_load = 0;
            is_store = 0;
            is_immediate = 0;
        end
    endtask

    initial begin

        first_operand = 32'd20;
        second_operand = 32'd5;
        immediate = 32'd3;

        // ADD
        clear_controls();
        is_add = 1;
        #1;
        $display("ADD: result=%0d", alu_result);

        // ADD immediate
        clear_controls();
        is_add = 1;
        is_immediate = 1;
        #1;
        $display("ADD immediate: result=%0d", alu_result);

        // SUB
        clear_controls();
        is_sub = 1;
        #1;
        $display("SUB: result=%0d", alu_result);

        // MUL
        clear_controls();
        is_mul = 1;
        #1;
        $display("MUL: result=%0d", alu_result);

        // DIV
        clear_controls();
        is_div = 1;
        #1;
        $display("DIV: result=%0d", alu_result);

        // MOD
        clear_controls();
        is_mod = 1;
        #1;
        $display("MOD: result=%0d", alu_result);

        // CMP equal
        clear_controls();
        first_operand = 20;
        second_operand = 20;
        is_cmp = 1;
        #1;
        $display(
            "CMP equal: equal=%b greater=%b",
            flags_equal,
            flags_greater
        );

        // CMP greater
        clear_controls();
        first_operand = 20;
        second_operand = 10;
        is_cmp = 1;
        #1;
        $display(
            "CMP greater: equal=%b greater=%b",
            flags_equal,
            flags_greater
        );

        // CMP less
        clear_controls();
        first_operand = 10;
        second_operand = 20;
        is_cmp = 1;
        #1;
        $display(
            "CMP less: equal=%b greater=%b",
            flags_equal,
            flags_greater
        );

        // AND
        clear_controls();
        first_operand = 32'hF0F0;
        second_operand = 32'h0FF0;
        is_and = 1;
        #1;
        $display("AND: result=%h", alu_result);

        // OR
        clear_controls();
        is_or = 1;
        #1;
        $display("OR: result=%h", alu_result);

        // NOT
        clear_controls();
        is_not = 1;
        #1;
        $display("NOT: result=%h", alu_result);

        // MOV
        clear_controls();
        first_operand = 32'h12345678;
        is_mov = 1;
        #1;
        $display("MOV: result=%h", alu_result);

        // LSL
        clear_controls();
        first_operand = 32'd3;
        second_operand = 32'd2;
        is_lsl = 1;
        #1;
        $display("LSL: result=%0d", alu_result);

        // LSR
        clear_controls();
        first_operand = 32'd20;
        second_operand = 32'd2;
        is_lsr = 1;
        #1;
        $display("LSR: result=%0d", alu_result);

        // ASR
        clear_controls();
        first_operand = 32'hFFFFFFF0;
        second_operand = 32'd2;
        is_asr = 1;
        #1;
        $display("ASR: result=%h", alu_result);

        // LOAD/STORE should not select an ALU operation
        clear_controls();
        is_load = 1;
        #1;
        $display("LOAD: result=%h", alu_result);

        clear_controls();
        is_store = 1;
        #1;
        $display("STORE: result=%h", alu_result);

        $finish;
    end

endmodule