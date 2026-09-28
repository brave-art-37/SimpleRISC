module test;

    logic [31:0] a[0:3];
    logic s[0:1];
    logic [31:0] c;

    mux2 #(.WIDTH(32)) dut(
        .a(a),
        .s(s),
        .c(c)
    );

    initial begin

        a[0] = 32'h00000000;
        a[1] = 32'h11111111;
        a[2] = 32'h22222222;
        a[3] = 32'h33333333;

        s[1] = 0; s[0] = 0;
        #1;
        $display("s=%b%b c=%h", s[1], s[0], c);

        s[1] = 0; s[0] = 1;
        #1;
        $display("s=%b%b c=%h", s[1], s[0], c);

        s[1] = 1; s[0] = 0;
        #1;
        $display("s=%b%b c=%h", s[1], s[0], c);

        s[1] = 1; s[0] = 1;
        #1;
        $display("s=%b%b c=%h", s[1], s[0], c);

        $finish;
    end

endmodule