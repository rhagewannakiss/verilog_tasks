`timescale 1ns / 1ps

module buffer_tb;

    parameter ADDRSIZE = 3;  // глубина 8
    parameter DATA_W   = 16;
    parameter ID_W     = 4;

    reg                clock;
    reg                reset;
    reg                read;
    reg                write;
    reg                clean;
    reg [ADDRSIZE-1:0] addr;
    reg [DATA_W-1:0]   data_in;
    reg [ID_W-1:0]     id;

    wire [DATA_W-1:0]  data_out;
    wire               val;

    // инстанцируем design under test
    buffer #(
        .ADDRSIZE(ADDRSIZE),
        .DATA_W(DATA_W),
        .ID_W(ID_W)
    ) dut (
        .clock(clock),
        .reset(reset),
        .read(read),
        .write(write),
        .clean(clean),
        .addr(addr),
        .data_in(data_in),
        .id(id),
        .data_out(data_out),
        .val(val)
    );

    initial begin
        clock = 0;
        forever #5 clock = ~clock; // 10 нс период
    end

    initial begin
        reset   = 1;
        read    = 0;
        write   = 0;
        clean   = 0;
        addr    = 0;
        data_in = 0;
        id      = 0;

        #20;
        reset = 0; // сброс закончен

        // 1: write, addr=0, id=0, data_in=123
        write   = 1;
        addr    = 0;
        id      = 0;
        data_in = 123;
        #10;

        // 2: write, addr=0, id=1, data_in=456
        addr    = 0;
        id      = 1;
        data_in = 456;
        #10;

        // 3: write, addr=1, id=2, data_in=789
        addr    = 1;
        id      = 2;
        data_in = 789;
        #10;

        write = 0;

        // 4: clean, addr=1
        clean = 1;
        addr  = 1;
        #10;
        clean = 0;

        // 5: read, addr=0, id=0
        read = 1;
        addr = 0;
        id   = 0;
        #10;
        // 6: ожидается: val = 0
        if (val === 1) $display("ERROR: 6 - val should be 0!");
        else           $display("OK: 6 - val=0");

        read = 0;
        #10;

        // 7: read, addr=0, id=1
        read = 1;
        addr = 0;
        id   = 1;
        #10;

        // 8: ожидается: val=1, data_out=456
        if (val && (data_out == 456))
            $display("OK: 8 - val=1 and data_out=456");
        else
            $display("ERROR: 8 - expected val=1, data_out=456, got val=%b, data_out=%d", val, data_out);

        read = 0;
        #10;

        // 9: read, addr=1, id=2
        read = 1;
        addr = 1;
        id   = 2;
        #10;
        // 10: ожидается: val=0
        if (!val)
            $display("OK: 10 - val=0");
        else
            $display("ERROR: 10 - val should be 0!");

        #20;
        $display("Test completed.");
        $finish;
    end

endmodule