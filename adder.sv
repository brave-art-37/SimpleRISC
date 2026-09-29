module adder(
    input logic [31:0] first_operand,
    input logic [31:0] second_operand,
    input logic is_add,
    input logic is_sub,
    input logic is_cmp,
    input logic is_load,
    input logic is_store,
    output logic [31:0] result,
    output logic flags_equal,
    output logic flags_greater
);

logic [31:0] addition;
logic [31:0] subtraction;
logic comparison_equal;
logic comparison_greater;


always_comb begin
    result = 32'b0;
    flags_equal = 0;
    flags_greater = 0;

    addition = first_operand + second_operand;
    subtraction = first_operand - second_operand;
    comparison_equal = (first_operand == second_operand);
    comparison_greater = (first_operand > second_operand);

    if (is_add | is_load | is_store)
        result = addition;

    else if (is_sub)
        result = subtraction;

    else if (is_cmp) begin
        flags_equal = comparison_equal;
        flags_greater = comparison_greater;
    end
end

endmodule