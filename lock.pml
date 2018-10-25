#define MAX_THREADS 5
#define THREADS 2

#define islocked(x) (locked[x])

#define lock (islocked(0))
#define nolock (!lock)

bool choosing[MAX_THREADS];
int number[MAX_THREADS];

bool locked[MAX_THREADS];
bool wanting[MAX_THREADS];

int numcrit = 0;

ltl safe {[](numcrit <= 1)};
ltl starvefree {[]( (wanting[0]) -> (<> ( locked[0] ) ) )};

active [THREADS] proctype agent(){

    int i;
    int j;
    int max;
    int iter = 0;
retry:
    wanting[_pid] = 1;
    iter = iter + 1;

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

    atomic {
        numcrit++;
        locked[_pid] = 1;
        wanting[_pid] = 0;
    }

    atomic {
        locked[_pid] = 0;
        numcrit--;
    }

//release:

    number[_pid] = 0;

    if
    ::  (iter == 3) -> goto end;
    ::  else -> goto retry;
    fi
end:

}
