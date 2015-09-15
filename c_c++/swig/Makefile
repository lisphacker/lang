MODULE = pyvec

all:	$(MODULE).so

$(MODULE).so:	$(MODULE)_wrap.cxx
	#g++ -shared -o _$(MODULE).so $(MODULE)_wrap.cxx `python-config --cflags --ldflags` -fPIC

$(MODULE)_wrap.cxx:	pyvec.i
	swig -module $(MODULE) -c++ -cffi pyvec.i

clean:
	rm -f *pyvec.py* *pyvec.o *pyvec.so *pyvec_wrap.cxx *pyvec.lisp

