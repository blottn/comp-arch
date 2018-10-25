verify:
	spin -a ./lock.pml
	gcc -o pan ./pan.c
	./pan -a -N starvefree
	./pan -a -N safe


clean:
	rm pan*
	rm *.tmp
