FROM python:3.6-alpine

WORKDIR /app

RUN apk add --no-cache ffmpeg speedtest-cli \
    && apk add --no-cache --virtual builder build-base libffi-dev \
    && adduser -D -h /app radio

COPY --chown=radio:radio requirements.txt .

RUN su - radio -c "pip install --user --no-cache-dir -r requirements.txt" \
    && apk del builder

COPY --chown=radio:radio . .

USER radio
CMD ["python", "/app/main.py"]
