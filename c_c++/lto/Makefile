#CFLAGS = -O3 -flto -fwhole-program -fargument-noalias-anything 

CFLAGS = -DNDEBUG -D_USEOMP_ -fopenmp  -march=corei7-avx -DAVX=1 -O3 -fargument-noalias-anything -flto -fwhole-program  -DREALTIME=0  -D_COMPILETIME_  -Werror -Waddress -Warray-bounds -Wchar-subscripts -Wenum-compare -Wcomment -Wformat -Wmain -Wmissing-braces -Wreorder -Wreturn-type -Wsequence-point -Wsign-compare -Wstrict-aliasing -Wstrict-overflow=1 -Wswitch -Wtrigraphs -Wuninitialized -Wunused-function -Wunused-label -Wunused-value -Wvolatile-register-var -Wclobbered -Wempty-body -Wignored-qualifiers -Wtype-limits -Wno-unused-result  -fPIC -DBLOCKED_MTMI=1 -D_TICTOC_ -std=c++0x

test:	test.o libexc.a
	g++ -o test $(CFLAGS) test.o libexc.a

libexc.a:	excgen.o
	ar -r libexc.a excgen.o

%.o:	%.cpp excgen.h
	g++ -c $(CFLAGS) $<

clean:
	rm -f *.o test

run:	test
	./test
