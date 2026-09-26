module divider(
    input logic [31:0] first_operand,
    input logic [31:0] second_operand,
    input logic is_div,
    input logic is_mod,
    output logic [31:0] result
);

logic [31:0] quotient;
logic [31:0] remainder;

always_comb begin
    quotient = 32'b0;
    remainder = 32'b0;
    result = 32'b0;

    // RISC-V convention for division by zero
    if (second_operand == 0) begin
        quotient = 32'hFFFFFFFF;
        remainder = first_operand;
    end
    else begin
        quotient = first_operand / second_operand;
        remainder = first_operand % second_operand;
    end

    if (is_div)
        result = quotient;
    else if (is_mod)
        result = remainder;
end

endmodule