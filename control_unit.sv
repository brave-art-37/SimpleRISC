module control_unit(
    input logic [31:0] instruction,
    input logic flags_equal,
    input logic flags_greater,
    output logic is_add,
    output logic is_sub,
    output logic is_mul,
    output logic is_div,
    output logic is_mod,
    output logic is_cmp,
    output logic is_and,
    output logic is_or,
    output logic is_not,
    output logic is_mov,
    output logic is_lsl,
    output logic is_lsr,
    output logic is_asr,
    output logic is_nop,
    output logic is_load,
    output logic is_store,
    output logic is_branch_taken,
    output logic is_branch_equal,
    output logic is_branch_greater,
    output logic is_unconditional_branch,
    output logic is_call,
    output logic is_return,
    output logic is_write_back,
    output logic is_immediate
);

logic [4:0] opcode;

assign opcode = instruction[31:27];

localparam logic [4:0] ADD = 5'd0;
localparam logic [4:0] SUB = 5'd1;
localparam logic [4:0] MUL = 5'd2;
localparam logic [4:0] DIV = 5'd3;
localparam logic [4:0] MOD = 5'd4;
localparam logic [4:0] CMP = 5'd5;
localparam logic [4:0] AND = 5'd6;
localparam logic [4:0] OR = 5'd7;
localparam logic [4:0] NOT = 5'd8;
localparam logic [4:0] MOV = 5'd9;
localparam logic [4:0] LSL = 5'd10;
localparam logic [4:0] LSR = 5'd11;
localparam logic [4:0] ASR = 5'd12;
localparam logic [4:0] NOP = 5'd13;
localparam logic [4:0] LD = 5'd14;
localparam logic [4:0] ST = 5'd15;
localparam logic [4:0] BEQ = 5'd16;
localparam logic [4:0] BGT = 5'd17;
localparam logic [4:0] B = 5'd18;
localparam logic [4:0] CALL = 5'd19;
localparam logic [4:0] RET = 5'd20;

always_comb begin

    is_add = 0;
    is_sub = 0;
    is_mul = 0;
    is_div = 0;
    is_mod = 0;
    is_cmp = 0;
    is_and = 0;
    is_or = 0;
    is_not = 0;
    is_mov = 0;
    is_lsl = 0;
    is_lsr = 0;
    is_asr = 0;
    is_nop = 0;
    is_load = 0;
    is_store = 0;
    is_branch_equal = 0;
    is_branch_greater = 0;
    is_unconditional_branch = 0;
    is_call = 0;
    is_return = 0;
    is_write_back = 1;
    is_immediate = 0;

    case (opcode)

        RET: begin
            is_return = 1;
        end

        NOP: begin
            is_nop = 1;
            is_write_back = 0;
        end

        CALL: begin
            is_call = 1;
        end

        B: begin
            is_unconditional_branch = 1;
            is_write_back = 0;
        end

        BEQ: begin
            is_branch_equal = 1;
            is_write_back = 0;
        end

        BGT: begin
            is_branch_greater = 1;
            is_write_back = 0;
        end

        ADD: begin
            is_add = 1;
            is_immediate = instruction[26];
        end

        SUB: begin
            is_sub = 1;
            is_immediate = instruction[26];
        end

        MUL: begin
            is_mul = 1;
            is_immediate = instruction[26];
        end

        DIV: begin
            is_div = 1;
            is_immediate = instruction[26];
        end

        MOD: begin
            is_mod = 1;
            is_immediate = instruction[26];
        end

        AND: begin
            is_and = 1;
            is_immediate = instruction[26];
        end

        OR: begin
            is_or = 1;
            is_immediate = instruction[26];
        end

        LSL: begin
            is_lsl = 1;
            is_immediate = instruction[26];
        end

        LSR: begin
            is_lsr = 1;
            is_immediate = instruction[26];
        end

        ASR: begin
            is_asr = 1;
            is_immediate = instruction[26];
        end

        CMP: begin
            is_cmp = 1;
            is_immediate = instruction[26];
            is_write_back = 0;
        end

        NOT: begin
            is_not = 1;
            is_immediate = instruction[26];
        end

        MOV: begin
            is_mov = 1;
            is_immediate = instruction[26];
        end

        LD: begin
            is_load = 1;
            is_immediate = 1;
        end

        ST: begin
            is_store = 1;
            is_immediate = 1;
            is_write_back = 0;
        end

    endcase

    is_branch_taken = (flags_equal && is_branch_equal) || (flags_greater && is_branch_greater) || is_unconditional_branch;

end

endmodule