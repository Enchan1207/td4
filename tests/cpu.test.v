`timescale 1us/1ns
`include "cpu.v"
`include "progmem.v"

module cpu_test ();
    reg CLK = 0;
    reg CLR = 1;

    wire [3:0] address;
    wire [7:0] data;

    reg [3:0] cpuInput = 0;
    wire [3:0] cpuOutput;

    TD4 cpu (.CLK(CLK), .CLR(CLR), .A(address), .D(data), .IN(cpuInput), .OUT(cpuOutput));

    ProgramMemory progmem(.A(address), .D(data));

    initial begin
        $dumpfile("cpu_test.vcd");
        $dumpvars(0, cpu_test);

        cpuInput <= 4'hD;
        #3;
        if(cpuOutput != 4'hD) begin
            $fatal(1, "Invalid output");
        end

        $finish();
    end

    always #0.5 CLK <= ~CLK;

endmodule
