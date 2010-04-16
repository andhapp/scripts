#include <fcntl.h>
#include <stdio.h>
#include <stdlib.h>
#include <sys/types.h>
#include <unistd.h>
#include <string.h>

#define SOURCE		 	"source" 
#define DESTINATION "destination" 

#define TRUE  0
#define FALSE -1

// Method Declaration	
int file_exists(char *filename);
void initialise_line(char *line);
int get_file_descriptor(char *filename);

/* Main Method */
main() {

	int fd_src;
	int fd_dest;
	
	char buf[10];
	size_t nbytes;
	ssize_t bytes_read;
	ssize_t bytes_written;
	char line[1000];
	nbytes = sizeof(buf);
	
	initialise_line(line);
	
	fd_src 	= get_file_descriptor(SOURCE);
	fd_dest = get_file_descriptor(DESTINATION);
	
	if (fd_src == -1) {
			fprintf(stderr, "Cannot open source.txt. Try again later.\n");
	    exit(1);
	} else {
		while((bytes_read = read(fd_src, buf, nbytes)) != 0) {
			strcpy(line, strcat(line, buf));
			strcpy(buf, "");
		}
		bytes_written = write(fd_dest, line, strlen(line));
	}

}

/* Checks if the file exists */
int file_exists(char *filename) {
	int result;
	result = access(filename, F_OK);
	return result;
}

/* Performs checks and creates a file descriptor */
int get_file_descriptor(char *filename) {
	int fd;
	if (file_exists(filename) == TRUE) {
		fd	= open(filename, O_RDWR, S_IRUSR | S_IWUSR | S_IRGRP | S_IROTH);
	} else {
		fd 	= open(filename, O_RDWR | O_CREAT | O_EXCL, S_IRUSR | S_IWUSR | S_IRGRP | S_IROTH);
	}
	return fd;
}

/* Initialises line giving an impression of creating an empty string */
void initialise_line(char *line) {
	strcpy(line, "");
}
