all:
	clang -03 -g -o test test.c qsort.c printarray.c

clean:
	rm *.bc
	rm *.dot
	rm *.pdf
	rm *.s

o0:
	clang -O0 -g -o test test.c qsort.c printarray.c

o3:
	clang -O3 -g -o test test.c qsort.c printarray.c

%.bc: %.c
	clang -g -c -emit-llvm -o $*.bc $*.c

%-instrumented.bc: %.bc ../cfcss-build/Debug+Asserts/lib/CFCSS.so
	opt -load ../cfcss-build/Debug+Asserts/lib/CFCSS.so -debug -instrument-blocks < $*.bc > $*-instrumented.bc

%-optimized.bc: %-instrumented.bc
	opt -simplifycfg -mem2reg -instcombine -dse < $*-instrumented.bc > $*-optimized.bc

%.s: %-optimized.bc
	llc -o $*.s $*-optimized.bc

%-instrumented.dot: %-instrumented.bc
	opt -dot-cfg < $*-instrumented.bc > /dev/null
	mv cfg.$*.dot $*-instrumented.dot

%-optimized.dot: %-optimized.bc
	opt -dot-cfg < $*-optimized.bc > /dev/null
	mv cfg.$*.dot $*-optimized.dot

%-callgraph.dot: %-instrumented.bc
	opt -dot-callgraph < $*-instrumented.bc > /dev/null
	mv callgraph.dot $*-callgraph.dot

%-instrumented.pdf: %-instrumented.dot
	dot -Tpdf $*-instrumented.dot > $*-instrumented.pdf

%-optimized.pdf: %-optimized.dot
	dot -Tpdf $*-optimized.dot > $*-optimized.pdf

%-callgraph.pdf: %-callgraph.dot
	dot -Tpdf $*-callgraph.dot > $*-callgraph.pdf

callgraphs: test-callgraph.pdf qsort-callgraph.pdf printarray-callgraph.pdf

