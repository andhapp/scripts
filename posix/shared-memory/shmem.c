#include <stdio.h>
#include <sys/shm.h>
#include <sys/stat.h>

int main() {
	
	/* The identifier for the shared memory segment */
	int segment_id;
	
	/* a pointer to the shared memory segement */
	char *shared_memory;
	
	/* the size (in bytes) of the shared memory segement */
	const int size = 4096;
	
	/* allocate a shared memory segment */
	segment_id = shmget(IPC_PRIVATE, size, S_IRUSR | S_IWUSR);
	
	/* attach a shared memory segment */
	shared_memory = (char *) shmat(segment_id, NULL, 0);
	
	/* Write a message to shared memory segment */
	sprintf(shared_memory, "Hi there!");
	
	printf("*%s\n", shared_memory);
	
	/* deattach shared memory segement */
	shmdt(shared_memory);
	
	/* deattach shared memory segement */
	shmctl(segment_id, IPC_RMID, NULL);
	
	return 0;
	
}