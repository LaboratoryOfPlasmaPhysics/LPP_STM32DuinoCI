FROM fedora:34

RUN dnf install -y arduino-builder.x86_64 arduino-core.noarch bzip2 patch && dnf clean all -y && \
	curl -L -o arduino-cli.tar.bz2 https://downloads.arduino.cc/arduino-cli/arduino-cli-latest-linux64.tar.bz2 && \
	tar xjf arduino-cli.tar.bz2 && rm -f arduino-cli.tar.bz2 && \
	mv arduino-cli /usr/bin/ && arduino-cli config init

COPY arduino-cli.yaml /root/.arduino15/arduino-cli.yaml
COPY bbone_patch-2.0.txt /bbone_patch-2.0.txt

RUN  arduino-cli core update-index && arduino-cli core update-index && arduino-cli lib update-index && arduino-cli core install  STMicroelectronics:stm32 && \
     cd /root/.arduino15/packages && patch -p0   < /bbone_patch-2.0.txt

