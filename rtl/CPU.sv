module CPU(
    input logic clk,
    input logic reset
);

// return address register
localparam logic [3:0] RETURN_ADDRESS_REGISTER = 4'd15;

// program counter manager
logic is_branch_taken_from_branch_unit;
logic [31:0] branch_program_counter_from_branch_unit;
logic [31:0] program_counter_from_program_counter_manager;

// instruction memory
logic [31:0] instruction_from_instruction_memory;

// IFOF
logic [31:0] instruction_from_IFOF;
logic [31:0] program_counter_from_IFOF;
logic [3:0] destination_register_from_IFOF;
logic [3:0] first_source_register_from_IFOF;
logic [3:0] second_source_register_from_IFOF;

// control unit
logic is_add_from_control_unit;
logic is_sub_from_control_unit;
logic is_mul_from_control_unit;
logic is_div_from_control_unit;
logic is_mod_from_control_unit;
logic is_cmp_from_control_unit;
logic is_and_from_control_unit;
logic is_or_from_control_unit;
logic is_not_from_control_unit;
logic is_mov_from_control_unit;
logic is_lsl_from_control_unit;
logic is_lsr_from_control_unit;
logic is_asr_from_control_unit;
logic is_nop_from_control_unit;
logic is_load_from_control_unit;
logic is_store_from_control_unit;
logic is_branch_equal_from_control_unit;
logic is_branch_greater_from_control_unit;
logic is_unconditional_branch_from_control_unit;
logic is_call_from_control_unit;
logic is_return_from_control_unit;
logic is_write_back_from_control_unit;
logic is_immediate_from_control_unit;

// operand muxes
logic [3:0] first_operand_register_from_first_operand_mux;
logic [3:0] second_operand_register_from_second_operand_mux;

// register file
logic [31:0] first_operand_from_register_file;
logic [31:0] second_operand_from_register_file;

// immediate / branch target
logic [31:0] immediate_from_immediate_branch_target;
logic [31:0] branch_target_from_immediate_branch_target;

// OFEX
logic [31:0] instruction_from_OFEX;
logic [31:0] program_counter_from_OFEX;
logic [31:0] first_operand_from_OFEX;
logic [31:0] second_operand_from_OFEX;
logic [31:0] immediate_from_OFEX;
logic [31:0] branch_target_from_OFEX;

logic is_add_from_OFEX;
logic is_sub_from_OFEX;
logic is_mul_from_OFEX;
logic is_div_from_OFEX;
logic is_mod_from_OFEX;
logic is_cmp_from_OFEX;
logic is_and_from_OFEX;
logic is_or_from_OFEX;
logic is_not_from_OFEX;
logic is_mov_from_OFEX;
logic is_lsl_from_OFEX;
logic is_lsr_from_OFEX;
logic is_asr_from_OFEX;
logic is_nop_from_OFEX;
logic is_load_from_OFEX;
logic is_store_from_OFEX;
logic is_branch_equal_from_OFEX;
logic is_branch_greater_from_OFEX;
logic is_unconditional_branch_from_OFEX;
logic is_call_from_OFEX;
logic is_return_from_OFEX;
logic is_write_back_from_OFEX;
logic is_immediate_from_OFEX;

// ALU
logic [31:0] alu_result_from_alu;
logic flags_equal_from_alu;
logic flags_greater_from_alu;

// EXMA
logic [31:0] alu_result_from_EXMA;
logic [31:0] instruction_from_EXMA;
logic [31:0] program_counter_from_EXMA;
logic [31:0] first_operand_from_EXMA;
logic [31:0] second_operand_from_EXMA;
logic [31:0] immediate_from_EXMA;
logic [31:0] branch_target_from_EXMA;

