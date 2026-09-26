module register_file(
    input logic clk,
    input logic reset,
    input logic [3:0] first_read_port,
    input logic [3:0] second_read_port,
    input logic is_write_back,
    input logic [3:0] write_port,
    input logic [31:0] write_data,
    output logic [31:0] first_operand,
    output logic [31:0] second_operand
);

logic [31:0] registers [0:15];

assign first_operand = registers[first_read_port];
assign second_operand = registers[second_read_port];

always_ff @(posedge clk) begin
    if (reset) begin
    //synchronous reset
        for (int i = 0; i < 16; i++)
            registers[i] <= 32'b0;
    end
    else if (is_write_back) begin
        registers[write_port] <= write_data;
    end
end

endmodule