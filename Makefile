SHELL_BASE=docker run --rm -ti
BASE=docker run --rm -td
OPTS=-e DISPLAY \
     -e XAUTHORITY \
     -e XDG_RUNTIME_DIR \
     -v /tmp/.X11-unix:/tmp/.X11-unix:rw,Z \
     -v $$XAUTHORITY:$$XAUTHORITY \
     -v /run/user/1000/pulse:/run/user/1000/pulse:rw,Z \
     -v $$XDG_RUNTIME_DIR:$$XDG_RUNTIME_DIR:rw,Z \
     -v /dev/shm:/dev/shm \
     -v /etc/machine-id:/etc/machine-id \
     -v ~/.config/pulse:/home/developer/.config/pulse \
     --device /dev/video0 \
     --security-opt label=type:container_runtime_t --security-opt seccomp=seccomp-chrome.json bluejeans

all:
	bash -n entrypoint.sh
	docker build -t bluejeans .

browser:
	$(BASE) $(OPTS)

shell:
	$(SHELL_BASE) $(OPTS) /bin/bash
