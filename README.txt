RUNNING THE SCRIPT
=========================

1) To list the files and confirm that we are in the right directory, use ls.

2) To remove outdated compiled.o files, type "make clean".

3) Enter "make" to compile the "test_assign2_1.c" file together with all other project files. 

4) To run the "test_assign2_1.c" program, use "make run_test1".

5) To compile the custom test file "test_assign2_2.c," use "make test2".

6) To run the "test_assign2_2.c" program, use "make run_test2".


DESCRIPTION
=========================

In creating this Buffer manager, we have made sure that appropriate memory management is maintained by releasing any reserved space when it is feasible. We've put the CLOCK, LRU, and FIFO (First In First Out) page replacement algorithms into practice.


1. BUFFER POOL FUNCTIONS
=========================

The buffer pool functions manage a memory cache for a disk-based page file using the Storage Manager. 

- `initBufferPool` creates a new buffer pool, specifying its size, the disk page file to cache, and the page replacement strategy (FIFO, LRU, LFU, CLOCK), along with optional strategy parameters.

- `shutdownBufferPool` terminates the buffer pool, releasing all associated resources. It ensures all modified pages are written back to disk, unless pages are still in use, in which case an error is thrown.

- `forceFlushPool` commits all modified and unused pages in the buffer pool back to the disk page file, ensuring data consistency between memory and disk storage.


2. PAGE MANAGEMENT FUNCTIONS
=========================

Page management functions facilitate transferring pages between a disk-based page file and a memory buffer pool.

- `pinPage` loads a specified page from the disk into the buffer pool. It checks for available space or utilizes a page replacement algorithm (FIFO, LRU, LFU, CLOCK) to make room, ensuring that any replaced page is saved to disk if modified.

- `unpinPage` releases a page from active use in the buffer pool, decreasing its usage count and making it eligible for replacement if not needed further.

- `makeDirty` marks a page in the buffer pool as modified, indicating that its content needs to be written back to the disk to ensure consistency.

- `forcePage` explicitly writes the contents of a given page back to the disk, updating the disk-based page file to match the buffer pool's version of the page.

3. STATISTICS FUNCTIONS
=========================

- `getFrameContents` Returns an array indicating which pages are stored in each frame of the buffer pool, helping track page distribution.

- `getDirtyFlags` Provides a boolean array where each element flags whether the corresponding page frame is modified but not yet saved to disk.

- `getFixCounts` Offers an array of integers reflecting how many clients are using each page, indicating page popularity or usage intensity.

- `getNumReadIO` Counts the total read operations from disk into the buffer pool, measuring disk access efficiency.

- `getNumWriteIO` Tracks the total write operations from the buffer pool back to the disk, highlighting the frequency of data synchronization.


4. PAGE REPLACEMENT ALGORITHM FUNCTIONS
=========================

- `FIFO (First In First Out)` Replaces the oldest page in the buffer pool with a new one, functioning like a queue to maintain order of page entry and exit.

- `LFU (Least Frequently Used)` Prioritizes removal of the least accessed page, relying on access frequency to decide which page to replace, and employs a pointer to minimize iterations for subsequent replacements.

- `LRU (Least Recently Used)` Eliminates the page that has not been used for the longest period, using access recency as the criterion for page replacement, enhancing cache relevance.

- `CLOCK` Cycles through pages using a rotating pointer, sparing pages marked as recently used on its first pass, and replacing the first unmarked page it encounters, balancing between FIFO and LRU principles.


TEST CASES 2
===============
The source file test_assign2_2.c now has more test cases. This README file contains the instructions for running these test cases. The LFU and CLOCK page replacement techniques are tested in these test situations.
