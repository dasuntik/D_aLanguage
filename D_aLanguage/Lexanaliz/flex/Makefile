MAKE=make
GCC=gcc


BINDIR="./bin"
BINFILE="detector.bin"
TESTDIR="../../testfiles"
TEST_OK_FILE="test_ok.txt"
TEST_NOOK_FILE="test_nok.txt"

all: clean
	@$(MAKE) -s detector.bin 
	@$(MAKE) -s test_ok
	@$(MAKE) -s test_nok
	@if [ $(PRINT_OUTPUT) ]; then cat $(BINDIR)/$(TEST_OK_FILE).report; fi
	@if [ $(PRINT_OUTPUT) ]; then cat $(BINDIR)/$(TEST_NOOK_FILE).report; fi

%.bin: ./detector.lex
	@flex $<
	@$(GCC) $(GCCOPTS) lex.yy.c
	@mv a.out $(BINDIR)/$@

test_ok:
	@./$(BINDIR)/detector.bin < $(TESTDIR)/$(TEST_OK_FILE) >$(BINDIR)/$(TEST_OK_FILE).report
test_nok:
	@./$(BINDIR)/detector.bin < $(TESTDIR)/$(TEST_NOOK_FILE) >$(BINDIR)/$(TEST_NOOK_FILE).report


clean:
	@rm -rf $(BINDIR)/*