MODULE = get_second_highest_1.v
TESTBENCH = get_second_highest_1_tb.v
TARGET = get_second_highest_1
VCD_FILE = get_second_highest_1.vcd

$(TARGET): $(MODULE) $(TESTBENCH)
	iverilog -o $@ $^

test: $(TARGET)
	./$(TARGET)

clean:
	rm -f $(TARGET) $(VCD_FILE)

help:
	@echo "  test  - Compile and run testbench"
	@echo "  clean - Remove generated files"
	@echo "  help  - Show this help"

.PHONY: test clean help