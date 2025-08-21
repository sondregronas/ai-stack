# AI Stack Config

Just a docker compose file and environment variables/settings to run a local AI stack (for education) with the following
services - this is probably not suitable for everyone, but it's just a starting point for our use case.

- FastKoro (Kokoro) for TTS
- ComfyUI with FLUX.1-dev for image generation
- Ollama for LLMs
- Open WebUI for the interface
- Uses DuckDuckGo for search

Some of the images might need a little bit of tweaking depending on your hardware, and some admin panel settings in Open
WebUI might need to be adjusted (ComfyUI needs to be altered to fit the workflow). Your mileage may vary.

## Ports

Every service gets exposed on the host by default (not just only internal Docker networking), so you can access them
from your browser or other applications. You should only need to proxy Open WebUI The ports are as follows:

```bash
PORT_OLLAMA=11434  # Ollama API
PORT_KOKORO=8880  # Swagger found at /docs
PORT_COMFYUI=8188  # ComfyUI web interface
PORT_OPENWEBUI=3000  # Open WebUI interface (the main attraction)
```

## Todo

- [ ] Settings for OAuth integration out of the box (for now generic email registration/authentication is used, but no
  SMTP is configured)
- [ ] Automatic deletion of old chats / uploaded files and inactive users
- [ ] Bundle with LLM model downloads, and configured Task Models

And lots more - for now it's just a "collection" for ease of use.