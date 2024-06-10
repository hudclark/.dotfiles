# Containers

Various containers used for distrobox environments. The primary container is `./dev`,
which contains an Alpine Edge based image and packages for general development.

## Building

Build the image, then create a distrobox container from it.

```sh
cd containers/dev
podman build -t dev .
distrobox create -n dev -i localhost/dev:latest
distrobox enter dev
```

To authenticate docker with GCP, run the following commands. This will let docker on the host authenticate using a binary on the container.

```~~
 distrobox-export --bin /home/hudson/google-cloud-sdk/bin/docker-credential-gcloud --export-path ~/.local/bin
~~
