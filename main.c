//***************************************************************************
//
// GThreads - preemptive threads in userspace. 
// Inspired by https://c9x.me/articles/gthreads/code0.html.
//
// Program created for subject OSMZ and OSY. 
//
// Michal Krumnikl, Dept. of Computer Sciente, michal.krumnikl@vsb.cz 2019
// Petr Olivka, Dept. of Computer Science, petr.olivka@vsb.cz, 2021
//
// Program simulates preemptice switching of user space threads. 
//
//***************************************************************************

#include <assert.h>
#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>
#include <errno.h>

#include "gthr.h"

#define COUNT 100

// Dummy function to simulate some thread work
void f( void ) {
    static int x;
    int count = COUNT;
    int id = ++x;

    while ( count-- )
    {
        printf( "F Thread id: %d count: %d\n", id, count );
        uninterruptibleNanoSleep( 0, 1000000 );

#if ( GT_PREEMPTIVE == 0 )
        gt_yield();
#endif
    }
}

// Dummy function to simulate some thread work
void g( void ) {
    static int x = 0;
    int count = COUNT;
    int id = ++x;

    while ( count-- )
    {
        printf( "G Thread id: %d count: %d\n", id, count );
        uninterruptibleNanoSleep( 0, 1000000 );

#if ( GT_PREEMPTIVE == 0 )
        gt_yield();
#endif
    }
}

int main(void) {
    gt_init();      // initialize threads, see gthr.c

    gt_go( f );     // set f() as first thread
    gt_go( f );     // set f() as second thread
    gt_go( g );     // set g() as third thread
    gt_go( g );     // set g() as fourth thread

    gt_start_scheduler(); // wait until all threads terminate
  
    printf( "Threads finished\n" );
}
