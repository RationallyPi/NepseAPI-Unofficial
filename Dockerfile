# Personal fork: runs only the REST API, with an optional API key gate (see server.py).
# Upstream (MIT): https://github.com/surajrimal07/NepseAPI-Unofficial
FROM python:3.12-slim

WORKDIR /app

# git is needed for the nepse library's git+ dependency
RUN apt-get update \
    && apt-get install -y --no-install-recommends git \
    && rm -rf /var/lib/apt/lists/*

COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

COPY server.py validator.py rate_limiter.py stockmap.json ./

EXPOSE 8000

# $PORT is set by the hosting platform (Render uses 10000 by default)
CMD uvicorn server:app --host 0.0.0.0 --port ${PORT:-8000}
