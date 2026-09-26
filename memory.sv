module memory(
    input logic [31:0] address,
    input logic clk,
    input logic write_enable,
    input logic [31:0] write_data,
    output logic [31:0] read_data
);

logic [31:0] stack[0:(1<<10)-1];
// using 12-bits out of 32-bit address --> 2^12 addresses
// 1 word = 4 bytes --> 2^10 words

assign read_data = stack[address[9:0]];

always_ff @(posedge clk) begin
    if (write_enable)
        stack[address[9:0]] <= write_data;
end

endmodule