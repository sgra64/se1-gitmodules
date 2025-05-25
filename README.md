# Project: *se1-play* - branch: *libs*

The `libs` branch contains libraries needed by the project.

This includes libraries for:

- `jackson`: processing JSON data in Java

- `jacoco`: code coverage library for Java

- `junit`: libraries for JUnit tests

- `logging`: *log4j2* logging library for Java

- `lombok`: library to avoid boilerplate code for Java

- `junit-platform-console-standalone-1.9.2.jar`: JUnit test runner


Libraries are organized in folders with *.jar*-files:

```sh
<libs>                  # branch directory
 |
 +--jars-content.txt    # file with list of .jar files included in <libs>
 |
 +-<jackson>                    # library for processing JSON data in Java
 |  +--jackson-annotations-2.19.0.jar
 |  +--jackson-core-2.19.0.jar
 |  +--jackson-databind-2.19.0.jar
 |
 +-<jacoco>                     # code coverage library for Java
 |  +--jacocoagent.jar
 |  +--jacococli.jar
 |
 +-<junit>                      # libraries for JUnit tests
 |  +--apiguardian-api-1.1.2.jar
 |  +--junit-jupiter-api-5.12.2.jar
 |  +--junit-platform-commons-1.12.2.jar
 |  +--opentest4j-1.3.0.jar
 |                              # JUnit test runner
 +--junit-platform-console-standalone-1.12.2.jar
 |
 +-<logging>                    # log4j2 logging library for Java
 |  +--log4j-api-2.24.3.jar
 |  +--log4j-core-2.24.3.jar
 |  +--log4j-slf4j2-impl-2.24.3.jar
 |  +--slf4j-api-2.0.17.jar
 |
 +-<lombok>                     # lombok library
    +--lombok-1.18.38.jar
```


Checkout the `libs` branch:

```sh
git clone -b libs --single-branch git@github.com:sgra64/se1-play.git libs

ls -la libs                     # show content of new 'libs' directory
```

Output shows the content of the new `libs` directory:

```
total 2584
drwxr-xr-x 1       0 Oct  3 19:11 ./
drwxr-xr-x 1       0 Oct  3 18:42 ../
drwxr-xr-x 1       0 Oct  3 19:18 .git/
-rw-r--r-- 1    1932 Oct  3 19:19 README.md
drwxr-xr-x 1       0 Oct  3 19:20 jackson/
drwxr-xr-x 1       0 Oct  3 19:20 jacoco/
-rw-r--r-- 1     616 Oct  3 19:20 jars-content.txt
drwxr-xr-x 1       0 Oct  3 19:20 junit/
-rw-r--r-- 1 2614420 Oct  3 19:20 junit-platform-console-standalone-1.12.2.jar
drwxr-xr-x 1       0 Oct  3 19:20 logging/
drwxr-xr-x 1       0 Oct  3 19:20 lombok/
```

List content of *jar* files:

```sh
find . -name '*.jar'
```

The list corresponds to the content of file
[jars-content.txt](jars-content.txt):

```
./jackson/jackson-annotations-2.19.0.jar
./jackson/jackson-core-2.19.0.jar
./jackson/jackson-databind-2.19.0.jar
./jacoco/jacocoagent.jar
./jacoco/jacococli.jar
./junit/apiguardian-api-1.1.2.jar
./junit/junit-jupiter-api-5.12.2.jar
./junit/junit-platform-commons-1.12.2.jar
./junit/opentest4j-1.3.0.jar
./junit-platform-console-standalone-1.12.2.jar
./logging/log4j-api-2.24.3.jar
./logging/log4j-core-2.24.3.jar
./logging/log4j-slf4j2-impl-2.24.3.jar
./logging/slf4j-api-2.0.17.jar
./lombok/lombok-1.18.38.jar
```
