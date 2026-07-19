FROM python:3.11-slim
WORKDIR /app
RUN pip install --no-cache-dir fastapi uvicorn httpx pydantic
COPY . /app
EXPOSE 8000
RUN useradd -U -u 1000 appuser && chown -R 1000:1000 /app
USER 1000
CMD ["uvicorn", "main:app", "--host", "0.0.0.0", "--port", "8000"]
