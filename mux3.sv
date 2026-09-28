module mux3 #(
    parameter WIDTH = 1
)
(
    input logic [WIDTH-1:0] a[0:7],
    input logic s[0:2],
    output logic [WIDTH-1:0] c
);

always_comb begin
    c = a[{s[2], s[1], s[0]}];
end

endmodule