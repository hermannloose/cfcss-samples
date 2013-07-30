CFCSS_LIBRARY ?= ../cfcss-build/Debug+Asserts/lib/CFCSS.so
PASS_NAME ?= -instrument-blocks
OPT_DEBUG_OPTIONS ?= -debug -debug-pass=Structure

CLANG = clang
LLC = llc
LLVM_LINK = llvm-link
OPT = opt

all:
	$(CLANG) -o3 -g -o test test.c qsort.c printarray.c

clean:
	rm *.bc
	rm *.dot
	rm *.pdf
	rm *.s

o0:
	$(CLANG) -O0 -g -o test test.c qsort.c printarray.c

o3:
	$(CLANG) -O3 -g -o test test.c qsort.c printarray.c

%.bc: %.c
	$(CLANG) -g -c -emit-llvm -o $*.bc $*.c

%-instrumented.bc: %.bc $(CFCSS_LIBRARY)
	$(OPT) -load $(CFCSS_LIBRARY) $(OPT_DEBUG_OPTIONS) $(PASS_NAME) < $*.bc > $*-instrumented.bc

%-optimized.bc: %-instrumented.bc
	$(OPT) -simplifycfg -mem2reg -instcombine -dse < $*-instrumented.bc > $*-optimized.bc

%.s: %-optimized.bc
	$(LLC) -o $*.s $*-optimized.bc

%-instrumented.dot: %-instrumented.bc
	$(OPT) -dot-cfg < $*-instrumented.bc > /dev/null
	mv cfg.$*.dot $*-instrumented.dot

%-optimized.dot: %-optimized.bc
	$(OPT) -dot-cfg < $*-optimized.bc > /dev/null
	mv cfg.$*.dot $*-optimized.dot

%-callgraph.dot: %-instrumented.bc
	$(OPT) -dot-callgraph < $*-instrumented.bc > /dev/null
	mv callgraph.dot $*-callgraph.dot

%-instrumented.pdf: %-instrumented.dot
	dot -Tpdf $*-instrumented.dot > $*-instrumented.pdf

%-optimized.pdf: %-optimized.dot
	dot -Tpdf $*-optimized.dot > $*-optimized.pdf

%-callgraph.pdf: %-callgraph.dot
	dot -Tpdf $*-callgraph.dot > $*-callgraph.pdf

callgraphs: test-callgraph.pdf qsort-callgraph.pdf printarray-callgraph.pdf

whole_module.bc: test.bc qsort.bc printarray.bc
	$(LLVM_LINK) -o whole_module.bc $^

