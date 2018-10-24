run:
	spin -run ./lock.pml


verify:
	spin -a ./lock.pml
	gcc -o pan ./pan.c
	./pan -a