logic is_add_from_EXMA;
logic is_sub_from_EXMA;
logic is_mul_from_EXMA;
logic is_div_from_EXMA;
logic is_mod_from_EXMA;
logic is_cmp_from_EXMA;
logic is_and_from_EXMA;
logic is_or_from_EXMA;
logic is_not_from_EXMA;
logic is_mov_from_EXMA;
logic is_lsl_from_EXMA;
logic is_lsr_from_EXMA;
logic is_asr_from_EXMA;
logic is_nop_from_EXMA;
logic is_load_from_EXMA;
logic is_store_from_EXMA;
logic is_branch_equal_from_EXMA;
logic is_branch_greater_from_EXMA;
logic is_unconditional_branch_from_EXMA;
logic is_call_from_EXMA;
logic is_return_from_EXMA;
logic is_write_back_from_EXMA;
logic is_immediate_from_EXMA;

// data memory
logic [31:0] address_from_memory_access_unit;
logic store_enable_from_memory_access_unit;
logic [31:0] store_data_from_memory_access_unit;
logic [31:0] read_data_from_data_memory;

// MAU
logic [31:0] load_result_from_memory_access_unit;

logic [31:0] memory_data_register_for_memory_access_unit [0:1];

// MARW
logic [31:0] load_result_from_MARW;
logic [31:0] alu_result_from_MARW;
logic [31:0] instruction_from_MARW;
logic [31:0] program_counter_from_MARW;
logic [31:0] first_operand_from_MARW;
logic [31:0] second_operand_from_MARW;
logic [31:0] immediate_from_MARW;
logic [31:0] branch_target_from_MARW;

logic is_add_from_MARW;
logic is_sub_from_MARW;
logic is_mul_from_MARW;
logic is_div_from_MARW;
logic is_mod_from_MARW;
logic is_cmp_from_MARW;
logic is_and_from_MARW;
logic is_or_from_MARW;
logic is_not_from_MARW;
logic is_mov_from_MARW;
logic is_lsl_from_MARW;
logic is_lsr_from_MARW;
logic is_asr_from_MARW;
logic is_nop_from_MARW;
logic is_load_from_MARW;
logic is_store_from_MARW;
logic is_branch_equal_from_MARW;
logic is_branch_greater_from_MARW;
logic is_unconditional_branch_from_MARW;
logic is_call_from_MARW;
logic is_return_from_MARW;
logic is_write_back_from_MARW;
logic is_immediate_from_MARW;

// write-back
logic [3:0] write_port_from_write_address_mux;
logic [31:0] write_data_from_write_data_mux;


// flags
logic flags_equal;
logic flags_greater;

always_ff @(posedge clk) begin
    if (reset) begin
        flags_equal   <= 1'b0;
        flags_greater <= 1'b0;
    end
    else if (is_cmp_from_OFEX) begin
        flags_equal   <= flags_equal_from_alu;
        flags_greater <= flags_greater_from_alu;
    end
    else begin
        flags_equal <= flags_equal;
        flags_greater <= flags_greater;
    end
end

// program counter
program_counter_manager program_counter_manager(
    .clk(clk),
    .reset(reset),
    .is_branch_taken(is_branch_taken_from_branch_unit),
    .branch_program_counter(branch_program_counter_from_branch_unit),
    .program_counter(program_counter_from_program_counter_manager)
);

