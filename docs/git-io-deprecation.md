# GIT.IO DEPRECATION

On April 25, 2022, GitHub announced that the [`git.io` redirector service would be shutting down on 2022-04-29](https://github.blog/changelog/2022-04-25-git-io-deprecation/), merely 4 days later. The announcement said that all references to `git.io` 
would stop working that day.

This was a major breaking change for Cloud Posse, because *all* of our standard Makefiles include a Makefile from this `build-harness`
project explicitly, by downloading (via `curl`) `https://git.io/build-harness`, meaning all our Makefiles would
break once that link stopped redirecting to the appropriate content.

Cloud Posse quickly set up `https://cloudposse.tools/build-harness` as a long-term replacement for `git.io`
and undertook an emergency update of all of our repositories to make this change.

While we were largely successful in updating our repositories by 2022-04-29, Cloud Posse was not fully prepared to make the
mass updates across all of our repositories that this required, so some repositories were not updated in time. Furthermore,
even if all of Cloud Posse's repositories were updated, that would not affect anyone's fork or clone or 
locally checked-out version, so we are publishing the instructions below to help you update your own code.

Fortunately, GitHub recognized the massive upheaval and loss that would be caused by completely shutting down
an URL shorting/link redirecting service, and reversed their decision to shut down `git.io` completely. Instead,
they agreed to archive the links and continue to serve existing links indefinitely, with the caveat that they
would remove links on a case-by-case basis if they were found to be malicious, misleading, or broken. 

This means that instead of being an urgent requirement that you immediately change your links, or else your builds would break,
it is now merely a recommended best practice that you update to the new link that Cloud Posse controls and 
is committed to maintaining. 

Specifically, in source files you control, you should update all references to `git.io/build-harness`
to instead refer to `cloudposse.tools/build-harness`. Critical references are in Makefiles, and there are also 
important references in README files that describe Makefiles. References in derived or downloaded files, such as 
Terraform modules downloaded by `terraform init`, do not need to be modified.
Below we provide guidance on how to make the replacements.

## Automating the update process

In all cases, these commands are intended to be run from a directory at the top of the directory tree
under which all your potentially affected code resides. Usually either the top-level directory of a single `git` repo
or a `src` (or similar) directory under which you have all your `git` repos (directly or in subdirectories).

### Finding affected files

Use the following command to find all occurrences in all directories recursively:
```
grep -l "git\.io/build-harness" -R .
```
Note that the above command can reach very deeply, such as into Terraform modules you have downloaded. You may want to impose some limits.
If you run from the top level of a `git` repo, where there is a `Makefile` and a `Dockerfile`, you can reduce that to
```
grep -l "git\.io/build-harness" *
```
If you have a lot of Cloud Posse projects under a single directory, then you might try
```
grep -l "git\.io/build-harness" * */*
```
or for full depth below the current directory
```
find . \( -name .terraform -prune -type f \)  -o \( -name build-harness -prune -type f \) -o \( -name 'Makefile*' -o -name 'README*' \) -type f
```

### Updating the affected files

Once you are happy with the command to generate the list of files to update, update the files by inserting that command into this command template:
```
sed -i '' 's/git.io\/build-harness/cloudposse.tools\/build-harness/' $(<command to list files>)
```

#### Examples

The quickest update will be if you only have a single project to update, in which case you can `cd` into the project root directory and
```
sed -i '' 's/git.io\/build-harness/cloudposse.tools\/build-harness/' $(grep -l "git\.io/build-harness" *)
```

If you have multiple projects to update and want to be thorough, then this is probably best:
```
sed -i '' 's/git.io\/build-harness/cloudposse.tools\/build-harness/' $(find . \( -name .terraform -prune -type f \)  -o \( -name build-harness -prune -type f \) -o \( -name 'Makefile*' -o -name 'README*' \) -type f )
```

This is the most thorough, but probably overkill for most people:
```
sed -i '' 's/git.io\/build-harness/cloudposse.tools\/build-harness/' $(grep -l "git\.io/build-harness" -R .)
```

