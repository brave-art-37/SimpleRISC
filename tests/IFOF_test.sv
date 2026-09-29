`timescale 1ns/1ps

module IFOF_tb;

    logic clk;

    logic [31:0] instruction_in;
    logic [31:0] program_counter_in;

    logic [31:0] instruction_out;
    logic [31:0] program_counter_out;

    logic [3:0] destination_register;
    logic [3:0] first_source_register;
    logic [3:0] second_source_register;

    IFOF dut(
        .clk(clk),
        .instruction_in(instruction_in),
        .program_counter_in(program_counter_in),
        .instruction_out(instruction_out),
        .program_counter_out(program_counter_out),
        .destination_register(destination_register),
        .first_source_register(first_source_register),
        .second_source_register(second_source_register)
    );

    always #5 clk = ~clk;

    initial begin

        clk = 0;

        // instruction:
        // destination = 7
        // first source = 5
        // second source = 3
        instruction_in = 32'b0;
        instruction_in[26:23] = 4'd7;
        instruction_in[22:19] = 4'd5;
        instruction_in[18:15] = 4'd3;

        program_counter_in = 32'd100;

        #10;

        if (instruction_out !== instruction_in)
            $display("FAIL: instruction_out = %h", instruction_out);
        else
            $display("PASS: instruction_out");

        if (program_counter_out !== 32'd100)
            $display("FAIL: program_counter_out = %d", program_counter_out);
        else
            $display("PASS: program_counter_out");

        if (destination_register !== 4'd7)
            $display("FAIL: destination_register = %d", destination_register);
        else
            $display("PASS: destination_register");

        if (first_source_register !== 4'd5)
            $display("FAIL: first_source_register = %d", first_source_register);
        else
            $display("PASS: first_source_register");

        if (second_source_register !== 4'd3)
            $display("FAIL: second_source_register = %d", second_source_register);
        else
            $display("PASS: second_source_register");


        // second instruction
        // destination = 12
        // first source = 9
        // second source = 2

        instruction_in = 32'b0;
        instruction_in[26:23] = 4'd12;
        instruction_in[22:19] = 4'd9;
        instruction_in[18:15] = 4'd2;

        program_counter_in = 32'd200;

        #10;

        if (instruction_out !== instruction_in)
            $display("FAIL: second instruction_out = %h", instruction_out);
        else
            $display("PASS: second instruction_out");

        if (program_counter_out !== 32'd200)
            $display("FAIL: second program_counter_out = %d", program_counter_out);
        else
            $display("PASS: second program_counter_out");

        if (destination_register !== 4'd12)
            $display("FAIL: second destination_register = %d", destination_register);
        else
            $display("PASS: second destination_register");

        if (first_source_register !== 4'd9)
            $display("FAIL: second first_source_register = %d", first_source_register);
        else
            $display("PASS: second first_source_register");

        if (second_source_register !== 4'd2)
            $display("FAIL: second second_source_register = %d", second_source_register);
        else
            $display("PASS: second second_source_register");

        $finish;

    end

endmodule