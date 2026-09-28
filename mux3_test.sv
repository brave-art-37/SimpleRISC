module test;

    logic [31:0] a[0:7];
    logic s[0:2];
    logic [31:0] c;

    mux3 #(.WIDTH(32)) dut(
        .a(a),
        .s(s),
        .c(c)
    );

    initial begin

        a[0] = 32'h00000000;
        a[1] = 32'h11111111;
        a[2] = 32'h22222222;
        a[3] = 32'h33333333;
        a[4] = 32'h44444444;
        a[5] = 32'h55555555;
        a[6] = 32'h66666666;
        a[7] = 32'h77777777;

        s[2] = 0; s[1] = 0; s[0] = 0;
        #1;
        $display("s=%b%b%b c=%h", s[2], s[1], s[0], c);

        s[2] = 0; s[1] = 0; s[0] = 1;
        #1;
        $display("s=%b%b%b c=%h", s[2], s[1], s[0], c);

        s[2] = 0; s[1] = 1; s[0] = 0;
        #1;
        $display("s=%b%b%b c=%h", s[2], s[1], s[0], c);

        s[2] = 0; s[1] = 1; s[0] = 1;
        #1;
        $display("s=%b%b%b c=%h", s[2], s[1], s[0], c);

        s[2] = 1; s[1] = 0; s[0] = 0;
        #1;
        $display("s=%b%b%b c=%h", s[2], s[1], s[0], c);

        s[2] = 1; s[1] = 0; s[0] = 1;
        #1;
        $display("s=%b%b%b c=%h", s[2], s[1], s[0], c);

        s[2] = 1; s[1] = 1; s[0] = 0;
        #1;
        $display("s=%b%b%b c=%h", s[2], s[1], s[0], c);

        s[2] = 1; s[1] = 1; s[0] = 1;
        #1;
        $display("s=%b%b%b c=%h", s[2], s[1], s[0], c);

        $finish;
    end

endmodule