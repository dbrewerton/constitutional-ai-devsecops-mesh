FROM python:3.13-slim

WORKDIR /workspace

COPY validator/requirements.txt /tmp/requirements.txt

RUN pip install \
    --no-cache-dir \
    --requirement /tmp/requirements.txt \
    && groupadd --system validator \
    && useradd --system --gid validator --home-dir /nonexistent --no-create-home validator

USER validator

ENTRYPOINT ["python", "/workspace/scripts/validate-findings.py"]