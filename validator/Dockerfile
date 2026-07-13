FROM python:3.13-slim

WORKDIR /workspace

COPY validator/requirements.txt /tmp/requirements.txt

RUN pip install \
    --no-cache-dir \
    --requirement /tmp/requirements.txt

ENTRYPOINT ["python", "/workspace/scripts/validate-findings.py"]