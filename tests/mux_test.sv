module test;

    logic [1:0] a;
    logic [1:0] b;
    logic s;
    logic [1:0] c;

    mux #(.WIDTH(2)) dut (
        .a(a),
        .b(b),
        .s(s),
        .c(c)
    );

    initial begin
        a = 1;
        b = 3;
        s = 0;

        #1;

        $display("a=%d, b=%d, s=%d, c=%d", a, b, s, c);

        $finish;
    end

endmodule