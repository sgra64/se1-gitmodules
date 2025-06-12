# *Git-Submodules* for *se1* - Projects

This repository contains *Git-Submodules* for *se1* - projects.

A [*Git Submodule*](https://git-scm.com/docs/git-submodule)
(read the: [*article*](https://www.freecodecamp.org/news/how-to-use-git-submodules/))
is a mechanism to import branches from external ("*remote*") *git* repositories into a
project as *sub-modules*.

*Sub-modules* exist as *branches* in this repository:

- [*env*](../../tree/env) - module with the "*sourcing script*" `env.sh` to set up the environment.

- [*vscode*](../../tree/vscode) - module with configuration settings for the *VSCode* IDE.

- [*libs*](../../tree/libs) - module with a build script to install `.jar` libraries.



&nbsp;

---
Install *sub-modules* in steps:

1. [Install *Git-Submodules*](#1-install-git-submodules)

1. [Build the *libs-Submodule*](#2-build-the-libs-submodule)



&nbsp;

## 1. Install *Git-Submodules*

The pattern for importing a *git submodule* into a project is:
```
git submodule add -b <remote-branch> -- <remote-URL> <local-dir-name>
```

Install sub-modules into the project:

```sh
# import submodule '.env' from branch 'env' of the gitmodules repository
git submodule add -b env -f -- https://github.com/sgra64/se1-gitmodules.git .env

# import submodule '.vscode' from branch 'vscode'
git submodule add -b vscode -f -- https://github.com/sgra64/se1-gitmodules.git .vscode

# import submodule '.libs'
git submodule add -b libs -f -- https://github.com/sgra64/se1-gitmodules.git libs
```

New folders `.env`, `.vscode` and `libs` and a new file `.gitmodules` have been created
in the project directory:

```sh
ls -la                      # show new content of the 'se1-play' project directory
```
```
total 21
drwxr-xr-x 1 svgr2 Kein    0 Apr  6 19:17 .
drwxr-xr-x 1 svgr2 Kein    0 Apr  6 18:29 ..
drwxr-xr-x 1 svgr2 Kein    0 Apr  6 19:06 .env          <-- new submodule '.env'
drwxr-xr-x 1 svgr2 Kein    0 Apr  6 19:17 .git
-rw-r--r-- 1 svgr2 Kein 1214 Apr  6 19:31 .gitignore
-rw-r--r-- 1 svgr2 Kein  295 Apr  6 19:17 .gitmodules   <-- new '.gitmodules' file
drwxr-xr-x 1 svgr2 Kein    0 Apr  6 19:11 .vscode       <-- new submodule '.vscode'
drwxr-xr-x 1 svgr2 Kein    0 Apr  6 19:17 libs          <-- new submodule '.libs'
```

Show the `.gitmodules` file that also has been created:

```sh
cat .gitmodules             # show content of the '.gitmodules' file
```
```
[submodule ".env"]
        path = .env
        url = https://github.com/sgra64/se1-gitmodules.git
        branch = env
[submodule ".vscode"]
        path = .vscode
        url = https://github.com/sgra64/se1-gitmodules.git
        branch = vscode
[submodule "libs"]
        path = libs
        url = https://github.com/sgra64/se1-gitmodules.git
        branch = libs
```

Commit submodules and the new *.gitmodules* file:

```sh
git add .gitmodules                 # stage .gitmodules file
git commit -m "add .gitmodules file and modules .env, .vscode, libs"

git log --oneline                   # show the commit log (history of all commits)
```
```
5834efb (HEAD -> main) add .gitmodules              <-- new commit
42ec65a add .gitignore
52f8547 (tag: root) root commit (empty)
```



&nbsp;

## 2. Build the *libs-Submodule*

The *libs-Submodule* includes a
[*build.sh*](https://github.com/sgra64/se1-gitmodules/blob/libs/build.sh) *- script*
that installs library `.jar` files from the
[*Maven-Repository*](https://mvnrepository.com/), which includes all
publicly available Java code distributed as `.jar` files since the year
2000, see the *Maven*
[*history*](https://www.sonatype.com/blog/the-history-of-maven-central-and-sonatype-a-journey-from-past-to-present).

After the *libs-submodule* has been installed, source the *build.sh - script*
and call the *build()* function. This will download all required `.jar` files
from the *Maven-Repository*.

```sh
source libs/build.sh            # source the build.sh script

build                           # invoke the build() function
```
```
created: jackson
 - curl fetched from maven-repository: jackson/jackson-annotations-2.19.0.jar
 - curl fetched from maven-repository: jackson/jackson-core-2.19.0.jar
 - curl fetched from maven-repository: jackson/jackson-databind-2.19.0.jar
created: logging
 - curl fetched from maven-repository: logging/log4j-api-2.24.3.jar
 - curl fetched from maven-repository: logging/log4j-core-2.24.3.jar
 - curl fetched from maven-repository: logging/log4j-slf4j2-impl-2.24.3.jar
 - curl fetched from maven-repository: logging/slf4j-api-2.0.17.jar
created: lombok
 - curl fetched from maven-repository: lombok/lombok-1.18.38.jar
created: jacoco
 - curl fetched from maven-repository: jacoco/jacocoagent.jar
 - curl fetched from maven-repository: jacoco/jacococli.jar
created: junit
 - curl fetched from maven-repository: junit/apiguardian-api-1.1.2.jar
 - curl fetched from maven-repository: junit/junit-jupiter-api-5.12.2.jar
 - curl fetched from maven-repository: junit/junit-platform-commons-1.12.2.jar
 - curl fetched from maven-repository: junit/opentest4j-1.3.0.jar
 - curl fetched from maven-repository: ./junit-platform-console-standalone-1.12.2.jar
```

Verify `.jar` files have arrived in the `libs` folder:

```sh
find libs                       # verify content of 'libs' folder
```
```
libs/
libs/.gitignore
libs/build.sh
libs/jackson
libs/jackson/jackson-annotations-2.19.0.jar
libs/jackson/jackson-core-2.19.0.jar
libs/jackson/jackson-databind-2.19.0.jar
libs/jacoco
libs/jacoco/jacocoagent.jar
libs/jacoco/jacococli.jar
libs/junit
libs/junit/apiguardian-api-1.1.2.jar
libs/junit/junit-jupiter-api-5.12.2.jar
libs/junit/junit-platform-commons-1.12.2.jar
libs/junit/opentest4j-1.3.0.jar
libs/junit-platform-console-standalone-1.12.2.jar
libs/logging
libs/logging/log4j-api-2.24.3.jar
libs/logging/log4j-core-2.24.3.jar
libs/logging/log4j-slf4j2-impl-2.24.3.jar
libs/logging/slf4j-api-2.0.17.jar
libs/lombok
libs/lombok/lombok-1.18.38.jar
libs/README.md
```
