// File: tb_four_bit_full_adder.v
// Testbench for the 4-bit Ripple Carry Full Adder
// Tests all 16 x 16 x 2 = 512 possible input combinations.

`timescale 1ns/1ps

module tb_four_bit_full_adder;

    reg  [3:0] A;
    reg  [3:0] B;
    reg        Cin;

    wire [3:0] Sum;
    wire       Cout;

    reg  [4:0] expected;
    integer i, j, k;
    integer errors;

    // DUT = Design Under Test
    four_bit_full_adder DUT (
        .A(A),
        .B(B),
        .Cin(Cin),
        .Sum(Sum),
        .Cout(Cout)
    );

    initial begin
        errors = 0;
        A = 4'b0000;
        B = 4'b0000;
        Cin = 1'b0;

        $display(" A     B    Cin | Cout Sum  | Expected | Status");
        $display("------------------------------------------------");

        for (i = 0; i < 16; i = i + 1) begin
            for (j = 0; j < 16; j = j + 1) begin
                for (k = 0; k < 2; k = k + 1) begin
                    A = i;
                    B = j;
                    Cin = k;

                    #10;

                    expected = {1'b0, A} + {1'b0, B} + Cin;

                    if ({Cout, Sum} !== expected) begin
                        errors = errors + 1;
                        $display("%b  %b   %b   |  %b   %b |   %b    | FAIL",
                                 A, B, Cin, Cout, Sum, expected);
                    end
                    else begin
                        $display("%b  %b   %b   |  %b   %b |   %b    | PASS",
                                 A, B, Cin, Cout, Sum, expected);
                    end
                end
            end
        end

        $display("------------------------------------------------");
        if (errors == 0)
            $display("TEST PASSED: All 512 test cases passed.");
        else
            $display("TEST FAILED: %0d error(s) found.", errors);

        $finish;
    end

endmodule
