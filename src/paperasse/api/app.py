"""FastAPI application: the HTTP entry point for Paperasse."""

from fastapi import FastAPI

from paperasse import __version__

app = FastAPI(title="Paperasse", version=__version__)


@app.get("/health")
def health() -> dict[str, str]:
    """Report that the service is up, for CI smoke tests and the hosting platform's health checks."""
    return {"status": "ok"}
