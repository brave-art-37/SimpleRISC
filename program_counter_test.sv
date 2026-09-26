module test;

logic clk;
always #5 clk = ~clk;
//posedge = 5 15 25 ...

logic [31:0] branch_program_counter;
logic is_branch_taken;
logic [31:0] current_program_counter;
logic reset;


program_counter dut(
    .branch_program_counter(branch_program_counter),
    .is_branch_taken(is_branch_taken),
    .clk(clk),
    .reset(reset),
    .current_program_counter(current_program_counter)
);

initial begin
    clk = 0;

    branch_program_counter = 100;
    is_branch_taken = 0;
    reset = 1;

    #10; //t=10 change at halfcycle to respect setup/holdtime at posedge
    reset = 0;

    #10; //t=20
    $display("current_program_counter=%d, is_branch_taken=%d",
             current_program_counter, is_branch_taken);

    #10; //t=30 change at halfcycle to respect setup/holdtime at posedge
    $display("current_program_counter=%d, is_branch_taken=%d",
             current_program_counter, is_branch_taken);

    is_branch_taken = 1;

    #10; //t=40 change at halfcycle to respect setup/holdtime at posedge
    $display("current_program_counter=%d, is_branch_taken=%d",
             current_program_counter, is_branch_taken);

    reset = 1;

    #10; //t=50
    $display("current_program_counter=%d, is_branch_taken=%d, reset=%d",
             current_program_counter, is_branch_taken, reset);

    $finish;
end


endmodule