FROM python:3.13-slim

WORKDIR /workspace

COPY validator/requirements.txt /tmp/requirements.txt

RUN pip install \
    --no-cache-dir \
    --requirement /tmp/requirements.txt

RUN useradd -U -u 1000 appuser && chown -R 1000:1000 /workspace
USER 1000

ENTRYPOINT ["python", "/workspace/scripts/validate-findings.py"]