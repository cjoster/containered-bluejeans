# Containered Bluejeans on linux

This is a PoC to get video conferencing working in a containered browser and was
focused on Blue Jeans, but can, in theory, be used for any sound/video enabled
website.
The primary issue was pushing not only X11 sockets and such up to the container,
but also pulseaudio as well as video devices and setting security contexts. To get this working, you'll have to identify your
webcam device if it's not /dev/video0 as well as identify the location of your X11 and pulse sockets.

This is primarily a PoC and is intended to work in a Fedora 27 container on Fedora 27.

To build, simply run `make`. Once successful, run `make browser` to launch the browser. If you
need a shell in the container to troubleshoot, run `make shell`. Obviously requires make.

Many thanks to https://github.com/sameersbn/docker-browser-box and the folks at bluejeans for
their help troubleshooting.
