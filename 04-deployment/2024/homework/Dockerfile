# Dockerfile
FROM agrigorev/zoomcamp-model:mlops-2024-3.10.13-slim

RUN pip install -U pip
RUN pip install pipenv

WORKDIR /app
COPY ["Pipfile", "Pipfile.lock", "starter.py", "./"]

RUN pipenv install --system --deploy

RUN mkdir -p /app/output
#COPY ["model.bin", "./"]

# Set the entrypoint to run the prediction script
ENTRYPOINT ["python", "starter.py"]