//pipeline registers
IFOF IFOF(
    .clk(clk),
    .instruction_in(instruction_from_instruction_memory),
    .program_counter_in(program_counter_from_program_counter_manager),

    .instruction_out(instruction_from_IFOF),
    .program_counter_out(program_counter_from_IFOF),
    .destination_register(destination_register_from_IFOF),
    .first_source_register(first_source_register_from_IFOF),
    .second_source_register(second_source_register_from_IFOF)
);
OFEX OFEX(
    .clk(clk),

    .instruction_in(instruction_from_IFOF),
    .program_counter_in(program_counter_from_IFOF),
    .first_operand_in(first_operand_from_register_file),
    .second_operand_in(second_operand_from_register_file),
    .immediate_in(immediate_from_immediate_branch_target),
    .branch_target_in(branch_target_from_immediate_branch_target),
    .is_add_in(is_add_from_control_unit),
    .is_sub_in(is_sub_from_control_unit),
    .is_mul_in(is_mul_from_control_unit),
    .is_div_in(is_div_from_control_unit),
    .is_mod_in(is_mod_from_control_unit),
    .is_cmp_in(is_cmp_from_control_unit),
    .is_and_in(is_and_from_control_unit),
    .is_or_in(is_or_from_control_unit),
    .is_not_in(is_not_from_control_unit),
    .is_mov_in(is_mov_from_control_unit),
    .is_lsl_in(is_lsl_from_control_unit),
    .is_lsr_in(is_lsr_from_control_unit),
    .is_asr_in(is_asr_from_control_unit),
    .is_nop_in(is_nop_from_control_unit),
    .is_load_in(is_load_from_control_unit),
    .is_store_in(is_store_from_control_unit),
    .is_branch_equal_in(is_branch_equal_from_control_unit),
    .is_branch_greater_in(is_branch_greater_from_control_unit),
    .is_unconditional_branch_in(is_unconditional_branch_from_control_unit),
    .is_call_in(is_call_from_control_unit),
    .is_return_in(is_return_from_control_unit),
    .is_write_back_in(is_write_back_from_control_unit),
    .is_immediate_in(is_immediate_from_control_unit),

    .instruction_out(instruction_from_OFEX),
    .program_counter_out(program_counter_from_OFEX),
    .first_operand_out(first_operand_from_OFEX),
    .second_operand_out(second_operand_from_OFEX),
    .immediate_out(immediate_from_OFEX),
    .branch_target_out(branch_target_from_OFEX),
    .is_add_out(is_add_from_OFEX),
    .is_sub_out(is_sub_from_OFEX),
    .is_mul_out(is_mul_from_OFEX),
    .is_div_out(is_div_from_OFEX),
    .is_mod_out(is_mod_from_OFEX),
    .is_cmp_out(is_cmp_from_OFEX),
    .is_and_out(is_and_from_OFEX),
    .is_or_out(is_or_from_OFEX),
    .is_not_out(is_not_from_OFEX),
    .is_mov_out(is_mov_from_OFEX),
    .is_lsl_out(is_lsl_from_OFEX),
    .is_lsr_out(is_lsr_from_OFEX),
    .is_asr_out(is_asr_from_OFEX),
    .is_nop_out(is_nop_from_OFEX),
    .is_load_out(is_load_from_OFEX),
    .is_store_out(is_store_from_OFEX),
    .is_branch_equal_out(is_branch_equal_from_OFEX),
    .is_branch_greater_out(is_branch_greater_from_OFEX),
    .is_unconditional_branch_out(is_unconditional_branch_from_OFEX),
    .is_call_out(is_call_from_OFEX),
    .is_return_out(is_return_from_OFEX),
    .is_write_back_out(is_write_back_from_OFEX),
    .is_immediate_out(is_immediate_from_OFEX)

);

