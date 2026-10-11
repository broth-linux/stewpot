/* /usr/src/broth-tools/stew-graph.c */
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <unistd.h>
#include <errno.h>

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

static int package_exists(const char *pkg) {
    char dir_path[PATH_MAX_LEN];
    snprintf(dir_path, sizeof(dir_path), "/var/db/stew/installed/%s", pkg);
    
    /* Just check if the directory exists and can be traversed */
    if (access(dir_path, F_OK) == 0) {
        return 1;
    }
    return 0;
}

static int read_dependencies(const char *pkg, char deps[128][NAME_MAX_LEN], int *count) {
    char dep_path[PATH_MAX_LEN];
    snprintf(dep_path, sizeof(dep_path), "/var/db/stew/installed/%s/depends", pkg);

    *count = 0;
    FILE *f = fopen(dep_path, "r");
    if (!f) return 0;

    char line[256];
    while (fgets(line, sizeof(line), f) && *count < 128) {
        char dep[NAME_MAX_LEN];
        /* Skip comments and empty lines exactly like checkout */
        if (sscanf(line, "%127s", dep) == 1 && dep[0] != '#') {
            strncpy(deps[(*count)++], dep, NAME_MAX_LEN - 1);
        }
    }
    fclose(f);
    return 1;
}

static void prompt_add_dependencies(const char *pkg) {
    printf("[!] Package '%s' has no recorded dependencies.\n", pkg);
    printf("    Do you want to add dependencies now? [y/N]: ");
    fflush(stdout);

    char ans[16];
    if (!fgets(ans, sizeof(ans), stdin)) return;
    if (ans[0] != 'y' && ans[0] != 'Y') return;

    printf("    Enter dependencies (space-separated): ");
    fflush(stdout);

    char input[1024];
    if (!fgets(input, sizeof(input), stdin)) return;

    char dep_path[PATH_MAX_LEN];
    snprintf(dep_path, sizeof(dep_path), "/var/db/stew/installed/%s/depends", pkg);

    FILE *f = fopen(dep_path, "w");
    if (!f) {
        perror("[-] Failed to open depends file for writing");
        return;
    }

    char *tok = strtok(input, " \t\r\n");
    int added = 0;
    while (tok) {
        if (strlen(tok) > 0) {
            fprintf(f, "%s\n", tok);
            added++;
        }
        tok = strtok(NULL, " \t\r\n");
    }
    fclose(f);
    printf("[+] Added %d dependenc%s to '%s'.\n\n", added, added == 1 ? "y" : "ies", pkg);
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

    char deps[128][NAME_MAX_LEN];
    int count = 0;
    read_dependencies(pkg, deps, &count);

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

    if (!package_exists(root_pkg)) {
        char err_path[PATH_MAX_LEN];
        snprintf(err_path, sizeof(err_path), "/var/db/stew/installed/%s", root_pkg);
        perror(err_path);
        return 1;
    }

    char deps[128][NAME_MAX_LEN];
    int count = 0;
    read_dependencies(root_pkg, deps, &count);

    if (count == 0) {
        prompt_add_dependencies(root_pkg);
        read_dependencies(root_pkg, deps, &count);
    }

    printf("%s\n", root_pkg);
    mark_visited(root_pkg);

    if (count == 0) {
        printf("`-- (no dependencies)\n");
        return 0;
    }

    for (int i = 0; i < count; i++) {
        render_tree(deps[i], "", i == (count - 1));
    }

    return 0;
}
