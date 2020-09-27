# AVAX Docker

This `Dockerfile` contains a fully functioning AVAX-node. 

## Prerequisites
* Docker 
* jq (only for `verify-bootstrap.sh`)
* curl (only for `verify-bootstrap.sh`)

## Quickstart


### (Option 1) One-hit combo for the lazy without named volumes

```
git clone https://github.com/jonasde/avax-node-docker && cd avax-node-docker && docker build . -t avax-node && docker run -d --name avax-node -p 127.0.0.1:9651:9651 -p 127.0.0.1:9650:9650 avax-node && ./verify-bootstrap.sh
```

Then wait for bootstrapping to finish. You will see it in the terminal. If you want to inspect the container status you can run: 
```
docker logs avax-node
```

### (Option 2) Manually

**Clone**
```
git clone https://github.com/jonasde/avax-node-docker && cd avax-node-docker
```

**Name a volume (optional)**<br/>
```
docker volume create avax-node
```

**Build**<br/>
```
docker build . -t avax-node`
```

**Run (without volume)**<br/>
```
docker run -d --name avax-node -p 127.0.0.1:9651:9651 -p 127.0.0.1:9650:9650 avax-node
```

**Run (with volme)**<br/>
```
docker run -d --name avax-node -v avax-node:/root/.avalanchego -p 127.0.0.1:9651:9651 -p 127.0.0.1:9650:9650 avax-node
```

**Verify node bootstrapping from host**<br/>
`verify-bootstrap.sh` _validates the_ `isBootstrapped` _API call for the X chain. This is a good time to grab a cup of coffee_
```
./verify-bootstrap.sh
```

### Tips
If you ran with volume you can access staking key and cert at `/var/lib/docker/volumes/avax-node/_data`. You will have to modify file permissions to access these files, or escalate permission with `sudo` (for linux).
