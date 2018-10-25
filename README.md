# Assignment

## Question part
Found in english.md


## Verification

### Contents
- [Safety](#Safety)
- [Deadlock free](#Deadlock)
- [Starvation free](#Starvation)
- [liveness](#Liveness)

### Safety

Proven by asserting no more than 1 thread is in the critical section at a time.

### Deadlock

Any system that is starvation free is deadlock free

### Starvation

Proven by asserting the following ltl:
```promella
ltl starvefree {[]( (wanting[0]) -> (<> ( locked[0] ) ) )};
```
This says that if a thread wants the lock it will eventually have the lock

### Liveness

Liveness is proven by proving the system is starvation free.




#### Citation for definitions of liveness and deadlock/starvation:
https://en.wikipedia.org/wiki/Liveness
