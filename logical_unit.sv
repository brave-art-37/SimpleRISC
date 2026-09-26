module logical_unit(
    input logic [31:0] first_operand,
    input logic [31:0] second_operand,
    input logic is_or,
    input logic is_not,
    input logic is_and,
    output logic [31:0] result
);

logic [31:0] or_result;
logic [31:0] not_result;
logic [31:0] and_result;

always_comb begin
    result = 32'b0;

    or_result = first_operand | second_operand;
    not_result = ~first_operand;
    and_result = first_operand & second_operand;

    if (is_or)
        result = or_result;

    else if (is_not)
        result = not_result;

    else if (is_and)
        result = and_result;
end

endmodule