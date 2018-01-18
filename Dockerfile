FROM fedora:27

# Set our timezone
RUN rm -f /etc/localtime && ln -s /usr/share/zoneinfo/America/Chicago /etc/localtime

RUN dnf -y update && dnf -y install sudo xauth pulseaudio pulseaudio-module-x11 pavucontrol liberation-sans-fonts liberation-mono-fonts liberation-serif-fonts liberation-fonts-common opus

RUN export uid=1000 gid=1000 && mkdir -p /home/developer && echo "developer:x:${uid}:${gid}:developer,,,:/home/developer:/bin/bash" >> /etc/passwd && \
	echo "developer:x:${gid}:" >> /etc/group && usermod -aG wheel,video developer && echo "%wheel ALL=(ALL) NOPASSWD: ALL" > /etc/sudoers.d/wheel && \
	chmod 0440 /etc/sudoers.d/wheel && mkdir -p /run/user/${uid}/pulse

COPY google-chrome.repo /etc/yum.repos.d/
RUN dnf -y install google-chrome-stable

RUN rm -rf /var/cache/dnf

RUN mkdir -p /home/developer/.config/pulse
RUN mkdir -p /run/user/$(id -u developer)/pulse
COPY entrypoint.sh /home/developer/
RUN sudo chown -R developer.developer /home/developer
USER developer
ENV HOME /home/developer
WORKDIR /home/developer
ENTRYPOINT ["/home/developer/entrypoint.sh"]
