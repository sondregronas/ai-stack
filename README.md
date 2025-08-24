# AI Stack Config

Just a docker compose file and environment variables/settings to run a local AI stack (for education) with the following
services - this is probably not suitable for everyone, but it's just a starting point for our use case.

- FastKoro (Kokoro) for TTS
- ComfyUI with FLUX.1-dev for image generation
- Ollama for LLMs
- Open WebUI for the interface
- DuckDuckGo for web search

Some of the images might need a little bit of tweaking depending on your hardware, and some admin panel settings in Open
WebUI might need to be adjusted. ComfyUI needs a bit of configuration to get working (importing the model, setting up,
etc.)

> **NOTE:** GPU inference on Blackwell GPU for ComfyUI is not working correctly with the docker image as-is.

## Setup

```bash
git clone https://github.com/sondregronas/ai-stack
cp example.env .env
```

Modify the `.env` file before proceeding

```bash
cp docker-compose-external.yml docker-compose.yml  # Or docker-compose-internal.yml
docker compose up -d
sh comfyui-post-setup.sh  # Optional
```

## Ports

Every service gets exposed on the host by default (not just only internal Docker networking), so you can access them
from your browser or other applications. You should only need to proxy Open WebUI The ports are as follows:

```bash
PORT_OLLAMA=11434  # Ollama API
PORT_KOKORO=8880  # Swagger found at /docs
PORT_COMFYUI=8188  # ComfyUI web interface
PORT_OPENWEBUI=3000  # Open WebUI interface (the main attraction)
PORT_PLAYWRIGHT=9323  # Playwright Web Loader
```

## Todo

- [ ] Settings for OAuth integration out of the box (for now generic email registration/authentication is used, but no
  SMTP is configured)
- [ ] Automatic deletion of old chats / uploaded files and inactive users
- [ ] Bundle with LLM model downloads, and configured Task Models

And lots more - for now it's just a "collection" for ease of use.