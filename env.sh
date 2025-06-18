# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
# Set up the project environment with mvn:
# - CLASSPATH
# - show_classpath
# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
if [ -f pom.xml ]; then
    # 
    [ -d .vscode ] && cpfile=".vscode/.classpath" || cpfile=".classpath-file"
    # 
    # generate classpath from maven dependencies and store in file '.classpath'
    mvn dependency:build-classpath -Dmdep.outputFile="$cpfile".tmp -q

    # prepend 'target/classes' for compiled classes to CLASSPATH
    # Windows uses ';' as classpath separator while MacOS and Unix/Linux use ':'
    [[ "$(uname)" =~ (CYGWIN|MINGW) ]] && sep=';' || sep=':'
    # 
    echo -n "target/classes$sep" > "$cpfile" && \
        tr '\\' '/' < "$cpfile".tmp >> "$cpfile" && \
        echo >> "$cpfile"

    # set CLASSPATH environment variable from file '.classpath'
    while read line; do export CLASSPATH="$line"; done < "$cpfile"

    function show_classpath() {
        if [ "$CLASSPATH" ]; then
            [[ "$(uname)" =~ (CYGWIN|MINGW) ]] && local sep=';' || local sep=':'
            echo $CLASSPATH | tr "$sep" '\n' > .cp1
            sed -e '/\.jar/d' < .cp1 > .cp2
            sed -e '/\.jar/!d' -e 's!.*/!!' < .cp1 | sort > .cp3
            echo " - CLASSPATH:" && cat .cp[23] | sed -e 's/.*/   - &/'
            rm -f .cp[123]
        else
            echo "CLASSPATH is not set (empty)"
        fi
    }

    echo -e "\\\\\ \nproject environment has been set with:"
    echo " - created file: .classpath"
    show_classpath

    rm "$cpfile".tmp; unset cpfile sep
else
    echo "no 'pom.xml' (maven build file)"
fi