EXMA EXMA(
    .clk(clk),

    .alu_result_in(alu_result_from_alu),
    .instruction_in(instruction_from_OFEX),
    .program_counter_in(program_counter_from_OFEX),
    .first_operand_in(first_operand_from_OFEX),
    .second_operand_in(second_operand_from_OFEX),
    .immediate_in(immediate_from_OFEX),
    .branch_target_in(branch_target_from_OFEX),
    .is_add_in(is_add_from_OFEX),
    .is_sub_in(is_sub_from_OFEX),
    .is_mul_in(is_mul_from_OFEX),
    .is_div_in(is_div_from_OFEX),
    .is_mod_in(is_mod_from_OFEX),
    .is_cmp_in(is_cmp_from_OFEX),
    .is_and_in(is_and_from_OFEX),
    .is_or_in(is_or_from_OFEX),
    .is_not_in(is_not_from_OFEX),
    .is_mov_in(is_mov_from_OFEX),
    .is_lsl_in(is_lsl_from_OFEX),
    .is_lsr_in(is_lsr_from_OFEX),
    .is_asr_in(is_asr_from_OFEX),
    .is_nop_in(is_nop_from_OFEX),
    .is_load_in(is_load_from_OFEX),
    .is_store_in(is_store_from_OFEX),
    .is_branch_equal_in(is_branch_equal_from_OFEX),
    .is_branch_greater_in(is_branch_greater_from_OFEX),
    .is_unconditional_branch_in(is_unconditional_branch_from_OFEX),
    .is_call_in(is_call_from_OFEX),
    .is_return_in(is_return_from_OFEX),
    .is_write_back_in(is_write_back_from_OFEX),
    .is_immediate_in(is_immediate_from_OFEX),

    .alu_result_out(alu_result_from_EXMA),
    .instruction_out(instruction_from_EXMA),
    .program_counter_out(program_counter_from_EXMA),
    .first_operand_out(first_operand_from_EXMA),
    .second_operand_out(second_operand_from_EXMA),
    .immediate_out(immediate_from_EXMA),
    .branch_target_out(branch_target_from_EXMA),
    .is_add_out(is_add_from_EXMA),
    .is_sub_out(is_sub_from_EXMA),
    .is_mul_out(is_mul_from_EXMA),
    .is_div_out(is_div_from_EXMA),
    .is_mod_out(is_mod_from_EXMA),
    .is_cmp_out(is_cmp_from_EXMA),
    .is_and_out(is_and_from_EXMA),
    .is_or_out(is_or_from_EXMA),
    .is_not_out(is_not_from_EXMA),
    .is_mov_out(is_mov_from_EXMA),
    .is_lsl_out(is_lsl_from_EXMA),
    .is_lsr_out(is_lsr_from_EXMA),
    .is_asr_out(is_asr_from_EXMA),
    .is_nop_out(is_nop_from_EXMA),
    .is_load_out(is_load_from_EXMA),
    .is_store_out(is_store_from_EXMA),
    .is_branch_equal_out(is_branch_equal_from_EXMA),
    .is_branch_greater_out(is_branch_greater_from_EXMA),
    .is_unconditional_branch_out(is_unconditional_branch_from_EXMA),
    .is_call_out(is_call_from_EXMA),
    .is_return_out(is_return_from_EXMA),
    .is_write_back_out(is_write_back_from_EXMA),
    .is_immediate_out(is_immediate_from_EXMA)
);

