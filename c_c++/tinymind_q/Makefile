qformat_test: test.cpp
	g++ -o qformat_test --std=c++20 test.cpp 2>&1 | tee build.log

clean:
	rm -f qformat_test build.log

run: qformat_test
	./qformat_test