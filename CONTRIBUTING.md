# Contributing

This guide covers setup, the change workflow and the review rule for this solo project.

## Set up

You need [uv](https://docs.astral.sh/uv/getting-started/installation/); it installs Python 3.12
if it is missing.

```powershell
uv sync                      # .venv with the exact versions in uv.lock
uv run pre-commit install    # run Ruff and mypy before every commit
```

## Make a change

1. Branch off `main` with a prefix that says what the change is: `feat/`, `fix/`, `docs/`,
   `chore/` or `exp/` (an evaluation run or experiment that does not change shipped behaviour).
2. Commit in [Conventional Commits](https://www.conventionalcommits.org/en/v1.0.0/) form, one
   logical change per commit:

   ```
   <type>(<scope>): <imperative summary under 72 characters>
   ```

   Types: `feat`, `fix`, `docs`, `style`, `refactor`, `perf`, `test`, `build`, `ci`, `chore`,
   `exp`. Add a body when the reason is not obvious, and mark breaking changes with `!` or a
   `BREAKING CHANGE:` footer.
3. Open a pull request that says what changed, why, how you tested it, and shows sample output,
   and link the issue it addresses. CI must pass before merging.

## Review

This is a solo project, so it is a recorded exception to the two-person review rule. Every change
still goes through a pull request, and the author self-reviews it against this checklist before
merging:

- [ ] CI is green: lint, type checks, tests with coverage, and the Docker smoke test
- [ ] The diff does one logical thing, and the commit messages follow Conventional Commits
- [ ] New logic has tests, including failure paths, and coverage did not drop
- [ ] No secrets, keys or large data files are in the diff
- [ ] Any model or pipeline change reports before-and-after metrics
- [ ] README, CHANGELOG and decision records are updated where the change affects them

The major pull requests (the agent graph and the deployment) also get a review from a classmate.

## Checks

The pre-commit hooks run Ruff (lint and format) and mypy on each commit. To run everything by
hand:

```powershell
uv run pre-commit run --all-files    # Ruff lint and format, mypy
uv run pytest --cov                  # tests; fails below 90% coverage
```

CI runs the same checks and also builds the Docker image and calls its `/health` endpoint.

## Dependencies

Add or upgrade with uv so that `pyproject.toml` and `uv.lock` change together, and commit both:

```powershell
uv add "<package>==<version>"          # runtime dependency
uv add --dev "<package>==<version>"    # development tool
uv lock --upgrade-package <package>    # upgrade one locked package
```

## Releases

1. Move the `Unreleased` entries in `CHANGELOG.md` under the new version and date.
2. Bump `__version__` in `src/paperasse/__init__.py`.
3. Tag the merge commit on `main` with a semantic version (`v0.1.0`) and push the tag.
