module buffer #(
    parameter ADDRSIZE = 4,   // разрядность шины адреса
    parameter DATA_W   = 32,  // разрядность данных
    parameter ID_W     = 8    // разрядность идентификатора
) (
    input  wire                clock,
    input  wire                reset,
    input  wire                read,
    input  wire                write,
    input  wire                clean,
    input  wire [ADDRSIZE-1:0] addr,
    input  wire [DATA_W-1:0]   data_in,
    input  wire [ID_W-1:0]     id,

    output reg  [DATA_W-1:0]   data_out,
    output reg                 val
);

    localparam DEPTH = 1 << ADDRSIZE;  // количество ячеек памяти, то есть глубина буфера равна 2^ADDRSIZE

    // для каждой строки храним признак заполненности, идентификатор и сами данные
    reg              mem_valid [0:DEPTH-1];
    reg [ID_W-1:0]   mem_id    [0:DEPTH-1];
    reg [DATA_W-1:0] mem_data  [0:DEPTH-1];

    integer i; // нужен для прохода по буферу при сбросе

    always @(posedge clock) begin
        if (reset) begin
            // при сбросе помечаем все строки как пустые
            for (i = 0; i < DEPTH; i = i + 1) begin
                mem_valid[i] <= 1'b0;
            end
        end else begin
            // по условию write, read и clean не активны одновременно,
            // поэтому здесь достаточно обычного приоритета if / else if
            if (write) begin
                // запись полностью обновляет строку по выбранному адресу:
                // сохраняем данные, id и выставляем флаг заполненности
                mem_valid[addr] <= 1'b1;
                mem_id[addr]    <= id;
                mem_data[addr]  <= data_in;
            end else if (clean) begin
                // очистка сбрасывает только признак заполненности строки
                mem_valid[addr] <= 1'b0;
            end
        end
    end

    // чтение делаем синхронным: результат появляется на следующий такт после read
    always @(posedge clock) begin
        if (reset) begin
            val      <= 1'b0;
            data_out <= {DATA_W{1'b0}};
        end else begin
            if (read) begin
                // выдаём данные только если строка заполнена
                // и сохранённый id совпадает с входным id
                if (mem_valid[addr] && (mem_id[addr] == id)) begin
                    val      <= 1'b1;
                    data_out <= mem_data[addr];
                end else begin
                    // промах: строка либо пуста, либо относится к другому id
                    val      <= 1'b0;
                    data_out <= {DATA_W{1'b0}};
                end
            end else begin
                // если чтение не запрашивалось, val держим в нуле,
                // чтобы успешное чтение давало импульс длиной ровно в один такт
                val <= 1'b0;
            end
        end
    end

endmodule