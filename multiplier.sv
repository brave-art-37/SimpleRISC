module multiplier(
    input logic [31:0] first_operand,
    input logic [31:0] second_operand,
    input logic is_mul,
    output logic [31:0] result
);

logic [63:0] multiplication_result;

always_comb begin
    result = 32'b0;
    multiplication_result = first_operand * second_operand;

    // low 32 bits
    if (is_mul)
        result = multiplication_result[31:0];
end

endmodule