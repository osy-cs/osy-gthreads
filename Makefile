CFLAGS = -g -Wall

.PHONY: clean all

all: gttest

gttest: gthr.c main.c gtswtch.o gthr.h Makefile
	$(CC) -g -Wall $(filter %.c %.o, $^) -o $@

.S.o:
	as -o $@ $^

clean:
	rm -f *.o gttest
