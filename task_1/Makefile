MODULE = task_1.v
TESTBENCH = task_1_tb.v
TARGET = task_1
VCD_FILE = task_1.vcd

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

.PHONY: test view clean help