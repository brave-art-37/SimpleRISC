module mux2 #(
    parameter WIDTH = 1
)
(
    input logic [WIDTH-1:0] a[0:3],
    input logic s[0:1],
    output logic [WIDTH-1:0] c
);

always_comb begin
    c = a[{s[1], s[0]}];
end

endmodule