#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <dirent.h>
#include <unistd.h>
#include <sys/stat.h>
#include <time.h>



#define DEFAULT_RECIPE_DIR "/usr/bin/recipes"
#define EXT ".rsc"
#define EXT_LEN 4
#define DEFAULT_EDITOR "micro"


/* ANSI Color Pallete */
#define C_RESET		"\033[0m"
#define C_BOLD		"\033[1m"
#define C_DIM		"\033[2m"
#define C_RED		"\033[31m"
#define C_GREEN		"\033[32m"
#define C_YELLOW	"\033[33m"
#define C_BLUE		"\033[34m"
#define C_MAGENTA	"\033[35m"
#define C_CYAN		"\033[36m"
#define C_WHITE		"\033[37m"





typedef struct {
	char **items;
	size_t count;
	size_t capacity;
} StrList;

static void list_init(StrList *l) {
	l->capacity = 64;
	l->count = 0;
	l->items = malloc(l->capacity * sizeof(char *));
}

static void list_push(StrList *l, const char *str) {
	if (l->count >= l->capacity) {
		l->capacity *= 2;
		l->items = realloc(l->items, l->capacity * sizeof(char *));
	}
	l->items[l->count++] = strdup(str);
}

static void list_free(StrList *l) {
	for (size_t i = 0; i < l->count; i++) free(l->items[i]);
	free(l->items);
}

static int str_cmp(const void *a, const void *b) {
	return strcmp(*(const char **)a, *(const char **)b);
}

static void open_in_editor(const char *dir, const char *pkg) {
	const char *editor = getenv("EDITOR");
	if (!editor || *editor == '\0') {
		editor = DEFAULT_EDITOR;
	}

	char filepath[1024];
	snprintf(filepath, sizeof(filepath), "%s/%s.rsc", dir, pkg);

	printf(C_CYAN "-> Opening " C_BOLD "%s" C_RESET C_CYAN " with " C_GREEN "%s" C_RESET C_CYAN "..." C_RESET "\n", filepath, editor);
	char *args[] = { (char *)editor, filepath, NULL };
	execvp(editor, args);

	perror(C_RED "execvp failed" C_RESET);
	exit(1);
}

static void scan_recipes(const char *dir_path, const char *filter, StrList *out) {
	DIR *d = opendir(dir_path);
	if (!d) {
		perror(C_RED "opendir" C_RESET);
		exit(1);
	}

	struct dirent *ent;
	while ((ent = readdir(d)) != NULL) {
		size_t len = strlen(ent->d_name);
		if (len > EXT_LEN && strcmp(ent->d_name + (len - EXT_LEN), EXT) == 0) {
			size_t base_len = len - EXT_LEN;
			char base[256];
			if (base_len >= sizeof(base)) continue;
			memcpy(base, ent->d_name, base_len);
			base[base_len] = '\0';

			if (!filter || strstr(base, filter) != NULL) {
				list_push(out, base);
			}
		}
	}
	closedir(d);
	qsort(out->items, out->count, sizeof(char *), str_cmp);
}

static void print_columns(StrList *list) {
	for (size_t i = 0; i < list->count; i++) {
		printf(C_GREEN "%-20s" C_RESET, list->items[i]);
		if ((i + 1) % 4 == 0) printf("\n");
	}
	if (list->count % 4 != 0) printf("\n");
}


/* Husbandry: View recipe without opening full editor */
static void cat_recipe(const char *dir, const char *pkg) {
	char filepath[1024];
	snprintf(filepath, sizeof(filepath), "%s/%s.rsc", dir, pkg);

	FILE *f = fopen(filepath, "r");
	if (!f) {
		fprintf(stderr, C_RED "Error: Recipe '%s' does not exist.\n" C_RESET, filepath);
		exit(1);
	}

	printf(C_CYAN C_BOLD "=== %s.rsc ===" C_RESET "\n", pkg);
	char line[1024];
	while (fgets(line, sizeof(line), f)) {
		if (line[0] == '#') {
			printf(C_DIM "%s" C_RESET, line);
		} else if (strchr(line, '=')) {
			char *eq = strchr(line, '=');
			*eq = '\0';
			printf(C_YELLOW "%s" C_RESET "=" C_WHITE "%s" C_RESET, line, eq + 1);
		} else {
			printf("%s", line);
		}
	}
	fclose(f);
}

/* Husbandry: Inspect file stat details */
static void info_recipe(const char *dir, const char *pkg) {
	char filepath[1024];
	snprintf(filepath, sizeof(filepath), "%s/%s.rsc", dir, pkg);

	struct stat st;
	if (stat(filepath, &st) != 0) {
		fprintf(stderr, C_RED "Error: Cannot stat '%s'\n" C_RESET, filepath);
		exit(1);
	}

	FILE *f = fopen(filepath, "r");
	size_t lines = 0;
	if (f) {
		int ch;
		while ((ch = fgetc(f)) != EOF) {
			if (ch == '\n') lines++;
		}
		fclose(f);
	}

	char timebuf[64];
	struct tm *tm_info = localtime(&st.st_mtime);
	strftime(timebuf, sizeof(timebuf), "%y-%m-%d %H:%M:%S", tm_info);

	printf(C_CYAN C_BOLD "Package: " C_WHITE "%s\n" C_RESET, pkg);
	printf(C_CYAN "Path:    " C_RESET "%s\n", filepath);
	printf(C_CYAN "Size:	" C_GREEN "%ld bytes" C_RESET " (" C_YELLOW  "%zu lines" C_RESET ")\n", (long)st.st_size, lines);
	printf(C_CYAN "Modified:" C_RESET " %s\n", timebuf);

}

