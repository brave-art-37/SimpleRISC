`timescale 1ns/1ps

module program_counter_manager_tb;

logic clk;
logic reset;
logic is_branch_taken;
logic [31:0] branch_program_counter;
logic [31:0] program_counter;

program_counter_manager dut(
    .clk(clk),
    .reset(reset),
    .is_branch_taken(is_branch_taken),
    .branch_program_counter(branch_program_counter),
    .program_counter(program_counter)
);

always #5 clk = ~clk;

initial begin
    clk = 0;
    reset = 1;
    is_branch_taken = 0;
    branch_program_counter = 0;

    // synchronous reset
    #10;

    if (program_counter !== 32'd0)
        $display("FAIL: reset, PC=%d", program_counter);
    else
        $display("PASS: reset, PC=%d", program_counter);

    // normal execution: PC -> PC + 4
    reset = 0;
    is_branch_taken = 0;

    #10;

    if (program_counter !== 32'd4)
        $display("FAIL: PC + 4, PC=%d", program_counter);
    else
        $display("PASS: PC + 4, PC=%d", program_counter);

    // another normal instruction
    #10;

    if (program_counter !== 32'd8)
        $display("FAIL: PC + 4 again, PC=%d", program_counter);
    else
        $display("PASS: PC + 4 again, PC=%d", program_counter);

    // branch
    branch_program_counter = 32'd100;
    is_branch_taken = 1;

    #10;

    if (program_counter !== 32'd100)
        $display("FAIL: branch, PC=%d", program_counter);
    else
        $display("PASS: branch, PC=%d", program_counter);

    // resume normal execution from branch target
    is_branch_taken = 0;

    #10;

    if (program_counter !== 32'd104)
        $display("FAIL: PC + 4 after branch, PC=%d", program_counter);
    else
        $display("PASS: PC + 4 after branch, PC=%d", program_counter);

    // branch again
    branch_program_counter = 32'd200;
    is_branch_taken = 1;

    #10;

    if (program_counter !== 32'd200)
        $display("FAIL: second branch, PC=%d", program_counter);
    else
        $display("PASS: second branch, PC=%d", program_counter);

    $finish;
end

endmodule