all:
	clang -03 -g -o test test.c qsort.s printarray.c

o0:
	clang -O0 -g -o test test.c qsort.c printarray.c

o3:
	clang -O3 -g -o test test.c qsort.c printarray.c

qsort.bc: qsort.c
	clang -O3 -g -c -emit-llvm -o qsort.bc qsort.c

qsort.s: qsort.bc
	opt -load ../cfcss-test-build/Debug+Asserts/lib/CFCSS.so -debug -instrument-blocks < qsort.bc > qsort-instrumented.bc
	opt -simplifycfg -mem2reg -instcombine -dse < qsort-instrumented.bc > qsort-optimized.bc
	llc -o qsort.s qsort-optimized.bc

callgraphs: test.ps qsort.ps printarray.ps

cfgs:
	opt -dot-cfg < qsort-instrumented.bc > /dev/null
	mv cfg.qsort.dot qsort-instrumented.dot
	dot -Tpdf qsort-instrumented.dot > qsort-instrumented.pdf
	opt -simplifycfg -mem2reg -instcombine -dse < qsort-instrumented.bc > qsort-optimized.bc
	opt -dot-cfg < qsort-optimized.bc > /dev/null
	mv cfg.qsort.dot qsort-optimized.dot
	dot -Tpdf qsort-optimized.dot > qsort-optimized.pdf

test.dot: test.bc
	opt -dot-callgraph < test.bc > /dev/null
	mv callgraph.dot test.dot

test.pdf: test.dot
	dot -Tpdf test.dot > test.pdf

qsort.dot: qsort.bc
	opt -dot-callgraph < qsort.bc > /dev/null
	mv callgraph.dot qsort.dot

qsort.pdf: qsort.dot
	dot -Tpdf qsort.dot > qsort.pdf

printarray.dot: printarray.bc
	opt -dot-callgraph < printarray.bc > /dev/null
	mv callgraph.dot printarray.dot

printarray.pdf: printarray.dot
	dot -Tpdf printarray.dot > printarray.pdf
