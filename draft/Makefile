CFLAGS += -D_GNU_SOURCE
CFLAGS += -Wall
CFLAGS += -pedantic-errors
CFLAGS += -Og

draft: draft.c
	$(CC) $(CFLAGS) -fno-omit-frame-pointer -g -o draft $^

barf: draft.c
	$(CC) $(CFLAGS) -fno-omit-frame-pointer -S $^ -o draft.s

debug: barf
	$(CC) -o draft draft.s -g

clean:
	@rm -f draft
