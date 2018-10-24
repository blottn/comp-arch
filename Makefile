verify:
	spin -a ./lock.pml
	gcc -o pan ./pan.c
	./pan -a -N deadfree

clean:
	rm pan*
	rm *.tmp
