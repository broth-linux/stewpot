#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <time.h>
#include <dirent.h>
#include <unistd.h>

#define FORTUNE_DIR "/usr/share/fortune"
#define MAX_BUF 4096

static void print_random_fortune(const char *filepath) {
	FILE *f = fopen(filepath, "r");
	if (!f) return;

	/* First pass: count delimiters (%) */
	size_t count = 0;
	char line[MAX_BUF];
	while (fgets(line, sizeof(line), f)) {
		if (line[0] == '%' && (line[1] == '\n' || line [1] == '\r')) {
			count++;
		}
	}

	if (count ==0) {
		rewind(f);
		while (fgets(line, sizeof(line), f)) printf("%s", line);
		fclose(f);
		return;
	}

	/* Pick a random entry */
	srand((unsigned)time(NULL) ^ (unsigned)getpid());
	size_t target = rand() % (count + 1);

	/* Second pass: print selected fortune */
	rewind(f);
	size_t current = 0;
	while (fgets(line, sizeof(line), f)) {
		if (line[0] == '%' && (line[1] == '\n' || line[1] == '\r')) {
			current++;
			if (current > target) break;
			continue;
		}
		if (current == target) {
			fputs(line, stdout);
		}
	}

	fclose(f);
}

int main(int argc, char *argv[]) {
	const char *dir = FORTUNE_DIR;
	DIR *d = opendir(dir);
	if (!d) {
		fprintf(stderr, "fortune: directory %s not found\n", dir);
		return 1;
	}

	/* COllect raw text from fortune files (ignoring hidden files and.dat) */\
	char files[128][4096];
	size_t fcount = 0;
	struct dirent *ent;

	while ((ent = readdir(d)) != NULL && fcount < 128) {
		if (ent->d_name[0] == '.') continue;
		size_t len = strlen(ent->d_name);
		if (len > 4 && strcmp(ent->d_name + (len - 4), ".dat") == 0) continue;

		snprintf(files[fcount++], sizeof(files[0]), "%s/%s", dir, ent->d_name);
	}
	closedir(d);

	if (fcount == 0) {
		fprintf(stderr, "fortune: no fortune files found in %s\n", dir);
		return 1;
	}

	srand((unsigned)time(NULL) ^ (unsigned)getpid());
	const char *chosen_file = files[rand() % fcount];
	print_random_fortune(chosen_file);

	return 0;
}
