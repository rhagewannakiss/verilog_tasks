module get_second_highest_1 #(
    parameter WIDTH = 8
) (
    input  [WIDTH-1:0]         vector_i,
    output [$clog2(WIDTH)-1:0] position_o
);

    localparam OUT_W = $clog2(WIDTH);  // сколько бит нужно для кодирования номера позиции, ширина выходной шины position_o

    genvar i, j;

    wire [WIDTH-1:0] fill1;
    // для каждой позиции i формируем признак, что в диапазоне от старшего бита до i есть хотя бы одна единица
    generate
        for (i = 0; i < WIDTH; i = i + 1) begin : b1
            assign fill1[i] = |vector_i[WIDTH-1:i];
        end
    endgenerate

    wire [WIDTH-1:0] is_msb1;
    // из fill1 получаем one-hot маску самой старшей единицы исходного вектора, далее захотим от нее избавиться
    generate
        for (i = 0; i < WIDTH; i = i + 1) begin : b2
            if (i == WIDTH-1)
                assign is_msb1[i] = fill1[i];
            else
                assign is_msb1[i] = fill1[i] & ~fill1[i+1];
        end
    endgenerate

    wire [WIDTH-1:0] vec2;
    assign vec2 = vector_i & ~is_msb1;  // убираем старшую единицу и ищем следующую

    wire [WIDTH-1:0] fill2;
    // повторяем ту же схему уже для вектора без самой старшей единицы
    generate
        for (i = 0; i < WIDTH; i = i + 1) begin : b3
            assign fill2[i] = |vec2[WIDTH-1:i];
        end
    endgenerate

    wire [WIDTH-1:0] is_msb2;
    // здесь выделяется вторая старшая единица исходного вектора, повторим те же дейсвтия
    generate
        for (i = 0; i < WIDTH; i = i + 1) begin : b4
            if (i == WIDTH-1)
                assign is_msb2[i] = fill2[i];
            else
                assign is_msb2[i] = fill2[i] & ~fill2[i+1];
        end
    endgenerate

    // преобразуем one-hot маску второй старшей единицы в номер её позиции
    generate
        for (j = 0; j < OUT_W; j = j + 1) begin : encode_bit
            wire [WIDTH-1:0] found;
            for (i = 0; i < WIDTH; i = i + 1) begin : encode_pos
                assign found[i] = is_msb2[i] & i[j];
            end
            assign position_o[j] = |found;
        end
    endgenerate

endmodule