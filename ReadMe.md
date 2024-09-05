# Steps I follow for making this dev image
- [x]  complete the droplet setup because I'm gonna use that as a base
- [ ]  find common things in the ansible playbook

> this is how I ran the container
```bash
#build the container
docker build . -t dev_image:v7

# run the dev_container
docker run --rm --name=test -it dev_image:v6
```
