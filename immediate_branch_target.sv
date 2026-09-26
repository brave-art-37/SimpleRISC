module immediate_branch_target(
    input logic [31:0] instruction,
    input logic [31:0] program_counter,
    output logic [31:0] immediate,
    output logic [31:0] branch_target
);

logic [1:0] mode;
logic [15:0] half_immediate;
logic [26:0] offset;

always_comb begin

    mode = instruction[17:16];
    half_immediate = instruction[15:0];
    offset = instruction[26:0];

    if (mode == 2'b01) begin
        // u mode: fill upper half
        immediate = {half_immediate, 16'b0};
    end
    else if (mode == 2'b10) begin
        // h mode: sign extend lower half
        immediate = {{16{half_immediate[15]}}, half_immediate};
    end
    else begin
        // normal immediate
        immediate = {{16{half_immediate[15]}}, half_immediate};
    end

    // signed branch offset, word-aligned
    branch_target =
        program_counter + ({{5{offset[26]}}, offset} << 2);

end

endmodule