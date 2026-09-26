module test;

    logic [31:0] instruction;
    logic flags_equal;
    logic flags_greater;

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
    logic is_nop;
    logic is_load;
    logic is_store;
    logic is_branch_taken;
    logic is_branch_equal;
    logic is_branch_greater;
    logic is_unconditional_branch;
    logic is_call;
    logic is_return;
    logic is_write_back;
    logic is_immediate;

    control_unit dut(
        .instruction(instruction),
        .flags_equal(flags_equal),
        .flags_greater(flags_greater),
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
        .is_nop(is_nop),
        .is_load(is_load),
        .is_store(is_store),
        .is_branch_taken(is_branch_taken),
        .is_branch_equal(is_branch_equal),
        .is_branch_greater(is_branch_greater),
        .is_unconditional_branch(is_unconditional_branch),
        .is_call(is_call),
        .is_return(is_return),
        .is_write_back(is_write_back),
        .is_immediate(is_immediate)
    );

    task test_instruction(
        input logic [4:0] opcode,
        input logic immediate,
        input logic equal,
        input logic greater
    );
        begin
            instruction = 32'b0;
            instruction[31:27] = opcode;
            instruction[26] = immediate;
            flags_equal = equal;
            flags_greater = greater;

            #1;

            $display(
                "opcode=%0d immediate=%b equal=%b greater=%b | add=%b sub=%b mul=%b div=%b mod=%b cmp=%b and=%b or=%b not=%b mov=%b lsl=%b lsr=%b asr=%b nop=%b load=%b store=%b branch=%b call=%b return=%b wb=%b",
                opcode,
                immediate,
                equal,
                greater,
                is_add,
                is_sub,
                is_mul,
                is_div,
                is_mod,
                is_cmp,
                is_and,
                is_or,
                is_not,
                is_mov,
                is_lsl,
                is_lsr,
                is_asr,
                is_nop,
                is_load,
                is_store,
                is_branch_taken,
                is_call,
                is_return,
                is_write_back
            );
        end
    endtask

    initial begin

        // arithmetic / logical
        test_instruction(5'd0,  0, 0, 0); // ADD
        test_instruction(5'd1,  0, 0, 0); // SUB
        test_instruction(5'd2,  0, 0, 0); // MUL
        test_instruction(5'd3,  0, 0, 0); // DIV
        test_instruction(5'd4, 0, 0, 0); // MOD
        test_instruction(5'd5, 0, 0, 0); // CMP
        test_instruction(5'd6, 0, 0, 0); // AND
        test_instruction(5'd7, 0, 0, 0); // OR
        test_instruction(5'd8, 0, 0, 0); // NOT
        test_instruction(5'd9, 0, 0, 0); // MOV
        test_instruction(5'd10, 0, 0, 0); // LSL
        test_instruction(5'd11, 0, 0, 0); // LSR
        test_instruction(5'd12, 0, 0, 0); // ASR

        // control
        test_instruction(5'd13, 0, 0, 0); // NOP
        test_instruction(5'd14, 1, 0, 0); // LD
        test_instruction(5'd15, 1, 0, 0); // ST

        // branches
        test_instruction(5'd16, 0, 0, 0); // BEQ, condition false
        test_instruction(5'd16, 0, 1, 0); // BEQ, condition true

        test_instruction(5'd17, 0, 0, 0); // BGT, condition false
        test_instruction(5'd17, 0, 0, 1); // BGT, condition true

        test_instruction(5'd18, 0, 0, 0); // B

        // call / return
        test_instruction(5'd19, 0, 0, 0); // CALL
        test_instruction(5'd20, 0, 0, 0); // RET

        $finish;
    end

endmodule