module mux #(
    parameter WIDTH = 1
)
(
    input logic [WIDTH-1:0] a,
    input logic [WIDTH-1:0] b,
    input logic s,
    output logic [WIDTH-1:0] c
);

assign c = s ? b : a;

endmodule