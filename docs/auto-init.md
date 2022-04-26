<!-- markdownlint-disable -->
## Using the "auto-init" feature

Typically, the `build-harness` project requires running `make init` before any of the Makefile targets can be invoked. The `init` target will "install" the `build-harness` project and "include" the `Makefile` from the `build-harness` project.

Alternatively, the "auto-init" feature can automatically run the `init` logic for you to install the `build-harness` and help keep the install up-to-date. This feature is enabled using the env or Makefile variable `BUILD_HARNESS_AUTO_INIT=true`. By default, this feature is disabled; to enable it, you must set the variable yourself.

**Note:** The "auto-init" feature is a convenience for running `make` interactively. Regardless of your setting of `BUILD_HARNESS_AUTO_INIT`, "auto-init" will be disabled if `make` is running inside a Docker container. Scripts and automation should continue to call `make init` explicitly. 

```make
BUILD_HARNESS_AUTO_INIT = true

-include $(shell curl -sSL -o .build-harness "https://cloudposse.tools/build-harness"; echo .build-harness)
```

The "auto-init" feature will _also_ keep the install up-to-date. It will check the value of `BUILD_HARNESS_BRANCH`, get the commit ID, compare that to the current checkout, and update the clone if they differ. A useful side-effect is that it becomes easy to pin to versions of the `build-harness` from your own project, and let the `build-harness` update itself as you update the pin:

```make
BUILD_HARNESS_AUTO_INIT = true
BUILD_HARNESS_BRANCH = {TAG}

-include $(shell curl -sSL -o .build-harness "https://cloudposse.tools/build-harness"; echo .build-harness)
```

Now when you run `make` the project will update itself to use the version specified by the `BUILD_HARNESS_BRANCH` value:

```sh
$ make help
Removing existing build-harness
Cloning https://github.com/cloudposse/build-harness.git#{TAG}...
Cloning into 'build-harness'...
remote: Enumerating objects: 143, done.
remote: Counting objects: 100% (143/143), done.
remote: Compressing objects: 100% (118/118), done.
remote: Total 143 (delta 7), reused 71 (delta 3), pack-reused 0
Receiving objects: 100% (143/143), 85.57 KiB | 2.09 MiB/s, done.
Resolving deltas: 100% (7/7), done.
Available targets:

  aws/install                         Install aws cli bundle
```
<!-- markdownlint-restore -->
