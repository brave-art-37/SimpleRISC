module instruction_memory (
    input logic [31:0] program_counter,
    output logic [31:0] instruction
);

logic [31:0] memory[0:(1<<10)-1];
// using 10-bits out of 32-bit address --> 2^10 addresses
// word addressible --> 2^10 words
// 1 word = 4 bytes --> 2^12 = 4KB memory

assign instruction = memory[program_counter[11:2]]; //last 2 bits removed to get word_index
    
endmodule