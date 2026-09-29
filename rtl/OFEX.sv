module OFEX(
    input logic clk,

    input logic [31:0] instruction_in,
    input logic [31:0] program_counter_in,
    input logic [31:0] first_operand_in,
    input logic [31:0] second_operand_in,
    input logic [31:0] immediate_in,
    input logic [31:0] branch_target_in,
    input logic is_add_in,
    input logic is_sub_in,
    input logic is_mul_in,
    input logic is_div_in,
    input logic is_mod_in,
    input logic is_cmp_in,
    input logic is_and_in,
    input logic is_or_in,
    input logic is_not_in,
    input logic is_mov_in,
    input logic is_lsl_in,
    input logic is_lsr_in,
    input logic is_asr_in,
    input logic is_nop_in,
    input logic is_load_in,
    input logic is_store_in,
    input logic is_branch_equal_in,
    input logic is_branch_greater_in,
    input logic is_unconditional_branch_in,
    input logic is_call_in,
    input logic is_return_in,
    input logic is_write_back_in,
    input logic is_immediate_in,

    output logic [31:0] instruction_out,
    output logic [31:0] program_counter_out,
    output logic [31:0] first_operand_out,
    output logic [31:0] second_operand_out,
    output logic [31:0] immediate_out,
    output logic [31:0] branch_target_out,
    output logic is_add_out,
    output logic is_sub_out,
    output logic is_mul_out,
    output logic is_div_out,
    output logic is_mod_out,
    output logic is_cmp_out,
    output logic is_and_out,
    output logic is_or_out,
    output logic is_not_out,
    output logic is_mov_out,
    output logic is_lsl_out,
    output logic is_lsr_out,
    output logic is_asr_out,
    output logic is_nop_out,
    output logic is_load_out,
    output logic is_store_out,
    output logic is_branch_equal_out,
    output logic is_branch_greater_out,
    output logic is_unconditional_branch_out,
    output logic is_call_out,
    output logic is_return_out,
    output logic is_write_back_out,
    output logic is_immediate_out
);

always_ff @(posedge clk) begin
    instruction_out              <= instruction_in;
    program_counter_out          <= program_counter_in;
    first_operand_out            <= first_operand_in;
    second_operand_out           <= second_operand_in;
    immediate_out                <= immediate_in;
    branch_target_out            <= branch_target_in;

    is_add_out                   <= is_add_in;
    is_sub_out                   <= is_sub_in;
    is_mul_out                   <= is_mul_in;
    is_div_out                   <= is_div_in;
    is_mod_out                   <= is_mod_in;
    is_cmp_out                   <= is_cmp_in;
    is_and_out                   <= is_and_in;
    is_or_out                    <= is_or_in;
    is_not_out                   <= is_not_in;
    is_mov_out                   <= is_mov_in;
    is_lsl_out                   <= is_lsl_in;
    is_lsr_out                   <= is_lsr_in;
    is_asr_out                   <= is_asr_in;
    is_nop_out                   <= is_nop_in;
    is_load_out                  <= is_load_in;
    is_store_out                 <= is_store_in;
    is_branch_equal_out          <= is_branch_equal_in;
    is_branch_greater_out        <= is_branch_greater_in;
    is_unconditional_branch_out  <= is_unconditional_branch_in;
    is_call_out                  <= is_call_in;
    is_return_out                <= is_return_in;
    is_write_back_out            <= is_write_back_in;
    is_immediate_out             <= is_immediate_in;
end

endmodule