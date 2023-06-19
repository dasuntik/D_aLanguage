MAKE=make
GCC=gcc

FILENAME=detector

PARSER_BIN="detector_parser"

ROOT_DIR=$(shell pwd)
INCDIR=/home/tuatar/Рабочий\ стол/D_aLanguage/Syntanaliz/yacc/inc
INCFILES=/home/tuatar/Рабочий\ стол/D_aLanguage/Syntanaliz/yacc/inc/prints.c /home/tuatar/Рабочий\ стол/D_aLanguage/Syntanaliz/yacc/inc/prk-stack.c
#LIBOBJS = $(wildcard $(LIBDIR)/*.o)
#LIBNAMES = $(shell basename -s ".o" $(LIBOBJS))
#LIBS = $(addprefix -l, $(LIBNAMES))

BINDIR="./bin"
TESTDIR="../../testfiles"
TEST_OK_FILE="test_ok.txt"
TEST_NOOK_FILE="test_nok.txt"

.PHONY: parser test_ok test_nok subclean clean all

all: clean parser test_ok test_nok
	@if [ $(PRINT_OUTPUT) ]; then cat $(BINDIR)/$(TEST_OK_FILE).report; fi
	@if [ $(PRINT_OUTPUT) ]; then cat $(BINDIR)/$(TEST_NOOK_FILE).report; fi


test:
	@echo $(ROOT_DIR)
	@echo $(LIBOBJS)
	@echo $(LIBNAMES)
	@echo $(LIBS)

parser:
	yacc -d $(FILENAME).y
	flex $(FILENAME).lex
	$(GCC) -I$(INCDIR) -c $(INCFILES)
	$(GCC) -I$(INCDIR) lex.yy.c y.tab.c prints.o prk-stack.o -o $(PARSER_BIN)
	@mv $(PARSER_BIN) $(BINDIR)/
#	@make -s subclean

test_ok:
	@cat "$(TESTDIR)/$(TEST_OK_FILE)" | ./$(BINDIR)/$(PARSER_BIN) > "$(BINDIR)/$(TEST_OK_FILE).report"
test_nok:
	@cat "$(TESTDIR)/$(TEST_NOOK_FILE)" | ./$(BINDIR)/$(PARSER_BIN) > "$(BINDIR)/$(TEST_NOOK_FILE).report"


subclean:
	@rm -rf lex.yy.c
	@rm -rf y.tab.h y.tab.c

clean: subclean
	@rm -rf $(BINDIR)/*