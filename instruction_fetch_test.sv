module test;

    logic clk;
    logic is_branch_taken;
    logic [31:0] branch_program_counter;
    logic [31:0] instruction;

    instruction_fetch dut(
        .clk(clk),
        .is_branch_taken(is_branch_taken),
        .branch_program_counter(branch_program_counter),
        .instruction(instruction)
    );

    always #5 clk = ~clk;

    initial begin
        clk = 0;
        is_branch_taken = 0;
        branch_program_counter = 0;

        // instructions at addresses 0, 4, 8, 12
        dut.ram.stack[0]  = 32'h11111111;
        dut.ram.stack[4]  = 32'h22222222;
        dut.ram.stack[8]  = 32'h33333333;
        dut.ram.stack[12] = 32'h44444444;

        // instructions at branch target 40
        dut.ram.stack[40] = 32'hAAAAAAAA;
        dut.ram.stack[44] = 32'hBBBBBBBB;

        // wait for first instruction
        #10;
        $display("PC=%d instruction=%h",
                 dut.current_program_counter, instruction);

        // next sequential instruction
        #10;
        $display("PC=%d instruction=%h",
                 dut.current_program_counter, instruction);

        // next sequential instruction
        #10;
        $display("PC=%d instruction=%h",
                 dut.current_program_counter, instruction);

        // take branch to address 40
        branch_program_counter = 32'd40;
        is_branch_taken = 1;

        #10;

        is_branch_taken = 0;

        $display("PC=%d instruction=%h",
                 dut.current_program_counter, instruction);

        // next instruction after branch target
        #10;

        $display("PC=%d instruction=%h",
                 dut.current_program_counter, instruction);

        $finish;
    end

endmodule