`timescale 1ns/1ps

module MARW_tb;

logic clk;

logic [31:0] load_result_in;
logic [31:0] alu_result_in;
logic [31:0] instruction_in;
logic [31:0] program_counter_in;
logic [31:0] first_operand_in;
logic [31:0] second_operand_in;
logic [31:0] immediate_in;
logic [31:0] branch_target_in;

logic is_add_in;
logic is_sub_in;
logic is_mul_in;
logic is_div_in;
logic is_mod_in;
logic is_cmp_in;
logic is_and_in;
logic is_or_in;
logic is_not_in;
logic is_mov_in;
logic is_lsl_in;
logic is_lsr_in;
logic is_asr_in;
logic is_nop_in;
logic is_load_in;
logic is_store_in;
logic is_branch_equal_in;
logic is_branch_greater_in;
logic is_unconditional_branch_in;
logic is_call_in;
logic is_return_in;
logic is_write_back_in;
logic is_immediate_in;

logic [31:0] load_result_out;
logic [31:0] alu_result_out;
logic [31:0] instruction_out;
logic [31:0] program_counter_out;
logic [31:0] first_operand_out;
logic [31:0] second_operand_out;
logic [31:0] immediate_out;
logic [31:0] branch_target_out;

logic is_add_out;
logic is_sub_out;
logic is_mul_out;
logic is_div_out;
logic is_mod_out;
logic is_cmp_out;
logic is_and_out;
logic is_or_out;
logic is_not_out;
logic is_mov_out;
logic is_lsl_out;
logic is_lsr_out;
logic is_asr_out;
logic is_nop_out;
logic is_load_out;
logic is_store_out;
logic is_branch_equal_out;
logic is_branch_greater_out;
logic is_unconditional_branch_out;
logic is_call_out;
logic is_return_out;
logic is_write_back_out;
logic is_immediate_out;

MARW dut(
    .clk(clk),

    .load_result_in(load_result_in),
    .alu_result_in(alu_result_in),
    .instruction_in(instruction_in),
    .program_counter_in(program_counter_in),
    .first_operand_in(first_operand_in),
    .second_operand_in(second_operand_in),
    .immediate_in(immediate_in),
    .branch_target_in(branch_target_in),

    .is_add_in(is_add_in),
    .is_sub_in(is_sub_in),
    .is_mul_in(is_mul_in),
    .is_div_in(is_div_in),
    .is_mod_in(is_mod_in),
    .is_cmp_in(is_cmp_in),
    .is_and_in(is_and_in),
    .is_or_in(is_or_in),
    .is_not_in(is_not_in),
    .is_mov_in(is_mov_in),
    .is_lsl_in(is_lsl_in),
    .is_lsr_in(is_lsr_in),
    .is_asr_in(is_asr_in),
    .is_nop_in(is_nop_in),
    .is_load_in(is_load_in),
    .is_store_in(is_store_in),
    .is_branch_equal_in(is_branch_equal_in),
    .is_branch_greater_in(is_branch_greater_in),
    .is_unconditional_branch_in(is_unconditional_branch_in),
    .is_call_in(is_call_in),
    .is_return_in(is_return_in),
    .is_write_back_in(is_write_back_in),
    .is_immediate_in(is_immediate_in),

    .load_result_out(load_result_out),
    .alu_result_out(alu_result_out),
    .instruction_out(instruction_out),
    .program_counter_out(program_counter_out),
    .first_operand_out(first_operand_out),
    .second_operand_out(second_operand_out),
    .immediate_out(immediate_out),
    .branch_target_out(branch_target_out),

    .is_add_out(is_add_out),
    .is_sub_out(is_sub_out),
    .is_mul_out(is_mul_out),
    .is_div_out(is_div_out),
    .is_mod_out(is_mod_out),
    .is_cmp_out(is_cmp_out),
    .is_and_out(is_and_out),
    .is_or_out(is_or_out),
    .is_not_out(is_not_out),
    .is_mov_out(is_mov_out),
    .is_lsl_out(is_lsl_out),
    .is_lsr_out(is_lsr_out),
    .is_asr_out(is_asr_out),
    .is_nop_out(is_nop_out),
    .is_load_out(is_load_out),
    .is_store_out(is_store_out),
    .is_branch_equal_out(is_branch_equal_out),
    .is_branch_greater_out(is_branch_greater_out),
    .is_unconditional_branch_out(is_unconditional_branch_out),
    .is_call_out(is_call_out),
    .is_return_out(is_return_out),
    .is_write_back_out(is_write_back_out),
    .is_immediate_out(is_immediate_out)
);

always #5 clk = ~clk;

initial begin

    clk = 0;

    // distinctive data values
    load_result_in      = 32'hAAAAAAAA;
    alu_result_in       = 32'hBBBBBBBB;
    instruction_in      = 32'h12345678;
    program_counter_in  = 32'h00000100;
    first_operand_in    = 32'h11111111;
    second_operand_in   = 32'h22222222;
    immediate_in        = 32'h33333333;
    branch_target_in    = 32'h44444444;

    // distinctive control values
    is_add_in                  = 1;
    is_sub_in                  = 0;
    is_mul_in                  = 1;
    is_div_in                  = 0;
    is_mod_in                  = 1;
    is_cmp_in                  = 0;
    is_and_in                  = 1;
    is_or_in                   = 0;
    is_not_in                  = 1;
    is_mov_in                  = 0;
    is_lsl_in                  = 1;
    is_lsr_in                  = 0;
    is_asr_in                  = 1;
    is_nop_in                  = 0;
    is_load_in                 = 1;
    is_store_in                = 0;
    is_branch_equal_in         = 1;
    is_branch_greater_in       = 0;
    is_unconditional_branch_in = 1;
    is_call_in                 = 0;
    is_return_in               = 1;
    is_write_back_in           = 1;
    is_immediate_in            = 0;

    // capture everything at rising edge
    #10;

    // data outputs
    if (load_result_out !== load_result_in)
        $display("FAIL: load_result");
    else if (alu_result_out !== alu_result_in)
        $display("FAIL: alu_result");
    else if (instruction_out !== instruction_in)
        $display("FAIL: instruction");
    else if (program_counter_out !== program_counter_in)
        $display("FAIL: program counter");
    else if (first_operand_out !== first_operand_in)
        $display("FAIL: first operand");
    else if (second_operand_out !== second_operand_in)
        $display("FAIL: second operand");
    else if (immediate_out !== immediate_in)
        $display("FAIL: immediate");
    else if (branch_target_out !== branch_target_in)
        $display("FAIL: branch target");
    else
        $display("PASS: data outputs");

    // control outputs
    if (is_add_out !== is_add_in)
        $display("FAIL: is_add");
    else if (is_sub_out !== is_sub_in)
        $display("FAIL: is_sub");
    else if (is_mul_out !== is_mul_in)
        $display("FAIL: is_mul");
    else if (is_div_out !== is_div_in)
        $display("FAIL: is_div");
    else if (is_mod_out !== is_mod_in)
        $display("FAIL: is_mod");
    else if (is_cmp_out !== is_cmp_in)
        $display("FAIL: is_cmp");
    else if (is_and_out !== is_and_in)
        $display("FAIL: is_and");
    else if (is_or_out !== is_or_in)
        $display("FAIL: is_or");
    else if (is_not_out !== is_not_in)
        $display("FAIL: is_not");
    else if (is_mov_out !== is_mov_in)
        $display("FAIL: is_mov");
    else if (is_lsl_out !== is_lsl_in)
        $display("FAIL: is_lsl");
    else if (is_lsr_out !== is_lsr_in)
        $display("FAIL: is_lsr");
    else if (is_asr_out !== is_asr_in)
        $display("FAIL: is_asr");
    else if (is_nop_out !== is_nop_in)
        $display("FAIL: is_nop");
    else if (is_load_out !== is_load_in)
        $display("FAIL: is_load");
    else if (is_store_out !== is_store_in)
        $display("FAIL: is_store");
    else if (is_branch_equal_out !== is_branch_equal_in)
        $display("FAIL: is_branch_equal");
    else if (is_branch_greater_out !== is_branch_greater_in)
        $display("FAIL: is_branch_greater");
    else if (is_unconditional_branch_out !== is_unconditional_branch_in)
        $display("FAIL: is_unconditional_branch");
    else if (is_call_out !== is_call_in)
        $display("FAIL: is_call");
    else if (is_return_out !== is_return_in)
        $display("FAIL: is_return");
    else if (is_write_back_out !== is_write_back_in)
        $display("FAIL: is_write_back");
    else if (is_immediate_out !== is_immediate_in)
        $display("FAIL: is_immediate");
    else
        $display("PASS: control outputs");

    $finish;

end

endmodule