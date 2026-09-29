`timescale 1ns/1ps

module write_data_mux_tb;

logic is_load;
logic is_call;

logic [31:0] alu_result;
logic [31:0] load_result;
logic [31:0] program_counter;

logic [31:0] write_data;

write_data_mux dut(
    .is_load(is_load),
    .is_call(is_call),
    .alu_result(alu_result),
    .load_result(load_result),
    .program_counter(program_counter),
    .write_data(write_data)
);

initial begin

    alu_result = 32'hAAAAAAAA;
    load_result = 32'hBBBBBBBB;
    program_counter = 32'h00000100;

    // normal ALU write
    is_load = 0;
    is_call = 0;
    #10;

    if (write_data !== 32'hAAAAAAAA)
        $display("FAIL: ALU write, got %h", write_data);
    else
        $display("PASS: ALU write");

    // load
    is_load = 1;
    is_call = 0;
    #10;

    if (write_data !== 32'hBBBBBBBB)
        $display("FAIL: LOAD write, got %h", write_data);
    else
        $display("PASS: LOAD write");

    // call
    is_load = 0;
    is_call = 1;
    #10;

    if (write_data !== 32'h00000104)
        $display("FAIL: CALL write, got %h", write_data);
    else
        $display("PASS: CALL write");

    // both asserted -> mux selects a[3]
    is_load = 1;
    is_call = 1;
    #10;

    if (write_data !== 32'h00000000)
        $display("FAIL: LOAD+CALL, got %h", write_data);
    else
        $display("PASS: LOAD+CALL");

    $finish;
end

endmodule