`timescale 1ns/1ps

module CPU_tb;

logic clk;
logic reset;
integer cycle;

CPU dut (
    .clk(clk),
    .reset(reset)
);

// 10 ns clock
always #5 clk = ~clk;


// --------------------------------------------------
// print machine state every clock
// --------------------------------------------------
always @(posedge clk) begin
    #1;

    $display("");
    $display("============================================================");
    $display("                    CYCLE %0d", cycle);
    $display("============================================================");


    // ==================================================
    // IF STAGE
    // ==================================================
    $display("");
    $display("--- IF STAGE ---");

    if (dut.program_counter_from_program_counter_manager !== 32'b0)
        $display("IF PC          = %h",
            dut.program_counter_from_program_counter_manager);

    if (dut.instruction_from_instruction_memory !== 32'b0)
        $display("IF instruction  = %h",
            dut.instruction_from_instruction_memory);


    // ==================================================
    // IFOF / OF STAGE
    // ==================================================
    $display("");
    $display("--- OF STAGE ---");

    if (dut.program_counter_from_IFOF !== 32'b0)
        $display("OF PC                = %h",
            dut.program_counter_from_IFOF);

    if (dut.instruction_from_IFOF !== 32'b0)
        $display("OF instruction       = %h",
            dut.instruction_from_IFOF);

    if (dut.destination_register_from_IFOF !== 4'b0)
        $display("OF destination reg   = %d",
            dut.destination_register_from_IFOF);

    if (dut.first_source_register_from_IFOF !== 4'b0)
        $display("OF first source reg  = %d",
            dut.first_source_register_from_IFOF);

    if (dut.second_source_register_from_IFOF !== 4'b0)
        $display("OF second source reg = %d",
            dut.second_source_register_from_IFOF);

    if (dut.first_operand_from_register_file !== 32'b0)
        $display("OF first operand     = %h",
            dut.first_operand_from_register_file);

    if (dut.second_operand_from_register_file !== 32'b0)
        $display("OF second operand    = %h",
            dut.second_operand_from_register_file);

    if (dut.immediate_from_immediate_branch_target !== 32'b0)
        $display("OF immediate         = %h",
            dut.immediate_from_immediate_branch_target);

    if (dut.branch_target_from_immediate_branch_target !== 32'b0)
        $display("OF branch target     = %h",
            dut.branch_target_from_immediate_branch_target);

    if (dut.is_add_from_control_unit !== 1'b0)
        $display("OF ADD               = %b",
            dut.is_add_from_control_unit);

    if (dut.is_sub_from_control_unit !== 1'b0)
        $display("OF SUB               = %b",
            dut.is_sub_from_control_unit);

    if (dut.is_mul_from_control_unit !== 1'b0)
        $display("OF MUL               = %b",
            dut.is_mul_from_control_unit);

    if (dut.is_div_from_control_unit !== 1'b0)
        $display("OF DIV               = %b",
            dut.is_div_from_control_unit);

    if (dut.is_mod_from_control_unit !== 1'b0)
        $display("OF MOD               = %b",
            dut.is_mod_from_control_unit);

    if (dut.is_cmp_from_control_unit !== 1'b0)
        $display("OF CMP               = %b",
            dut.is_cmp_from_control_unit);

    if (dut.is_and_from_control_unit !== 1'b0)
        $display("OF AND               = %b",
            dut.is_and_from_control_unit);

    if (dut.is_or_from_control_unit !== 1'b0)
        $display("OF OR                = %b",
            dut.is_or_from_control_unit);

    if (dut.is_not_from_control_unit !== 1'b0)
        $display("OF NOT               = %b",
            dut.is_not_from_control_unit);

    if (dut.is_mov_from_control_unit !== 1'b0)
        $display("OF MOV               = %b",
            dut.is_mov_from_control_unit);

    if (dut.is_lsl_from_control_unit !== 1'b0)
        $display("OF LSL               = %b",
            dut.is_lsl_from_control_unit);

    if (dut.is_lsr_from_control_unit !== 1'b0)
        $display("OF LSR               = %b",
            dut.is_lsr_from_control_unit);

    if (dut.is_asr_from_control_unit !== 1'b0)
        $display("OF ASR               = %b",
            dut.is_asr_from_control_unit);

    if (dut.is_nop_from_control_unit !== 1'b0)
        $display("OF NOP               = %b",
            dut.is_nop_from_control_unit);

    if (dut.is_load_from_control_unit !== 1'b0)
        $display("OF LOAD              = %b",
            dut.is_load_from_control_unit);

    if (dut.is_store_from_control_unit !== 1'b0)
        $display("OF STORE             = %b",
            dut.is_store_from_control_unit);

    if (dut.is_branch_equal_from_control_unit !== 1'b0)
        $display("OF BEQ               = %b",
            dut.is_branch_equal_from_control_unit);

    if (dut.is_branch_greater_from_control_unit !== 1'b0)
        $display("OF BGT               = %b",
            dut.is_branch_greater_from_control_unit);

    if (dut.is_unconditional_branch_from_control_unit !== 1'b0)
        $display("OF B                 = %b",
            dut.is_unconditional_branch_from_control_unit);

    if (dut.is_call_from_control_unit !== 1'b0)
        $display("OF CALL              = %b",
            dut.is_call_from_control_unit);

    if (dut.is_return_from_control_unit !== 1'b0)
        $display("OF RET               = %b",
            dut.is_return_from_control_unit);

    if (dut.is_write_back_from_control_unit !== 1'b0)
        $display("OF WB                = %b",
            dut.is_write_back_from_control_unit);

    if (dut.is_immediate_from_control_unit !== 1'b0)
        $display("OF IMMEDIATE         = %b",
            dut.is_immediate_from_control_unit);


    // ==================================================
    // EX STAGE
    // ==================================================
    $display("");
    $display("--- EX STAGE ---");

    if (dut.instruction_from_OFEX !== 32'b0)
        $display("EX instruction       = %h",
            dut.instruction_from_OFEX);

    if (dut.program_counter_from_OFEX !== 32'b0)
        $display("EX PC                = %h",
            dut.program_counter_from_OFEX);

    if (dut.first_operand_from_OFEX !== 32'b0)
        $display("EX first operand     = %h",
            dut.first_operand_from_OFEX);

    if (dut.second_operand_from_OFEX !== 32'b0)
        $display("EX second operand    = %h",
            dut.second_operand_from_OFEX);

    if (dut.immediate_from_OFEX !== 32'b0)
        $display("EX immediate         = %h",
            dut.immediate_from_OFEX);

    if (dut.branch_target_from_OFEX !== 32'b0)
        $display("EX branch target     = %h",
            dut.branch_target_from_OFEX);

    if (dut.is_mov_from_OFEX !== 1'b0)
        $display("EX MOV               = %b",
            dut.is_mov_from_OFEX);

    if (dut.is_immediate_from_OFEX !== 1'b0)
        $display("EX IMMEDIATE         = %b",
            dut.is_immediate_from_OFEX);

    if (dut.is_write_back_from_OFEX !== 1'b0)
        $display("EX WB                = %b",
            dut.is_write_back_from_OFEX);

    if (dut.alu_result_from_alu !== 32'b0)
        $display("EX ALU result        = %h",
            dut.alu_result_from_alu);

    if (dut.flags_equal_from_alu !== 1'b0)
        $display("EX equal flag        = %b",
            dut.flags_equal_from_alu);

    if (dut.flags_greater_from_alu !== 1'b0)
        $display("EX greater flag      = %b",
            dut.flags_greater_from_alu);


    // ==================================================
    // EXMA STAGE
    // ==================================================
    $display("");
    $display("--- EXMA STAGE ---");

    if (dut.instruction_from_EXMA !== 32'b0)
        $display("EXMA instruction     = %h",
            dut.instruction_from_EXMA);

    if (dut.alu_result_from_EXMA !== 32'b0)
        $display("EXMA ALU result      = %h",
            dut.alu_result_from_EXMA);

    if (dut.first_operand_from_EXMA !== 32'b0)
        $display("EXMA first operand   = %h",
            dut.first_operand_from_EXMA);

    if (dut.second_operand_from_EXMA !== 32'b0)
        $display("EXMA second operand  = %h",
            dut.second_operand_from_EXMA);

    if (dut.is_write_back_from_EXMA !== 1'b0)
        $display("EXMA WB              = %b",
            dut.is_write_back_from_EXMA);

    if (dut.is_load_from_EXMA !== 1'b0)
        $display("EXMA LOAD            = %b",
            dut.is_load_from_EXMA);

    if (dut.is_store_from_EXMA !== 1'b0)
        $display("EXMA STORE           = %b",
            dut.is_store_from_EXMA);


    // ==================================================
    // MARW / WRITEBACK
    // ==================================================
    $display("");
    $display("--- MARW / WRITEBACK STAGE ---");

    if (dut.instruction_from_MARW !== 32'b0)
        $display("MARW instruction     = %h",
            dut.instruction_from_MARW);

    if (dut.alu_result_from_MARW !== 32'b0)
        $display("MARW ALU result      = %h",
            dut.alu_result_from_MARW);

    if (dut.load_result_from_MARW !== 32'b0)
        $display("MARW load result     = %h",
            dut.load_result_from_MARW);

    if (dut.is_write_back_from_MARW !== 1'b0)
        $display("MARW WB              = %b",
            dut.is_write_back_from_MARW);

    if (dut.is_load_from_MARW !== 1'b0)
        $display("MARW LOAD            = %b",
            dut.is_load_from_MARW);

    if (dut.is_call_from_MARW !== 1'b0)
        $display("MARW CALL            = %b",
            dut.is_call_from_MARW);

    if (dut.write_port_from_write_address_mux !== 4'b0)
        $display("WRITE PORT           = %d",
            dut.write_port_from_write_address_mux);

    if (dut.write_data_from_write_data_mux !== 32'b0)
        $display("WRITE DATA           = %h",
            dut.write_data_from_write_data_mux);


    // ==================================================
    // REGISTER FILE
    // ==================================================
    $display("");
    $display("--- REGISTERS ---");

    if (dut.register_file.registers[0] !== 32'b0)
        $display("R0   = %h", dut.register_file.registers[0]);

    if (dut.register_file.registers[1] !== 32'b0)
        $display("R1   = %h", dut.register_file.registers[1]);

    if (dut.register_file.registers[2] !== 32'b0)
        $display("R2   = %h", dut.register_file.registers[2]);

    if (dut.register_file.registers[3] !== 32'b0)
        $display("R3   = %h", dut.register_file.registers[3]);

    if (dut.register_file.registers[4] !== 32'b0)
        $display("R4   = %h", dut.register_file.registers[4]);

    if (dut.register_file.registers[5] !== 32'b0)
        $display("R5   = %h", dut.register_file.registers[5]);

    if (dut.register_file.registers[6] !== 32'b0)
        $display("R6   = %h", dut.register_file.registers[6]);

    if (dut.register_file.registers[7] !== 32'b0)
        $display("R7   = %h", dut.register_file.registers[7]);

    if (dut.register_file.registers[8] !== 32'b0)
        $display("R8   = %h", dut.register_file.registers[8]);

    if (dut.register_file.registers[9] !== 32'b0)
        $display("R9   = %h", dut.register_file.registers[9]);

    if (dut.register_file.registers[10] !== 32'b0)
        $display("R10  = %h", dut.register_file.registers[10]);

    if (dut.register_file.registers[11] !== 32'b0)
        $display("R11  = %h", dut.register_file.registers[11]);

    if (dut.register_file.registers[12] !== 32'b0)
        $display("R12  = %h", dut.register_file.registers[12]);

    if (dut.register_file.registers[13] !== 32'b0)
        $display("R13  = %h", dut.register_file.registers[13]);

    if (dut.register_file.registers[14] !== 32'b0)
        $display("R14  = %h", dut.register_file.registers[14]);

    if (dut.register_file.registers[15] !== 32'b0)
        $display("R15  = %h", dut.register_file.registers[15]);

    cycle = cycle + 1;
end


// --------------------------------------------------
// helper: run N cycles
// --------------------------------------------------
task run_cycles(input integer n);
    integer i;
    begin
        for (i = 0; i < n; i = i + 1)
            @(posedge clk);

        #1;
    end
endtask


// --------------------------------------------------
// helper: check register
// --------------------------------------------------
task check_register(
    input integer reg_no,
    input logic [31:0] expected
);
    begin
        if (dut.register_file.registers[reg_no] !== expected) begin
            $display(
                "FAIL: R%0d = %h, expected %h",
                reg_no,
                dut.register_file.registers[reg_no],
                expected
            );
        end
        else begin
            $display(
                "PASS: R%0d = %h",
                reg_no,
                dut.register_file.registers[reg_no]
            );
        end
    end
endtask


initial begin

    clk   = 0;
    reset = 1;
    cycle = 0;


    // --------------------------------------------------
    // clear instruction memory
    // --------------------------------------------------
    for (integer i = 0; i < 1024; i = i + 1)
        dut.instruction_memory.memory[i] = 32'b0;


    // --------------------------------------------------
    // PROGRAM
    //
    // dut.instruction_memory.memory[i] = ith instruction
    // MUL R3 R2 R1
    // --------------------------------------------------
    dut.instruction_memory.memory[0] =
        32'b00010_0_0011_0001_0010_00000000000000;

    // --------------------------------------------------
    // synchronous reset
    // --------------------------------------------------
    @(posedge clk);
    #1;

    reset = 0;


    // --------------------------------------------------
    // pre-fill registers AFTER reset
    // dut.register_file.registers[i] = val of ith register;
    // --------------------------------------------------
    dut.register_file.registers[1] = 32'd6;
    dut.register_file.registers[2] = 32'd7;


    // --------------------------------------------------
    // allow pipeline to execute program
    // --------------------------------------------------
    run_cycles(6);


    // --------------------------------------------------
    // FINAL REGISTER FILE
    // --------------------------------------------------

    $display("");
    $display("========== FINAL REGISTER FILE ==========");

    for (integer i = 0; i < 16; i = i + 1)
        if (dut.register_file.registers[i] !== 32'b0)
            $display(
                "R%0d = %h",
                i,
                dut.register_file.registers[i]
            );


    // --------------------------------------------------
    // FINAL CPU STATE
    // --------------------------------------------------

    $display("");
    $display("========== FINAL CPU STATE ==========");

    if (dut.program_counter_from_program_counter_manager !== 32'b0)
        $display(
            "PC = %h",
            dut.program_counter_from_program_counter_manager
        );

    if (dut.instruction_from_IFOF !== 32'b0)
        $display(
            "IFOF instruction = %h",
            dut.instruction_from_IFOF
        );

    if (dut.instruction_from_OFEX !== 32'b0)
        $display(
            "OFEX instruction = %h",
            dut.instruction_from_OFEX
        );

    if (dut.instruction_from_EXMA !== 32'b0)
        $display(
            "EXMA instruction = %h",
            dut.instruction_from_EXMA
        );

    if (dut.instruction_from_MARW !== 32'b0)
        $display(
            "MARW instruction = %h",
            dut.instruction_from_MARW
        );


    // --------------------------------------------------
    // CHECK
    // check_register(register_no, expected_value);
    // --------------------------------------------------
    check_register(3, 32'd42);

    $display("");
    $display("========== TEST COMPLETE ==========");

    $finish;
end

endmodule