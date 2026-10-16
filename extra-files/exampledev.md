{
  "name": "Python 3",
  // ↑ Just a label, shows in VS Code's UI. Doesn't affect functionality.

  "image": "mcr.microsoft.com/devcontainers/python:3-3.14-trixie",
  // ↑ The base container image — pre-built environment with Python already installed.
  //   Alternative: point to a Dockerfile instead if you need a fully custom image.

  "features": {},
  // ↑ Pre-packaged "add-ons" maintained by the devcontainers community — e.g. adding
  //   Node, Docker-in-Docker, or AWS CLI *without* writing install commands yourself.
  //   Example: "ghcr.io/devcontainers/features/aws-cli:1": {}

  "forwardPorts": [],
  // ↑ Ports inside the container you want accessible from your local browser
  //   (e.g. [3000] for a web app running on localhost:3000 in the container)

  "postCreateCommand": "...",
  // ↑ Runs ONCE, right after the container is first built. Good for: installing
  //   packages, one-time setup, cloning things. NOT re-run on every restart.

  "postStartCommand": "...",
  // ↑ Runs EVERY TIME the container starts (including restarts/reopens).
  //   Good for: starting a background service, syncing something fresh each time.
  //   Bad for: one-time installs (wasteful, can error on reinstall).

  "containerEnv": { "KEY": "value" },
  // ↑ Environment variables available inside the container (like a .env file baked in)

  "customizations": {
    "vscode": {
      "extensions": [ "publisher.extension-id" ]
      // ↑ VS Code extensions auto-installed when the container opens
    }
  }
}