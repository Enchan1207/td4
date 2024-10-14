module ALU #(parameter N = 4) (
    input [N-1:0] A,
    input [N-1:0] B,
    output [N-1:0] Y,
    output C
);

    wire [N:0] answer;

    // この1ステートメントにどれくらいのロジックが詰まっていると思う?
    assign answer = A + B;
    assign Y = answer[N-1:0];
    assign C = answer[N];
    
endmodule
