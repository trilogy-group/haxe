FROM ubuntu:18.04

RUN apt-get update &&\
    apt install -y libpcre3-dev zlib1g-dev m4 software-properties-common opam openjdk-8-jdk wget
    
RUN apt-get install -y neko

RUN mkdir /data
COPY opam /data/
RUN apt-get install -qq -yy pkg-config

RUN useradd -ms /bin/bash haxeuser
USER haxeuser

WORKDIR /data
RUN opam init && eval `opam config env`
RUN opam depext conf-pkg-config.1.1
RUN opam pin add haxe /data --no-action && opam install haxe --deps-only

USER root
WORKDIR /data
ENV DESTDIR=/haxe-output
ENV HAXE_STD_PATH=${DESTDIR}/usr/lib/haxe/std
ENV HAXEPATH=${DESTDIR}/usr/lib/haxe
ENV HAXELIB_PATH=${DESTDIR}/usr/lib/haxe/lib
ENV PATH=$PATH:$HAXEPATH:$HAXELIB_PATH
ENV FORCE_HAXE_MAKE=false
VOLUME [ "/haxe-output"]

WORKDIR /etc
RUN echo "#!/usr/bin/env bash" > haxe-make.sh &&\
    echo "echo running MAKE" >> haxe-make.sh &&\
    echo "rm -rf ${DESTDIR}/usr" >> haxe-make.sh &&\
    echo "make" >> haxe-make.sh &&\
    echo "make install" >> haxe-make.sh &&\
    echo "haxelib install record-macros" >> haxe-make.sh  &&\
    echo "haxelib install hxjava" >> haxe-make.sh  &&\
    echo "haxelib install hxcpp" >> haxe-make.sh  &&\
    echo "haxelib install hxcs" >> haxe-make.sh  &&\
    chmod 777 haxe-make.sh

RUN echo "#!/usr/bin/env bash" > should-haxe-make.sh &&\
    echo 'if [ ! -d "$HAXEPATH" ]; then echo "${HAXEPATH} not present"; /etc/haxe-make.sh;' >> should-haxe-make.sh &&\
    echo 'elif [ ! -d "$HAXELIB_PATH" ]; then echo "${HAXELIB_PATH} not present"; /etc/haxe-make.sh;' >> should-haxe-make.sh &&\
    echo 'elif [ "$FORCE_HAXE_MAKE" = "true" ]; then echo "FORCE_HAXE_MAKE is true"; /etc/haxe-make.sh;' >> should-haxe-make.sh &&\
    echo 'fi' >> should-haxe-make.sh &&\
    chmod 777 should-haxe-make.sh

RUN echo "#!/usr/bin/env bash" > haxe-unit-test-java-run.sh &&\
    echo "/etc/should-haxe-make.sh" >> haxe-unit-test-java-run.sh &&\
    echo "pushd /data/tests/unit" >> haxe-unit-test-java-run.sh &&\
    echo "echo '*** Starting java compilation ***'" >> haxe-unit-test-java-run.sh &&\
    echo "haxe compile-java.hxml" >> haxe-unit-test-java-run.sh &&\
    echo "echo '*** Ending java compilation ***'" >> haxe-unit-test-java-run.sh &&\
    echo "echo '*** Executing java jar output ***'" >> haxe-unit-test-java-run.sh &&\
    echo "java -jar /data/tests/unit/bin/java/TestMain-Debug.jar" >> haxe-unit-test-java-run.sh &&\
    echo "echo '*** Completed executing java jar output ***'" >> haxe-unit-test-java-run.sh &&\
    echo "popd" >> haxe-unit-test-java-run.sh &&\
    echo "tail -f /dev/null" >> haxe-unit-test-java-run.sh &&\
    chmod 777 haxe-unit-test-java-run.sh

WORKDIR /data
CMD /etc/haxe-unit-test-java-run.sh