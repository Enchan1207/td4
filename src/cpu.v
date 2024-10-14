`include "alu.v"
`include "selector.v"
`include "decoder.v"
`include "program_counter.v"

module TD4 (
    input CLK,
    input CLR,

    input [7:0] D,
    output [3:0] A,

    input [3:0] IN,
    output [3:0] OUT
);

    // 内部データバスのビット長
    localparam N = 8;

    // レジスタファイル (接続 0:レジスタA 1:レジスタB 2:入力ポート 3:プログラムカウンタ)
    wire [3:0] registerFileCS;
    wire [1:0] registerFileOE;
    wire [N-1:0] registerFileInput;
    wire [N-1:0] registerFileOutput;
    wire [N-1:0] registerFileInternalOutput[2:0];
    Register #(.N(N)) registerA (.CLK(CLK), .CLR(CLR), .CS(registerFileCS[0]), .D(registerFileInput), .Q(registerFileInternalOutput[0]));
    Register #(.N(N)) registerB (.CLK(CLK), .CLR(CLR), .CS(registerFileCS[1]), .D(registerFileInput), .Q(registerFileInternalOutput[1]));
    Register #(.N(N)) outputPort (.CLK(CLK), .CLR(CLR), .CS(registerFileCS[2]), .D(registerFileInput), .Q(OUT));
    ProgramCounter #(.N(N)) PC (.CLK(CLK), .CLR(CLR), .CS(registerFileCS[3]), .D(registerFileInput), .Q(registerFileInternalOutput[2]));
    DataSelector #(.N(N)) selector (
        .A(registerFileInternalOutput[0]),
        .B(registerFileInternalOutput[1]),
        .C(IN),
        .D({N{1'b0}}),
        .OE(registerFileOE),
        .Y(registerFileOutput)
    );

    // ALU (接続 A:レジスタファイル出力 B:命令コード下位4ビット)
    reg aluCarryState = 0;
    wire aluCarrySignal;
    wire [N-1:0] aluInput;
    wire [N-1:0] aluOutput;
    ALU #(.N(N)) alu(
        .A(registerFileOutput),
        .B(aluInput),
        .Y(aluOutput),
        .C(aluCarrySignal)
    );

    // 命令デコーダ
    Decoder decoder(
        .A(D[7:4]),
        .C(aluCarryState),
        .OE(registerFileOE),
        .CS(registerFileCS)
    );

    // モジュール間の接続
    assign A = registerFileInternalOutput[2]; // 外部アドレスバスとPCの出力とを接続
    assign registerFileInput = aluOutput;
    assign aluInput = D[N-1:0]; // 外部データバスとALUの入力とを接続

    always @(posedge CLK) begin
        aluCarryState <= aluCarrySignal;
    end

endmodule
