module test;

    logic [31:0] instruction;
    logic [31:0] program_counter;

    logic [31:0] immediate;
    logic [31:0] branch_target;

    immediate_branch_target dut(
        .instruction(instruction),
        .program_counter(program_counter),
        .immediate(immediate),
        .branch_target(branch_target)
    );

    initial begin

        program_counter = 32'd100;

        // normal positive immediate
        instruction = 32'b0;
        instruction[17:16] = 2'b00;
        instruction[15:0] = 16'd25;

        #1;
        $display("normal positive: immediate=%d", immediate);


        // normal negative immediate
        instruction = 32'b0;
        instruction[17:16] = 2'b00;
        instruction[15:0] = -16'sd25;

        #1;
        $display("normal negative: immediate=%d", $signed(immediate));


        // H mode, positive
        instruction = 32'b0;
        instruction[17:16] = 2'b10;
        instruction[15:0] = 16'h1234;

        #1;
        $display("H positive: immediate=%h", immediate);


        // H mode, negative
        instruction = 32'b0;
        instruction[17:16] = 2'b10;
        instruction[15:0] = 16'hF234;

        #1;
        $display("H negative: immediate=%h", immediate);


        // U mode
        instruction = 32'b0;
        instruction[17:16] = 2'b01;
        instruction[15:0] = 16'h1234;

        #1;
        $display("U mode: immediate=%h", immediate);


        // branch: positive offset
        instruction = 32'b0;
        instruction[26:0] = 27'd5;

        #1;
        $display("branch positive: target=%d", branch_target);


        // branch: negative offset
        instruction = 32'b0;
        instruction[26:0] = 27'h7FFFFFC; // -4 in 27-bit two's complement

        #1;
        $display("branch negative: target=%d", $signed(branch_target));


        $finish;
    end

endmodule