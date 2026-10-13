#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <unistd.h>
#include <termios.h>
#include <dirent.h>
#include <sys/stat.h>
#include <sys/ioctl.h>

#define MAX_FILES 1024
#define MAX_PATH 4096

typedef struct {
	char name[256];
	int is_dir;
} FileEntry;

static FileEntry files[MAX_FILES];
static int file_count = 0;
static int selected = 0;
static char cwd[MAX_PATH];
static struct termios orig_termios;

static void disable_raw_mode(void) {
	printf("\033[?25h\033[0m"); /* Show cursor, reset colors */
	tcsetattr(STDIN_FILENO, TCSAFLUSH, &orig_termios);
}

static void enable_raw_mode(void) {
	tcgetattr(STDIN_FILENO, &orig_termios);
	atexit(disable_raw_mode);

	struct termios raw = orig_termios;
	raw.c_lflag &= ~(ECHO | ICANON);
	tcsetattr(STDIN_FILENO, TCSAFLUSH, &raw);
	printf("\033[?25l"); /* Hide Cursor */
}

static int compare_entries(const void *a, const void *b) {
	const FileEntry *fa =a;
	const FileEntry *fb =b;
	if (fa->is_dir != fb->is_dir)
		return fb->is_dir - fa->is_dir; /* Dirs first */
	return strcasecmp(fa->name, fb->name);
}

static void load_dir(void) {
	file_count = 0;
	selected = 0;
	getcwd(cwd, sizeof(cwd));

	DIR *d = opendir(".");
	if (!d) return;

	struct dirent *dir;
	struct stat st;
	while ((dir = readdir(d)) != NULL && file_count < MAX_FILES) {
		if (strcmp(dir->d_name, ".") ==0) continue;

		 strncpy(files[file_count].name, dir->d_name, 255);
		 if (stat(dir->d_name, &st) == 0 && S_ISDIR(st.st_mode))
			files[file_count].is_dir = 1;
		else
			files[file_count].is_dir = 0;

		file_count++;
	}
	closedir(d);
	qsort(files, file_count, sizeof(FileEntry), compare_entries);
}

static void draw(void) {
	struct winsize ws;
	ioctl(STDOUT_FILENO, TIOCGWINSZ, &ws);

	/* Clear screen and mvoe cursor to home */
	printf("\033[2J\033[H");

	/* Header */
	printf("\033[1;34m[ %s ]\033[0m\n\n", cwd);

	int max_rows = ws.ws_row - 4;
	if (max_rows > file_count) max_rows = file_count;

	for (int i = 0; i < max_rows; i++) {
		if (i == selected)
			printf("\033[7m"); /* Reverse video / highlight */

		if (files[i].is_dir)
			printf("	%s/\033[0m\n", files[i].name);
		else
			printf("	%s\033[0m\n", files[i].name);
	}
	fflush(stdout);
}

int main(void) {
	enable_raw_mode();
	load_dir();
	draw();

	char c;
	while (read(STDOUT_FILENO, &c, 1) == 1 && c != 'q') {
			if (c == 'j' && selected < file_count - 1) {
				selected++;
			} else if (c == 'k' && selected > 0) {
				selected--;
			} else if (c == 'h') {
				chdir("..");
				load_dir();
			} else if (c == 'l' || c == '\n') {
				if (files[selected].is_dir) {
					chdir(files[selected].name);
					load_dir();
				}
			}
			draw();
	}
	return 0;
}
