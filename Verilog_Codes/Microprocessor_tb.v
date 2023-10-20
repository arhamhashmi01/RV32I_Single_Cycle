`timescale 1ns/1ps
module microprocessor_tb();
    reg clk;
    reg [31:0]instruction;
    reg rst;
    reg enable;
    wire[31:0] res_out;

    microprocessor u_microprocessor0
    (
        .clk(clk),
        .instruction(instruction),
        .rst(rst),
        .enable(enable)
    );

    initial begin
        clk = 0;
        rst = 1;
        enable = 0;
        #10;
        rst=0;
        enable = 0;
        #10;

        rst = 1;
        #120;
        #40;

        $finish;       
    end
     initial begin
       $dumpfile("microprocessor.vcd");
       $dumpvars(0,microprocessor_tb);
    end

    always begin
        #5 clk= ~clk;
    end
endmodule