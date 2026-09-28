module data_memory(
    input logic clk,
    input logic [31:0] address,
    input logic store_enable,
    input logic [31:0] store_data,
    output logic [31:0] read_data
);

logic [31:0] memory[0:(1<<10)-1];
// using 10-bits out of 32-bit address --> 2^10 addresses
// word addressible --> 2^10 words
// 1 word = 4 bytes --> 2^12 = 4KB memory

assign read_data = memory[address[11:2]]; //last 2 bits removed to get word index

always_ff @(posedge clk) begin
    if (store_enable)
        memory[address[9:0]] <= store_data;
end

endmodule