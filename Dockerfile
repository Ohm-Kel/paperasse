# Build and run:
#   docker build -t paperasse .
#   docker run -p 8000:8000 --env-file .env paperasse
FROM python:3.12-slim

# uv installs the exact versions in uv.lock.
COPY --from=ghcr.io/astral-sh/uv:0.12.13 /uv /bin/uv

ENV PYTHONUNBUFFERED=1 \
    UV_COMPILE_BYTECODE=1 \
    UV_LINK_MODE=copy \
    UV_NO_CACHE=1 \
    UV_PYTHON_DOWNLOADS=never \
    PATH="/app/.venv/bin:$PATH"

WORKDIR /app

# Dependencies get their own layer, so a code change does not reinstall them.
COPY pyproject.toml uv.lock ./
RUN uv sync --locked --no-dev --no-install-project

COPY README.md LICENSE ./
COPY src/ src/
RUN uv sync --locked --no-dev

RUN useradd --create-home appuser && chown -R appuser /app
USER appuser

EXPOSE 8000
HEALTHCHECK --interval=30s --timeout=5s --start-period=20s CMD python -c "import urllib.request; urllib.request.urlopen('http://localhost:8000/health')"
CMD ["uvicorn", "paperasse.api.app:app", "--host", "0.0.0.0", "--port", "8000"]
