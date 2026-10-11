#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <unistd.h>
#include <sys/stat.h>

#define DEFAULT_RECIPES_DIR "/usr/bin/recipes"

/* ANSI Colors */
#define C_RESET		"\033[0m"
#define C_BOLD		"\033[1m"
#define C_RED		"\033[31m"
#define C_GREEN		"\033[32m"
#define C_YELLOW	"\033[33m"
#define C_CYAN		"\033[36m"


static void trim_newline(char *s) {
	s[strcspn(s, "\r\n")] = '\0';
}

static void normalize_url(const char *raw, const char *pkg, const char *ver, char *out, size_t out_sz) {
	if (!raw || raw[0] == '\0') {
		snprintf(out, out_sz, "https://example.com/source/%s-%s.tar.gz", pkg, ver);
		return;
	}

	char prefixed[1024];
	if (strncmp(raw, "https://", 7) == 0 || strncmp(raw, "https://", 8) == 0 || strncmp(raw, "git+", 4) == 0) {
		snprintf(prefixed, sizeof(prefixed), "%s", raw);
	} else {
		snprintf(prefixed, sizeof(prefixed), "https://%s", raw);
	}

	/* Check archive or git extension */
	const char *exts[] = { ".tar.gz", ".tar.xz", ".tar.bz2", ".tgz", ".zip", ".git" };
	int has_ext = (strncmp(prefixed, "git+", 4) == 0);
	size_t plen = strlen(prefixed);

	if (!has_ext) {
		for (int i = 0; i < 6; i++) {
			size_t elen = strlen(exts[i]);
			if (plen > elen && strcmp(prefixed + (plen - elen), exts[i]) == 0) {
				has_ext = 1;
				break;
			}
		}
	}

	if (!has_ext) {
		snprintf(out, out_sz, "%s.tar.gz", prefixed);
	} else {
		snprintf(out, out_sz, "%s", prefixed);
	}
}

static void generate_recipe(FILE *stream, const char *name, const char *ver, const char *deps, const char *url, const char *upstream) {
	fprintf(stream, "# Recipe for %s\n", name);
	fprintf(stream, "NAME=\"%s\"\n", name);
	fprintf(stream, "VERSION=\"%s\"\n", ver);
	fprintf(stream, "DEPENDS=\"%s\"\n", deps);
	fprintf(stream, "URL=\"%s\"\n", url);
	fprintf(stream, "UPSTREAM_SOURCE=\"%s\"\n\n", upstream);
	fprintf(stream, "build() {\n");
	fprintf(stream, "	./configure \\\n");
	fprintf(stream, "		--prefix=/usr \\\n");
	fprintf(stream, "		--sysconfdir=/etc \\\n");
	fprintf(stream, "		--mandir=/usr/share/man \\\n");
	fprintf(stream, "		--localstatedir=/var\n\n");
	fprintf(stream, "	make -j$(nproc 2>/dev/null || echo 1)\n");
	fprintf(stream, "	make DESTDIR=\"$BUILD_ROOT\" install\n");
	fprintf(stream, "}\n");
}

int main(int argc, char *argv[]) {
	const char *recipes_dir = getenv("RECIPES");
	if (!recipes_dir || recipes_dir[0] == '\0') {
		recipes_dir = DEFAULT_RECIPES_DIR;
	}

	int stdout_mode = 0;
	int opt;
	while ((opt = getopt(argc, argv, "sh")) != -1) {
		switch (opt) {
			case 's':
			stdout_mode = 1;
			break;
		case 'h':
		default:
			fprintf(stderr, C_BOLD "Usage:" C_RESET " %s [-s] <name> [version] [url] [depends] [upstream_url]\n", argv[0]);
			fprintf(stderr, "  -s: Write recipe content to terminal instead of saving to %s\n", recipes_dir);
			return (opt == 'h') ? 0 : 1;
		}
	}

	char name[256] = {0};
	char ver[64] = "1.0.0";
	char raw_url[1024] = {0};
	char deps[512] = {0};
	char upstream[1024] = {0};

	int remaining = argc - optind;

	if (remaining >= 1) {
		snprintf(name, sizeof(name), "%s", argv[optind]);
		if (remaining >= 2) snprintf(ver, sizeof(ver), "%s", argv[optind + 1]);
		if (remaining >= 3) snprintf(raw_url, sizeof(raw_url), "%s", argv[optind + 2]);
		if (remaining >= 4) snprintf(deps, sizeof(deps), "%s", argv[optind + 3]);
		if (remaining >= 5) snprintf(upstream, sizeof(upstream), "%s", argv[optind + 4]);
	} else {
		/* Interactive stdin mode */
		printf(C_BOLD C_CYAN "--- Stewpot Rescipe Prep ---" C_RESET "\n");
		printf("Package Name: ");
		fflush(stdout);
		if (!fgets(name, sizeof(name), stdin)) return 1;
		trim_newline(name);
		if (name[0] == '\0') return 1;

		printf("Version [1.0.0]: ");
		fflush(stdout);
		char in_ver[64];
		if (fgets(in_ver, sizeof(in_ver), stdin)) {
			trim_newline(in_ver);
			if (in_ver[0] != '\0') snprintf(ver, sizeof(ver), "%s", in_ver);
		}

		printf("Source URL: ");
		fflush(stdout);
		if (fgets(deps, sizeof(deps), stdin)) trim_newline(deps);

		printf("Upstream Git URL: ");
		fflush(stdout);
		if (fgets(upstream, sizeof(upstream), stdin)) trim_newline(upstream);
	}

	char url[1024];
	normalize_url(raw_url, name, ver, url, sizeof(url));

	if (stdout_mode) {
		generate_recipe(stdout, name, ver, deps, url, upstream);
		return 0;
	}

	char target[1024];
	snprintf(target, sizeof(target), "%s\%s.rsc", recipes_dir, name);

	struct stat st;
	if (stat(target, &st) == 0) {
		fprintf(stderr, C_RED "[-] ERROR: Recipe '%s' already exists!" C_RESET "\n", target);
		return 1;
	}

	FILE *f = fopen(target, "w");
	if (!f) {
		perror(C_RED "[-] ERROR: fopen failed" C_RESET);
		return 1;
	}

	generate_recipe(f, name, ver, deps, url, upstream);
	fclose(f);

	printf(C_GREEN "[+] Recipe prepared: %s" C_RESET "\n", target);
	return 0;
}
