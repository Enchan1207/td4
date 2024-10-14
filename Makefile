SOURCE_DIR := src
TESTS_DIR := tests

SIM_DIR := sim

IVERILOG := iverilog

# testsディレクトリにある *.test.v をコンパイル対象とする
OUT_FILES := $(patsubst $(TESTS_DIR)/%.test.v, $(SIM_DIR)/%.out, $(wildcard $(TESTS_DIR)/*.test.v))
all: $(OUT_FILES)

$(SIM_DIR)/%.out: $(TESTS_DIR)/%.test.v $(SOURCE_DIR)/%.v
	@mkdir -p $(SIM_DIR)
	$(IVERILOG) -I $(SOURCE_DIR) -o $@ $<

test: all
	@for tb in $(OUT_FILES); do \
		echo "Running $$tb..."; \
		$$tb; \
	done

clean:
	@find . -name "*.out" -o -name "*.vcd" | xargs -I {} rm -f {}

.PHONY: clean all test
