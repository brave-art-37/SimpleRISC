module program_counter_manager(
    input logic clk,
    input logic reset,
    input logic is_branch_taken,
    input logic [31:0] branch_program_counter,
    output logic [31:0] program_counter
);

logic [31:0] current_program_counter;
logic [31:0] next_program_counter;

assign program_counter = current_program_counter;

mux #(.WIDTH(32)) program_counter_mux(
    .a(current_program_counter + 32'd4), //next instruction
    .b(branch_program_counter), //jump or branch
    .s(is_branch_taken),
    .c(next_program_counter)
);

always_ff @(posedge clk) begin
    //synchronous reset
    current_program_counter <= reset ? 32'd0 : next_program_counter;
end


endmodule
