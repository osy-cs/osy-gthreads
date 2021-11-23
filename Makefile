CFLAGS = -g -Wall

.PHONY: clean all

all: gttest

gttest: gthr.c main.c gtswtch.o gthr.h
	$(CC) -Wall -o $@ $^

.S.o:
	as -o $@ $^

clean:
	rm -f *.o gttest
