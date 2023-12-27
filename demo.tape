# Demo of Geodesic

Output docs/demo.gif

Set Theme "Monokai Vivid"

Set FontFamily "FiraCode Nerd Font"
#Set FontFamily "Hack Nerd Font"
Set FontSize 14

Set TypingSpeed 40ms

Set Framerate 30

Set WindowBar Colorful

Set CursorBlink true

Set BorderRadius 8

Set Margin 20
Set MarginFill "#674EFF"

Set Padding 12

Set Width 1200
Set Height 600

Set PlaybackSpeed 1

Set Shell bash

Sleep 3s
Type "mkdir demo" Sleep 500ms Enter
Type "cd demo" Sleep 500ms Enter
Type "vim Makefile" Sleep 500ms Enter
Sleep 1
Type "i"
Sleep 1s
Type "# Example Makefile leveraging the build-harness!" Sleep 500ms Enter
Type "export DOCKER_ORG ?= acme" Sleep 500ms Enter
Type "export DOCKER_IMAGE ?= $(DOCKER_ORG)/demo" Sleep 500ms Enter
Type "export DOCKER_TAG ?= latest" Sleep 500ms Enter
Type "export DOCKER_IMAGE_NAME ?= $(DOCKER_IMAGE):$(DOCKER_TAG)" Sleep 500ms Enter
Type "export DOCKER_BUILD_FLAGS =" Sleep 500ms Enter
Sleep 500ms

Type "# Import the remote Makefile shim" Sleep 500ms Enter
Sleep 500ms
Type '-include $(shell curl -sSL -o .build-harness "https://cloudposse.tools/build-harness"; echo .build-harness)' Enter
Sleep 1
Escape
Type ":wq" Sleep 500ms Enter
Type "# Now let's initialize the build-harness" Sleep 500ms Enter
Sleep 500ms
Type "make init" Sleep 500ms Enter
Sleep 2s
Type "# We have successfully initialized the .build-harness" Sleep 500ms Enter
Sleep 500ms
Type "ls -al" Sleep 500ms Enter
Sleep 500ms
Type "# Now let's create a new Docker image using the build-harness..." Sleep 500ms Enter
Sleep 500ms
Type "vim Dockerfile" Sleep 500ms Enter
Sleep 1
Type "i" Sleep 500ms
Type "FROM alpine:latest" Sleep 500ms Enter 2
Type "RUN apk add nginx" Sleep 500ms Enter
Sleep 500ms
Escape
Type ":wq" Sleep 500ms Enter
Sleep 500ms
Enter

Type "# Now let's build a docker image" Sleep 500ms Enter
Sleep 1
Type "make docker/build" Sleep 500ms Enter
Sleep 2s
Type "# that was easy!" Sleep 500ms Enter
Sleep 2s

