module tb;
    reg  [7:0] vec;
    wire [2:0] pos;

    get_second_highest_1 #(.WIDTH(8)) dut (
        .vector_i   ( vec ),
        .position_o ( pos )
    );

    initial begin
        vec = 8'b1010_1000; // 7,5,3 -> 5
        #10;
        $display("vec=%b, position_o=%0d (expect 5)", vec, pos);

        vec = 8'b0000_0110; // 2,1 -> 1
        #10;
        $display("vec=%b, position_o=%0d (expect 1)", vec, pos);

        vec = 8'b1100_0000; // 7,6 -> 6
        #10;
        $display("vec=%b, position_o=%0d (expect 6)", vec, pos);

        vec = 8'b0000_1111; // 3,2,1,0 -> 2
        #10;
        $display("vec=%b, position_o=%0d (expect 2)", vec, pos);

        vec = 8'b0100_0000;
        #10;
        $display("vec=%b, position_o=%0d (expect 0)", vec, pos);

        vec = 8'b0000_0000;
        #10;
        $display("vec=%b, position_o=%0d (expect 0)", vec, pos);


        $finish;
    end

endmodule