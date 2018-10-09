# Devspaces import of Haxe

## [Haxe](https://haxe.org/)
[haxe.org](https://haxe.org)

Haxe is an open source toolkit that allows you to easily build cross-platform tools and applications that target many mainstream platforms. [Read More](https://github.com/trilogy-group/haxe)

## [Haxe Repository](https://github.com/trilogy-group/haxe)
https://github.com/trilogy-group/haxe

## Artifacts
1. [devspaces.yml](devspaces.yml)
2. [Dockerfile](Dockerfile)

## [Devspaces Instructions](devspaces-readme.md)
**For installing and configuring the `cndevspaces` tool please read the [documentation](http://devspaces-docs.ey.devfactory.com/installation/index.html).**

You can choose to either create a new collection devspace from scratch using the provided devspaces.yml file. Or import an existing collection. 

### I. Creating new collection from devspaces.yml file (using the artifacts)
1. `git clone --branch 3.4_bugfix --recursive https://github.com/trilogy-group/haxe.git`<br>
    * `--branch 3.4_bugfix` is being used to demo the development enviornment created using docker compose. This is being done so that while verifying the output we can be sure that no problems in the code base are creating problems in the running of the development enviornment. <br>
    * `--recursive` this param allows the submodules of the repo to be cloned with the repo. This is necessary as building of the ***Haxe*** tool depends highly on the code base of the submodules present. 
2. `cd haxe`
3. **Copy the artifcats provided, in the repository directory**
4. `cndevspaces collections create -f devspaces.yml`
5. `cndevspaces bind -C haxe-coll -c haxe-config`
6. `cndevspaces exec /etc/haxe-unit-test-java-run.sh`

#### Using your own image
If there are any changes required in the Dockerfile. Then after making those changes a new image can be uploaded to any open docker registry and the values of `image->name` and `image->url` should be changes in devspaces.yml file. 
```yml
images:
- name: haxe-image
  url: registry2.swarm.devfactory.com/parvsharma/haxe-3:latest
``` 

### II. Importing existing collection (Without using the artifacts)
1. `git clone --branch 3.4_bugfix --recursive https://github.com/trilogy-group/haxe.git`<br>
    * `--branch 3.4_bugfix` is being used to demo the development enviornment created using docker compose. This is being done so that while verifying the output we can be sure that no problems in the code base are creating problems in the running of the development enviornment. <br>
    * `--recursive` this param allows the submodules of the repo to be cloned with the repo. This is necessary as building of the ***Haxe*** tool depends highly on the code base of the submodules present.
2. `cd haxe`
3. **`cndevspaces import cd615ae5-b140-4e41-873a-a896259ac60b haxe-coll`<br>
    Imports the collections at the uuid into your account. [Read more](http://devspaces-docs.ey.devfactory.com/collections/sharing.html?highlight=import#import)**
4. `cndevspaces bind -C haxe-coll -c haxe-config`<br>
    Binds the current cirectory with the devspaces. This syncs the source code / files in the repo with the host running devspaces. [Read More](http://devspaces-docs.ey.devfactory.com/collections/commands.html#bind)
5. `cndevspaces exec /etc/haxe-unit-test-java-run.sh`<br>
    This execute the provided command inside the container. If `exec` is called without any command then by default it opens the interactive terminal. [Read More](http://devspaces-docs.ey.devfactory.com/quickstart.html)

After the enviornment is verified to be working. This working enviornment can be shared using the following instructions
1. `cndevspaces save`<br>
    This command saves the running collection so that it can be shared amonst team members / fellow developers. 
2. `cndevspaces export`<br>
    This will give a ***uuid*** which can be then used by anyone this is shared with using the instructions provided above. 