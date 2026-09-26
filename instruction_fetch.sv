module instruction_fetch(
    input logic clk,
    input logic is_branch_taken,
    input logic [31:0] branch_program_counter,
    output logic [31:0] instruction
);

logic [31:0] current_program_counter;
logic [31:0] read_result;

program_counter pc(
    .branch_program_counter(branch_program_counter),
    .is_branch_taken(is_branch_taken),
    .clk(clk),
    .reset(1'b0),
    .current_program_counter(current_program_counter)
);

memory ram(
    .address(current_program_counter),
    .clk(clk),
    .write_enable(1'b0),
    .write_data(32'b0),
    .read_data(read_result)
);

always_ff @(posedge clk) begin
    instruction <= read_result;
end

endmodule