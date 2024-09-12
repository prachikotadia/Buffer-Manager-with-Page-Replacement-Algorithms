CC := gcc
CFLAGS := -g -Wall
LIBS := -lm

# Executables
EXECUTABLES := test1 test2

# Object files
OBJ_FILES := storage_mgr.o dberror.o buffer_mgr.o buffer_mgr_stat.o

# Source and header dependencies for tests
TEST1_DEPS := test_assign2_1.c dberror.h storage_mgr.h test_helper.h buffer_mgr.h buffer_mgr_stat.h
TEST2_DEPS := test_assign2_2.c dberror.h storage_mgr.h test_helper.h buffer_mgr.h buffer_mgr_stat.h

.PHONY: default clean run_test1 run_test2

default: $(EXECUTABLES)

test1: test_assign2_1.o $(OBJ_FILES)
	$(CC) $(CFLAGS) -o $@ $^ $(LIBS)

test2: test_assign2_2.o $(OBJ_FILES)
	$(CC) $(CFLAGS) -o $@ $^ $(LIBS)

test_assign2_1.o: $(TEST1_DEPS)
	$(CC) $(CFLAGS) -c $< $(LIBS)

test_assign2_2.o: $(TEST2_DEPS)
	$(CC) $(CFLAGS) -c $< $(LIBS)

buffer_mgr_stat.o: buffer_mgr_stat.c buffer_mgr_stat.h buffer_mgr.h
	$(CC) $(CFLAGS) -c $<

buffer_mgr.o: buffer_mgr.c buffer_mgr.h dt.h storage_mgr.h
	$(CC) $(CFLAGS) -c $<

storage_mgr.o: storage_mgr.c storage_mgr.h
	$(CC) $(CFLAGS) -c $< $(LIBS)

dberror.o: dberror.c dberror.h
	$(CC) $(CFLAGS) -c $<

clean:
	$(RM) $(EXECUTABLES) *.o *~

run_test1:
	./test1

run_test2:
	./test2
