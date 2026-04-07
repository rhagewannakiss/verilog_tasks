MODULE = buffer.v
TESTBENCH = buffer_tb.v
TARGET = buffer
VCD_FILE = buffer.vcd

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