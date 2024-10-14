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

    localparam bitWidth = 4;

    // レジスタファイル (接続 0:レジスタA 1:レジスタB 2:入力ポート 3:プログラムカウンタ)
    wire [3:0] registerFileCS;
    wire [1:0] registerFileOE;
    wire [bitWidth-1:0] registerFileInput;
    wire [bitWidth-1:0] registerFileOutput;
    wire [bitWidth-1:0] registerFileInternalOutput[2:0];
    Register #(.bitWidth(bitWidth)) registerA (.CLK(CLK), .CLR(CLR), .CS(registerFileCS[0]), .D(registerFileInput), .Q(registerFileInternalOutput[0]));
    Register #(.bitWidth(bitWidth)) registerB (.CLK(CLK), .CLR(CLR), .CS(registerFileCS[1]), .D(registerFileInput), .Q(registerFileInternalOutput[1]));
    Register #(.bitWidth(bitWidth)) outputPort (.CLK(CLK), .CLR(CLR), .CS(registerFileCS[2]), .D(registerFileInput), .Q(OUT));
    ProgramCounter #(.bitWidth(bitWidth)) PC (.CLK(CLK), .CLR(CLR), .CS(registerFileCS[3]), .D(registerFileInput), .Q(registerFileInternalOutput[2]));
    DataSelector #(.bitWidth(bitWidth)) selector (
        .A(registerFileInternalOutput[0]),
        .B(registerFileInternalOutput[1]),
        .C(IN),
        .D(registerFileInternalOutput[2]),
        .OE(registerFileOE),
        .Y(registerFileOutput)
    );

    // ALU (接続 A:レジスタファイル出力 B:命令コード下位4ビット)
    reg aluCarryState = 0;
    wire aluCarrySignal;
    wire [bitWidth-1:0] aluOutput;
    ALU #(.bitWidth(bitWidth)) alu(
        .A(registerFileOutput),
        .B(D[bitWidth-1:0]),
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
    wire [bitWidth-1:0] internalDataBus;
    assign registerFileInput = internalDataBus; // レジスタファイルの出力を内部データバスに接続
    assign aluOutput = internalDataBus; // ALUの出力を内部データバスに接続

    always @(posedge CLK) begin
        aluCarryState <= aluCarrySignal;
    end

endmodule
