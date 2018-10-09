# Dockerization of Haxe

## [Haxe](https://haxe.org/)
[haxe.org](https://haxe.org)

Haxe is an open source toolkit that allows you to easily build cross-platform tools and applications that target many mainstream platforms. [Read More](https://github.com/trilogy-group/haxe)

## [Haxe Repository](https://github.com/trilogy-group/haxe)
https://github.com/trilogy-group/haxe

## Docker Requirements
 1. Docker version 18.06.1-ce
 2. Docker compose version 1.22.0

## Version of container dependencies used 
1. [ubuntu:18.04](https://github.com/tianon/docker-brew-ubuntu-core/blob/222130dfdfa777c09a17b3f08ba68c5b9850e905/bionic/Dockerfile)

## Artifacts
1. [Dockerfile](Dockerfile)<br>
    Main dockerfile having all the instructions to build the development enviornment of the ***Haxe*** tool
2. [docker-compose.yml](docker-compose.yml)
    * `command: /etc/haxe-unit-test-java-run.sh`<br>
    `haxe-unit-test-java-run.sh` is a script file created during the docker build phase and details are present inside the Dockerfile. This script compiles the haxe from the source and then runs a java building test present in the `tests/unit` directory of the repository. Kindly also read the importance of env `FORCE_HAXE_MAKE`
    * env `FORCE_HAXE_MAKE` While running the script mentioned in the previous point. If forcing the building of teh haxe binary is required set this to true. Otherwise set this to false. If this is set to false then presence of haxe dist directory will be checked and haxe will not be built if that is present. 
3. [.dockerignore](.dockerignore)<br>
    Only allows the opam file and ignores everything else.  
4. [docker-script.sh](docker-script.sh) / [docker-script.ps1](docker-script.ps1) <br>These are optional scripts usefull for building the images in the local repository and on the devspaces host. the first / name parameter is the name of the image that w8ll be created. 
    * For windows
    ```powershell
    ./docker-script.ps1 -name haxe
    ```
    * For linux
    ```shell
    ./docker-script.sh haxe
    ```

## Steps
1. `git clone --branch 3.4_bugfix --recursive https://github.com/trilogy-group/haxe.git`<br>
    * `--branch 3.4_bugfix` is being used to demo the development enviornment created using docker compose. This is being done so that while verifying the output we can be sure that no problems in the code base are creating problems in the running of the development enviornment. <br>
    * `--recursive` this param allows the submodules of the repo to be cloned with the repo. This is necessary as building of the ***Haxe*** tool depends highly on the code base of the submodules present. 
2. `cd haxe`
3. Copy the artifcats provided,  in the repository directory
4. `docker-compose up` <br>
    this will build and run the haxe service mentioned in the docker-compose file. 
5. Verify from the output that java unit test has been compiled using the recently compiled ***haxe*** binary. 

**For Instructions on running the develoment enviornment in devspaces kindly refer to [devspaces-readme.md](devspaces-readme.md)**