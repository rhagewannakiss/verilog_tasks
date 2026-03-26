MODULE = task_2.v
TESTBENCH = task_2_tb.v
TARGET = task_2
VCD_FILE = task_2.vcd

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