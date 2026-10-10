#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <dirent.h>
#include <unistd.h>
#include <sys/stat.h>

#define DEFAULT_RECIPE_DIR "/usr/bin/recipes"
#define EXT ".rsc"
#define EXT_LEN 4
#define DEFAULT_EDITOR "micro"
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

	printf("Opening %s with %s...\n", filepath, editor);
	char *args[] = { (char *)editor, filepath, NULL };
	execvp(editor, args);

	perror("execvp failed");
	exit(1);
}

static void scan_recipes(const char *dir_path, const char *filter, StrList *out) {
	DIR *d = opendir(dir_path);
	if (!d) {
		perror("opendir");
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
		printf("%-20s", list->items[i]);
		if ((i + 1) % 4 == 0) printf("\n");
	}
	if (list->count % 4 != 0) printf("\n");
}

int main(int argc, char *argv[]) {
	const char *dir = getenv("RECIPES");
	if (!dir) dir = DEFAULT_RECIPE_DIR;

	/* Handle flag: 0l or --list */
	if (argc > 1 && (strcmp(argv[1], "-l") == 0 || strcmp(argv[1], "--list") == 0)) {
		StrList all;
		list_init(&all);
		scan_recipes(dir, NULL, &all);
		print_columns(&all);
		list_free(&all);
		return 0;
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
		printf("--- Broth Recipe Editor ---\n");
		printf("Enter recipe name, search term, or '?' to list all: ");
		fflush(stdout);
		if (!fgets(query, sizeof(query), stdin)) return 0;
		query[strcspn(query, "\r\n")] = '\0';
		if (strlen(query) ==0) return 0;
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
		fprintf(stderr, "No recipes found matching '%s'\n", query);
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
	printf("\nMatching recipes found (%zu):\n", matches.count);
	for (size_t i = 0; i < matches.count; i++) {
		printf("  [%2zu] %s\n", i + 1, matches.items[i]);
	}

	printf("\nSelected index (1-%zu) or 'q' to quit: ", matches.count);
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
		fprintf(stderr, "Invalid selection.\n");
		list_free(&matches);
		return 1;
	}

	return 0;
}





