module IFOF(
    input logic clk,
    input logic [31:0] instruction_in,
    input logic [31:0] program_counter_in,
    output logic [31:0] instruction_out,
    output logic [31:0] program_counter_out,
    output logic [3:0] destination_register,
    output logic [3:0] first_source_register,
    output logic [3:0] second_source_register
);

always_ff @( posedge clk ) begin
    instruction_out <= instruction_in;
    program_counter_out <= program_counter_in;
    destination_register <= instruction_in[26:23];
    first_source_register <= instruction_in[22:19];
    second_source_register <= instruction_in[18:15];
end

endmodule