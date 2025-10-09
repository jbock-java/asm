CFLAGS += -Wall
CFLAGS += -pedantic-errors

draft: draft.c
	$(CC) $(CFLAGS) -fno-omit-frame-pointer -g -o draft $^

barf: draft.c
	$(CC) $(CFLAGS) -fno-omit-frame-pointer -S $^ | tee draft.s

debug: barf
	$(CC) -o draft draft.s -g

clean:
	@rm -f draft
