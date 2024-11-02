.PHONY: usage
usage:
	@echo "Usage: make [target]"
	@echo
	@echo "Targets:"
	@echo "  clean       Remove all generated files"
	@echo "  lint        Run ruff format, check and uv sync"
	@echo "  commit      Run cz commit"
	@echo "  build       Build the project"
	@echo
	@echo "  help           Run rdf-tools help"
	@echo "  version        Run rdf-tools version"
	@echo "  airlines       Run rdf-tools airlines"
	@echo "  airports       Run rdf-tools airports"
	@echo "  courses        Run rdf-tools courses"
	@echo "  manufacturers  Run rdf-tools manufacturers"
	@echo "  residences     Run rdf-tools residences"
	@echo

.PHONY: clean
clean:
	@git clean -Xdf
	@mkdir -p .git/hooks
	@rm -f .git/hooks/*.sample
	@find .git/hooks/ -type f  | while read i; do chmod +x $$i; done

.PHONY: lint
lint:
	@uv run --quiet deptry src --experimental-namespace-package
	@uv run --quiet ruff format src
	@uv run --quiet ruff check src --quiet
	@uv sync --quiet

.PHONY: commit
commit: lint
	@uv run --quiet cz commit

.PHONY: build
build: lint
	@uv build


.PHONY: help
help: lint
	@uv run --quiet rdf-tools --help

.PHONY: version
version: lint
	@uv run --quiet rdf-tools --version

.PHONY: airlines
airlines: lint
	@uv run --quiet rdf-tools airlines qf jq sq

.PHONY: airlines.json
airlines.json: lint
	@uv run --quiet rdf-tools airlines qf jq sq --json | jq > $@

.PHONY: airports
airports: lint
	@uv run --quiet rdf-tools airports jfk mel cbr syd

.PHONY: airports.json
airports.json: lint
	@uv run --quiet rdf-tools airports jfk mel cbr syd --json | jq > $@

.PHONY: courses
courses: lint
	@uv run --quiet rdf-tools courses

.PHONY: courses.json
courses.json: lint
	@uv run --quiet rdf-tools courses --json | jq > $@

.PHONY: manufacturers
manufacturers: lint
	@uv run --quiet rdf-tools manufacturers

.PHONY: manufacturers.json
manufacturers.json: lint
	@uv run --quiet rdf-tools manufacturers --json | jq > $@

.PHONY: residences
residences: lint
	@uv run --quiet rdf-tools residences

.PHONY: residences.json
residences.json: lint
	@uv run --quiet rdf-tools residences --json | jq > $@
