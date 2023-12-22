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
Type "mkdir demo"
Enter
Type "cd demo"
Enter
Sleep 500ms
Type "vim Makefile" Enter
Sleep 1
Type "i"
Sleep 1s
Type "# Example Makefile leveraging the build-harness!" Enter
Sleep 500ms
Type "export DOCKER_ORG ?= acme" Enter
Type "export DOCKER_IMAGE ?= $(DOCKER_ORG)/demo" Enter
Type "export DOCKER_TAG ?= latest" Enter
Type "export DOCKER_IMAGE_NAME ?= $(DOCKER_IMAGE):$(DOCKER_TAG)" Enter
Type "export DOCKER_BUILD_FLAGS =" Enter
Sleep 500ms
Type "# Import the remote Makefile shim" Enter
Sleep 500ms
Type '-include $(shell curl -sSL -o .build-harness "https://cloudposse.tools/build-harness"; echo .build-harness)' Enter
Sleep 1
Escape
Type ":wq" Enter
Type "# Now let's initialize the build-harness" Enter
Sleep 500ms
Type "make init" Enter
Sleep 2s
Type "# We have successfully initialized the .build-harness" Enter
Sleep 500ms
Type "ls -al" Enter
Sleep 500ms
Type "# Now let's create a new Docker image using the build-harness..." Enter
Sleep 500ms
Type "vim Dockerfile" Enter
Sleep 1
Type "i"
Sleep 500ms
Type "FROM alpine:latest" Enter 2
Type "RUN apk add nginx" Enter
Sleep 500ms
Escape
Type ":wq" Enter
Sleep 500ms
Enter

Type "# Now let's build a docker image" Enter
Sleep 1
Type "make docker/build" Enter
Sleep 2s
Type "# that was easy!" Enter
Sleep 2s

