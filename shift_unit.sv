module shift_unit(
    input logic [31:0] first_operand,
    input logic [31:0] second_operand,
    input logic is_lsl,
    input logic is_lsr,
    input logic is_asr,
    output logic [31:0] result
);

logic [31:0] logical_left_shift_result;
logic [31:0] logical_right_shift_result;
logic [31:0] arithematic_right_shift_result;

always_comb begin
    result = 32'b0;
    logical_left_shift_result = first_operand << second_operand;
    logical_right_shift_result = first_operand >> second_operand;
    arithematic_right_shift_result = $signed(first_operand) >>> second_operand;

    if (is_lsl) result = logical_left_shift_result;

    else if (is_lsr) result = logical_right_shift_result;

    else if (is_asr) result = arithematic_right_shift_result;
end

endmodule