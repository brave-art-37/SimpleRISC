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
    $display("========== CYCLE %0d ==========", cycle);

    // ----------------------------
    // pipeline instructions
    // ----------------------------
    $display("PC   = %h",
        dut.program_counter_from_program_counter_manager);

    $display("IFOF = %h",
        dut.instruction_from_IFOF);

    $display("OFEX = %h",
        dut.instruction_from_OFEX);

    $display("EXMA = %h",
        dut.instruction_from_EXMA);

    $display("MARW = %h",
        dut.instruction_from_MARW);


    // ----------------------------
    // EX stage controls
    // ----------------------------
    $display("");
    $display("--- EX STAGE ---");

    $display("EX MOV       = %b",
        dut.is_mov_from_OFEX);

    $display("EX IMMEDIATE = %b",
        dut.is_immediate_from_OFEX);

    $display("EX WB        = %b",
        dut.is_write_back_from_OFEX);

    $display("EX first operand  = %h",
        dut.first_operand_from_OFEX);

    $display("EX second operand = %h",
        dut.second_operand_from_OFEX);

    $display("EX immediate      = %h",
        dut.immediate_from_OFEX);

    $display("EX ALU result     = %h",
        dut.alu_result_from_alu);


    // ----------------------------
    // EXMA stage
    // ----------------------------
    $display("");
    $display("--- EXMA STAGE ---");

    $display("EXMA ALU result = %h",
        dut.alu_result_from_EXMA);

    $display("EXMA WB         = %b",
        dut.is_write_back_from_EXMA);


    // ----------------------------
    // MARW / writeback stage
    // ----------------------------
    $display("");
    $display("--- WRITEBACK STAGE ---");

    $display("MARW WB        = %b",
        dut.is_write_back_from_MARW);

    $display("MARW LOAD      = %b",
        dut.is_load_from_MARW);

    $display("MARW CALL      = %b",
        dut.is_call_from_MARW);

    $display("WRITE PORT     = %d",
        dut.write_port_from_write_address_mux);

    $display("WRITE DATA     = %h",
        dut.write_data_from_write_data_mux);


    // ----------------------------
    // register file
    // ----------------------------
    $display("");
    $display("--- REGISTERS ---");

    $display("R0   = %h  R1  = %h  R2  = %h  R3  = %h",
        dut.register_file.registers[0],
        dut.register_file.registers[1],
        dut.register_file.registers[2],
        dut.register_file.registers[3]);

    $display("R4   = %h  R5  = %h  R6  = %h  R7  = %h",
        dut.register_file.registers[4],
        dut.register_file.registers[5],
        dut.register_file.registers[6],
        dut.register_file.registers[7]);

    $display("R8   = %h  R9  = %h  R10 = %h  R11 = %h",
        dut.register_file.registers[8],
        dut.register_file.registers[9],
        dut.register_file.registers[10],
        dut.register_file.registers[11]);

    $display("R12  = %h  R13 = %h  R14 = %h  R15 = %h",
        dut.register_file.registers[12],
        dut.register_file.registers[13],
        dut.register_file.registers[14],
        dut.register_file.registers[15]);

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
    // MOV immediate -> R1
    // --------------------------------------------------

    dut.instruction_memory.memory[0] =
        32'b01001100010000001010101010101010;


    // --------------------------------------------------
    // synchronous reset
    // --------------------------------------------------
    @(posedge clk);
    #1;
    reset = 0;


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

    $display(
        "PC = %h",
        dut.program_counter_from_program_counter_manager
    );

    $display(
        "IFOF instruction = %h",
        dut.instruction_from_IFOF
    );

    $display(
        "OFEX instruction = %h",
        dut.instruction_from_OFEX
    );

    $display(
        "EXMA instruction = %h",
        dut.instruction_from_EXMA
    );

    $display(
        "MARW instruction = %h",
        dut.instruction_from_MARW
    );


    // --------------------------------------------------
    // CHECK
    // --------------------------------------------------

    check_register(1, 32'b1010101010101010);


    $display("");
    $display("========== TEST COMPLETE ==========");

    $finish;
end

endmodule