MARW MARW(
    .clk(clk),

    .load_result_in(load_result_from_memory_access_unit),
    .alu_result_in(alu_result_from_EXMA),
    .instruction_in(instruction_from_EXMA),
    .program_counter_in(program_counter_from_EXMA),
    .first_operand_in(first_operand_from_EXMA),
    .second_operand_in(second_operand_from_EXMA),
    .immediate_in(immediate_from_EXMA),
    .branch_target_in(branch_target_from_EXMA),
    .is_add_in(is_add_from_EXMA),
    .is_sub_in(is_sub_from_EXMA),
    .is_mul_in(is_mul_from_EXMA),
    .is_div_in(is_div_from_EXMA),
    .is_mod_in(is_mod_from_EXMA),
    .is_cmp_in(is_cmp_from_EXMA),
    .is_and_in(is_and_from_EXMA),
    .is_or_in(is_or_from_EXMA),
    .is_not_in(is_not_from_EXMA),
    .is_mov_in(is_mov_from_EXMA),
    .is_lsl_in(is_lsl_from_EXMA),
    .is_lsr_in(is_lsr_from_EXMA),
    .is_asr_in(is_asr_from_EXMA),
    .is_nop_in(is_nop_from_EXMA),
    .is_load_in(is_load_from_EXMA),
    .is_store_in(is_store_from_EXMA),
    .is_branch_equal_in(is_branch_equal_from_EXMA),
    .is_branch_greater_in(is_branch_greater_from_EXMA),
    .is_unconditional_branch_in(is_unconditional_branch_from_EXMA),
    .is_call_in(is_call_from_EXMA),
    .is_return_in(is_return_from_EXMA),
    .is_write_back_in(is_write_back_from_EXMA),
    .is_immediate_in(is_immediate_from_EXMA),

    .load_result_out(load_result_from_MARW),
    .alu_result_out(alu_result_from_MARW),
    .instruction_out(instruction_from_MARW),
    .program_counter_out(program_counter_from_MARW),
    .first_operand_out(first_operand_from_MARW),
    .second_operand_out(second_operand_from_MARW),
    .immediate_out(immediate_from_MARW),
    .branch_target_out(branch_target_from_MARW),
    .is_add_out(is_add_from_MARW),
    .is_sub_out(is_sub_from_MARW),
    .is_mul_out(is_mul_from_MARW),
    .is_div_out(is_div_from_MARW),
    .is_mod_out(is_mod_from_MARW),
    .is_cmp_out(is_cmp_from_MARW),
    .is_and_out(is_and_from_MARW),
    .is_or_out(is_or_from_MARW),
    .is_not_out(is_not_from_MARW),
    .is_mov_out(is_mov_from_MARW),
    .is_lsl_out(is_lsl_from_MARW),
    .is_lsr_out(is_lsr_from_MARW),
    .is_asr_out(is_asr_from_MARW),
    .is_nop_out(is_nop_from_MARW),
    .is_load_out(is_load_from_MARW),
    .is_store_out(is_store_from_MARW),
    .is_branch_equal_out(is_branch_equal_from_MARW),
    .is_branch_greater_out(is_branch_greater_from_MARW),
    .is_unconditional_branch_out(is_unconditional_branch_from_MARW),
    .is_call_out(is_call_from_MARW),
    .is_return_out(is_return_from_MARW),
    .is_write_back_out(is_write_back_from_MARW),
    .is_immediate_out(is_immediate_from_MARW)
);

// memory holders
register_file register_file(
    .clk(clk),
    .reset(reset),

    .first_read_port(first_operand_register_from_first_operand_mux),
    .second_read_port(second_operand_register_from_second_operand_mux),
    .is_write_back(is_write_back_from_MARW),
    .write_port(write_port_from_write_address_mux),
    .write_data(write_data_from_write_data_mux),

    .first_operand(first_operand_from_register_file),
    .second_operand(second_operand_from_register_file)
);

instruction_memory instruction_memory(
    .program_counter(program_counter_from_program_counter_manager),

    .instruction(instruction_from_instruction_memory)
);

data_memory data_memory(
    .clk(clk),

    .address(address_from_memory_access_unit),
    .store_enable(store_enable_from_memory_access_unit),
    .store_data(store_data_from_memory_access_unit),

    .read_data(read_data_from_data_memory)
);

// OF
control_unit control_unit(
    .instruction(instruction_from_IFOF),

    .is_add(is_add_from_control_unit),
    .is_sub(is_sub_from_control_unit),
    .is_mul(is_mul_from_control_unit),
    .is_div(is_div_from_control_unit),
    .is_mod(is_mod_from_control_unit),
    .is_cmp(is_cmp_from_control_unit),
    .is_and(is_and_from_control_unit),
    .is_or(is_or_from_control_unit),
    .is_not(is_not_from_control_unit),
    .is_mov(is_mov_from_control_unit),
    .is_lsl(is_lsl_from_control_unit),
    .is_lsr(is_lsr_from_control_unit),
    .is_asr(is_asr_from_control_unit),
    .is_nop(is_nop_from_control_unit),
    .is_load(is_load_from_control_unit),
    .is_store(is_store_from_control_unit),
    .is_branch_equal(is_branch_equal_from_control_unit),
    .is_branch_greater(is_branch_greater_from_control_unit),
    .is_unconditional_branch(is_unconditional_branch_from_control_unit),
    .is_call(is_call_from_control_unit),
    .is_return(is_return_from_control_unit),
    .is_write_back(is_write_back_from_control_unit),
    .is_immediate(is_immediate_from_control_unit)
);

