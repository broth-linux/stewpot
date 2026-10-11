#include <stdio.h>
#include <stdlib.h>
#include <string.h>

#define MAX_VISITED 512
#define NAME_MAX_LEN 128
#define PATH_MAX_LEN 512

static char visited[MAX_VISITED][NAME_MAX_LEN];
static int visited_count = 0;

static int has_visited(const char *name) {
    for (int i = 0; i < visited_count; i++) {
        if (strcmp(visited[i], name) == 0) return 1;
    }
    return 0;
}

static void mark_visited(const char *name) {
    if (visited_count < MAX_VISITED) {
        strncpy(visited[visited_count++], name, NAME_MAX_LEN - 1);
    }
}

static void render_tree(const char *pkg, const char *prefix, int is_tail) {
    int already_seen = has_visited(pkg);

    printf("%s%s %s%s\n",
           prefix,
           is_tail ? "`--" : "|--",
           pkg,
           already_seen ? " (*)" : "");

    if (already_seen) return;
    mark_visited(pkg);

    char dep_path[PATH_MAX_LEN];
    snprintf(dep_path, sizeof(dep_path), "/var/db/stew/installed/%s/depends", pkg);

    FILE *f = fopen(dep_path, "r");
    if (!f) return;

    char deps[128][NAME_MAX_LEN];
    int count = 0;
    char line[256];

    while (fgets(line, sizeof(line), f) && count < 128) {
        char dep[NAME_MAX_LEN];
        if (sscanf(line, "%127s", dep) == 1 && dep[0] != '#') {
            strncpy(deps[count++], dep, NAME_MAX_LEN - 1);
        }
    }
    fclose(f);

    char next_prefix[PATH_MAX_LEN];
    snprintf(next_prefix, sizeof(next_prefix), "%s%s", prefix, is_tail ? "    " : "|   ");

    for (int i = 0; i < count; i++) {
        render_tree(deps[i], next_prefix, i == (count - 1));
    }
}

int main(int argc, char **argv) {
    if (argc < 2) {
        fprintf(stderr, "Usage: stew-graph <installed-pkg>\n");
        return 1;
    }

    const char *root_pkg = argv[1];
    printf("%s\n", root_pkg);
    mark_visited(root_pkg);

    char dep_path[PATH_MAX_LEN];
    snprintf(dep_path, sizeof(dep_path), "/var/db/stew/installed/%s/depends", root_pkg);

    FILE *f = fopen(dep_path, "r");
    if (!f) return 0;

    char deps[128][NAME_MAX_LEN];
    int count = 0;
    char line[256];

    while (fgets(line, sizeof(line), f) && count < 128) {
        char dep[NAME_MAX_LEN];
        if (sscanf(line, "%127s", dep) == 1 && dep[0] != '#') {
            strncpy(deps[count++], dep, NAME_MAX_LEN - 1);
        }
    }
    fclose(f);

    for (int i = 0; i < count; i++) {
        render_tree(deps[i], "", i == (count - 1));
    }

    return 0;
}
