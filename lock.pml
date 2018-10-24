#define MAX_THREADS 5
#define THREADS 3

#define islocked(x) (locked[x])

#define lock (islocked[0])
#define nolock (!lock)

bool choosing[MAX_THREADS];
int number[MAX_THREADS];

bool locked[MAX_THREADS];


int numcrit = 0;

ltl safe {[](numcrit < 2)};


active [THREADS] proctype agent(){

    int i;
    int j;
    int max;

retry:

    choosing[_pid] = 1;
    max = 0;
    for (i : 0..(MAX_THREADS - 1)) {
        if
        ::  (number[i] > max) -> max = number[i];
        ::  else -> skip;
        fi
    }

    number[_pid] = max + 1;
    choosing[_pid] = 0;

    for (j : 0..(MAX_THREADS - 1)) {
        (choosing[j] == 0) /* await each process to not be choosing a number */
        (!((number[j] != 0) && ((number[j] < number[_pid]) || ((number[j] == number[_pid]) && (j < _pid)))))
    }

    numcrit++;

    locked[_pid] = 1;   /* have lock */

    locked[_pid] = 0;

    numcrit--;

release:
    number[_pid] = 0;

    goto retry;
}
