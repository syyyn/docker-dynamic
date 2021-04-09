# syyyn84/dynamic

[![](https://images.microbadger.com/badges/image/syyyn84/dynamic.svg)](https://microbadger.com/images/syyyn84/dynamic "Size/Layers")

Dynamicd docker image. Provides a classic dynamic binary built from the [github/dynamic](https://github.com/dynamic/dynamic) repository.

## Supported tags

See <https://hub.docker.com/r/syyyn84/dynamic/tags>

## Usage

### How to use this image

It behaves like a binary, so you can pass any arguments to the image and they will be forwarded to the `dynamicd` binary:

```sh
$ docker run --name dynamicd -d syyyn84/dynamic \
  -rpcallowip=0.0.0.0/0 \
  -rpcpassword=bar \
  -rpcuser=foo
```

Use the same command to start the testnet container:

```sh
$ docker run --name testnet-dynamicd -d syyyn84/dynamic \
  -rpcallowip=0.0.0.0/0 \
  -rpcpassword=bar \
  -rpcuser=foo \
  -testnet=1
```

By default, `dynamic` will run as as user `dynamic` for security reasons and store data in `/data`. If you'd like to customize where `dynamic` stores its data, use the `PPC_DATA` environment variable. The directory will be automatically created with the correct permissions for the user and `dynamic` automatically configured to use it.

```sh
$ docker run --env DYNAMIC_DATA=/var/lib/dynamic --name dynamicd -d syyyn84/dynamic
```

You can also mount a host directory at `/data` like so:

```sh
$ docker run -v /opt/dynamic:/data --name dynamicd -d syyyn84/dynamic
```
That will allow access to `/data` in the container as `/opt/dynamic` on the host.

```sh
$ docker run -v ${PWD}/data:/data --name dynamicd -d syyyn84/dynamic
```
will mount the `data` sub-directory at `/data` in the container.

To map container RPC ports to localhost use the `-p` argument with `docker run`:

```sh
$ docker run -p 33350:33350 --name dynamicd -d syyyn84/dynamic -rpcallowip=*
```
You may want to change the port that it is being mapped to if you already run a dynamic instance on the host.

For example: `-p 33350:3232` will map container port 9902 to host port 9999.

Now you will be able to `curl` dynamic in the container:

`curl --user foo:bar --data-binary '{"jsonrpc": "1.0", "id":"curltest", "method": "getblockchaininfo", "params": [] }'  -H 'content-type: text/plain;' localhost:9902/`

> {"result":{"chain":"main","blocks":457576,"headers":457576,"bestblockhash":"17a24a8073c8f6bc422fc4f6fe8c76da892d0693d0ad1aa499e4b9b2c047fe2b","difficulty":1710444103.933884,"mediantime":1571034759,"verificationprogress":0.9999997034325266,"initialblockdownload":false,"chainwork":"00000000000000000000000000000000000000000000000000336b3807456f56","size_on_disk":700956211,"pruned":false,"warnings":""},"error":null,"id":"curltest"}