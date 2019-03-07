# Development with Devspaces

### Devspaces

Manage your Devspaces https://www.devspaces.io/.

Read up-to-date documentation about cli installation and operation in https://www.devspaces.io/devspaces/help.

Here follows the main commands used in Devspaces cli.

|action   |Description                                                                                   |
|---------|----------------------------------------------------------------------------------------------|
|`devspaces --help`                    |Check the available command names.                               |
|`devspaces create [options]`          |Creates a DevSpace using your local DevSpaces configuration file |
|`devspaces start <devSpace>`          |Starts the DevSpace named \[devSpace\]                           |
|`devspaces bind <devSpace>`           |Syncs the DevSpace with the current directory                    |
|`devspaces info <devSpace> [options]` |Displays configuration info about the DevSpace.                  |

Use `devspaces --help` to know about updated commands.

Before begining any workflow, initialize git submodules: `git submodule update --init`.

All commands should be issued from **project directory**.

#### Development flow

You should have Devspaces cli services started and logged to develop with Devspaces.

1 - Create Devspaces

```bash
$ cd devspaces/docker
$ devspaces create
$ cd ../../
```

2 - Start containers

```bash
devspaces start haxe
```

3 - Start containers synchronization

```bash
devspaces bind haxe
```

4 - Grab some container info

```bash
devspaces info haxe
```

Retrieve published DNS and endpoints using this command

5 - Connect to development container

```bash
devspaces exec haxe
```

6 - Build Haxe and install binaries

6.1 - Configure Opam libs and Build

**Obs.:** `opam` can show an `error` or a `warning` about missing `conf-m4` or `m4`libs, but this won't affect the build and tests of this import.

```bash
opam pin add haxe . --no-action
opam install haxe --deps-only -y

opam config exec -- make -s STATICLINK=1 libs
opam config exec -- make -s -j STATICLINK=1 haxe
opam config exec -- make -s haxelib

make
make install
```

6.2 - Configure haxelibs

```bash
haxelib setup $HAXELIB_PATH
haxelib install record-macros
haxelib install nodejs
haxelib install hxcs
```

7 - Run tests for supported target languages

```bash
cd /data/tests
haxe RunCi.hxml
export TEST=js,cs
neko RunCi.n
```

### Docker Script Manager (CLI)

Currently, we have these command available to work using local docker compose.

```bash
devspaces/docker-cli.sh <command>
```

|action    |Description                                                               |
|----------|--------------------------------------------------------------------------|
|`build`   |Builds images                                                             |
|`deploy`  |Deploy Docker compose containers                                          |
|`undeploy`|Undeploy Docker compose containers                                        |
|`start`   |Starts Docker compose containers                                          |
|`stop`    |Stops Docker compose containers                                           |
|`exec`    |Get into the container                                                    |

#### Development flow

1 - Build and Run `docker-compose` locally.

```bash
devspaces/docker-cli.sh build
devspaces/docker-cli.sh deploy
devspaces/docker-cli.sh start
```

2 - Get into container

```bash
devspaces/docker-cli.sh exec
```

3 - Build Haxe and install binaries

3.1 - Configure Opam libs and Build

**Obs.:** `opam` can show an `error` or a `warning` about missing `conf-m4` or `m4`libs, but this won't affect the build and tests of this import.

```bash
opam pin add haxe . --no-action
opam install haxe --deps-only -y

opam config exec -- make -s STATICLINK=1 libs
opam config exec -- make -s -j STATICLINK=1 haxe
opam config exec -- make -s haxelib

make
make install
```

3.2 - Configure haxelibs

```bash
haxelib setup $HAXELIB_PATH
haxelib install record-macros
haxelib install nodejs
haxelib install hxcs
```

4 - Run tests for supported target languages

```bash
cd /data/tests
haxe RunCi.hxml
export TEST=js,cs
neko RunCi.n
```
