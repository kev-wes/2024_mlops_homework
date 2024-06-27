FROM python:3.10.9-slim

# Install CA certificates and update certificates bundle
RUN apt-get update && apt-get install -y --no-install-recommends ca-certificates && update-ca-certificates

RUN pip install -U pip & pip install pipenv

COPY [ "Pipfile", "Pipfile.lock", "./" ]

RUN pipenv install --system --deploy

COPY [ "refactor_batch_q4.py", "refactor_batch_q4.py" ]
COPY [ "model.bin", "model.bin" ]

ENTRYPOINT [ "python", "refactor_batch_q4.py" ]