static void print_usage(const char *prog) {
	printf(C_BOLD "Usage:" C_RESET " %s [options] <recipe-name>\n\n", prog);
	printf(C_BOLD "Options:\n" C_RESET);
	printf("  " C_GREEN "-l, --list" C_RESET "			List all installed recipes\n");
	printf("  " C_GREEN "-c, --cat <pkg>" C_RESET "		Print recipe content to terminal\n");
	printf("  " C_GREEN "-i, --info <pkg>" C_RESET "	Display recipe stats and line count\n");
	printf("  " C_GREEN "-h, --help" C_RESET "			Show this help text\n");
}


int main(int argc, char *argv[]) {
	const char *dir = getenv("RECIPES");
	if (!dir) dir = DEFAULT_RECIPE_DIR;

	if (argc > 1) {
		if (strcmp(argv[1], "-h") == 0 || strcmp(argv[1], "--help") == 0) {
			print_usage(argv[0]);
			return 0;
		}
	
	/* Handle flag: 0l or --list */
	if (strcmp(argv[1], "-l") == 0 || strcmp(argv[1], "--list") == 0) {
		StrList all;
		list_init(&all);
		scan_recipes(dir, NULL, &all);
		printf(C_BOLD C_CYAN "Installed Recipes (%zu):\n" C_RESET, all.count);
		print_columns(&all);
		list_free(&all);
		return 0;
	}

	if (strcmp(argv[1], "-c") == 0 || strcmp(argv[1], "--cat") ==0) {
		if (argc < 3) {
			fprintf(stderr, C_RED "Error: Missing package name for --cat\n" C_RESET);
			return 1;
		}
		cat_recipe(dir, argv[2]);
		return 0;
	}

	if (strcmp(argv[1], "-i") == 0 || strcmp(argv[1], "--info") ==0) {
			if (argc < 3) {
				fprintf(stderr, C_RED "Error: Missing package name for --info\n" C_RESET);
				return 1;
			}
			info_recipe(dir, argv[2]);
			return 0;
		}
	}

	char query[256] = {0};

	if (argc > 1) {
		strncpy(query, argv[1], sizeof(query) - 1);
		/* Strip .rsc if typed manually */
		size_t qlen = strlen(query);
		if (qlen > EXT_LEN && strcmp(query + (qlen - EXT_LEN), EXT) ==0) {
			query[qlen - EXT_LEN] = '\0';
		}
	} else {
		printf(C_BOLD C_MAGENTA "--- Broth Recipe Editor ---" C_RESET "\n");
		printf("Enter recipe name, search term, or '" C_YELLOW "?" C_RESET "' to list all: ");
		fflush(stdout);
		if (!fgets(query, sizeof(query), stdin)) return 0;
		query[strcspn(query, "\r\n")] = '\0';
		if (strlen(query) == 0) return 0;
	}

	/* Check exact hit directly on disk first */
	char exact_check[1024];
	snprintf(exact_check, sizeof(exact_check), "%s/%s.rsc", dir, query);
	struct stat st;
	if (strcmp(query, "?") != 0 && stat(exact_check, &st) == 0) {
		open_in_editor(dir, query);
	}

	/* Perform scan with filter */
	StrList matches;
	list_init(&matches);
	scan_recipes(dir, strcmp(query, "?") == 0 ? NULL : query, &matches);

	if (matches.count == 0) {
		fprintf(stderr, C_RED "No recipes found matching '%s'\n" C_RESET, query);
		list_free(&matches);
		return 1;
	}

	if (matches.count == 1) {
		/* Single matching substring: jump straight in */
		char selected[256];
		strncpy(selected, matches.items[0], sizeof(selected) - 1);
		list_free(&matches);
		open_in_editor(dir, selected);
	}

	/* Multiple matches: interactive picker */
	printf("\n"C_CYAN C_BOLD "Matching recipes found (%zu):" C_RESET "\n", matches.count);
	for (size_t i = 0; i < matches.count; i++) {
		printf("  [%2zu] %s\n", i + 1, matches.items[i]);
	}

	printf("\nSelected index (" C_GREEN "1-%zu" C_RESET ") or '" C_RED 	"q" C_RESET "' to quit: ", matches.count);
	fflush(stdout);
	char choice[32];
	if (!fgets(choice, sizeof(choice), stdin)) {
		list_free(&matches);
		return 0;
	}

	if (choice[0] == 'q' || choice[0] == 'Q') {
		list_free(&matches);
		return 0;
	}

	int idx = atoi(choice);
	if (idx >= 1 && (size_t)idx <= matches.count) {
		char selected[256];
		strncpy(selected, matches.items[idx -1], sizeof(selected) - 1);
		list_free(&matches);
		open_in_editor(dir, selected);
	} else {
		fprintf(stderr, C_RED "Invalid selection.\n" C_RESET);
		list_free(&matches);
		return 1;
	}

	return 0;
}