first_operand_mux first_operand_mux(
    .is_return(is_return_from_control_unit),
    .first_source_register(first_source_register_from_IFOF),
    .return_address(RETURN_ADDRESS_REGISTER),

    .first_operand_register(first_operand_register_from_first_operand_mux)
);

second_operand_mux second_operand_mux(
    .destination_register(destination_register_from_IFOF),
    .second_source_register(second_source_register_from_IFOF),
    .is_store(is_store_from_control_unit),

    .second_operand_register(second_operand_register_from_second_operand_mux)
);

immediate_branch_target immediate_branch_target(
    .instruction(instruction_from_IFOF),
    .program_counter(program_counter_from_IFOF),

    .immediate(immediate_from_immediate_branch_target),
    .branch_target(branch_target_from_immediate_branch_target)
);

// EX
branch_unit branch_unit(
    .branch_target(branch_target_from_OFEX),
    .first_operand(first_operand_from_OFEX),
    .is_return(is_return_from_OFEX),
    .is_branch_equal(is_branch_equal_from_OFEX),
    .is_branch_greater(is_branch_greater_from_OFEX),
    .is_unconditional_branch(is_unconditional_branch_from_OFEX),
    .flags_equal(flags_equal),
    .flags_greater(flags_greater),

    .is_branch_taken(is_branch_taken_from_branch_unit),
    .branch_program_counter(branch_program_counter_from_branch_unit)
);

alu alu(
    .first_operand(first_operand_from_OFEX),
    .second_operand(second_operand_from_OFEX),
    .immediate(immediate_from_OFEX),
    .is_add(is_add_from_OFEX),
    .is_sub(is_sub_from_OFEX),
    .is_mul(is_mul_from_OFEX),
    .is_div(is_div_from_OFEX),
    .is_mod(is_mod_from_OFEX),
    .is_cmp(is_cmp_from_OFEX),
    .is_and(is_and_from_OFEX),
    .is_or(is_or_from_OFEX),
    .is_not(is_not_from_OFEX),
    .is_mov(is_mov_from_OFEX),
    .is_lsl(is_lsl_from_OFEX),
    .is_lsr(is_lsr_from_OFEX),
    .is_asr(is_asr_from_OFEX),
    .is_load(is_load_from_OFEX),
    .is_store(is_store_from_OFEX),
    .is_immediate(is_immediate_from_OFEX),

    .flags_equal(flags_equal_from_alu),
    .flags_greater(flags_greater_from_alu),
    .alu_result(alu_result_from_alu)
);

// MA
assign memory_data_register_for_memory_access_unit[0] = read_data_from_data_memory;
assign memory_data_register_for_memory_access_unit[1] = second_operand_from_EXMA;

memory_access_unit memory_access_unit(
    .is_load(is_load_from_EXMA),
    .is_store(is_store_from_EXMA),
    .memory_address_register(alu_result_from_EXMA),
    .memory_data_register(memory_data_register_for_memory_access_unit),

    .address(address_from_memory_access_unit),
    .store_enable(store_enable_from_memory_access_unit),
    .store_data(store_data_from_memory_access_unit),
    .load_result(load_result_from_memory_access_unit)
);

// RW
write_address_mux write_address_mux(
    .is_call(is_call_from_MARW),
    .return_address(RETURN_ADDRESS_REGISTER),
    .destination_register(instruction_from_MARW[25:22]),

    .write_port(write_port_from_write_address_mux)
);

write_data_mux write_data_mux(
    .is_load(is_load_from_MARW),
    .is_call(is_call_from_MARW),
    .alu_result(alu_result_from_MARW),
    .load_result(load_result_from_MARW),
    .program_counter(program_counter_from_MARW),
    
    .write_data(write_data_from_write_data_mux)
);



endmodule