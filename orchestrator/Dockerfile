FROM python:3.11-slim
WORKDIR /app
RUN pip install --no-cache-dir fastapi uvicorn httpx pydantic \
    && groupadd --system app \
    && useradd --system --gid app --home-dir /app --no-create-home app
COPY --chown=app:app . /app
RUN mkdir -p /app/workspace \
    && chown app:app /app/workspace
USER app
EXPOSE 8000
CMD ["uvicorn", "main:app", "--host", "0.0.0.0", "--port", "8000"]
