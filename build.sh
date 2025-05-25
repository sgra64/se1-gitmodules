# Disable zsh to output ANSI escape chars in sub-processes $(...),
# setopt no_match: disable 'no matches found:' message in zsh.
type setopt 2>/dev/null | grep builtin >/dev/null
[ $? = 0 ] && \
    trap "" DEBUG && setopt no_nomatch

# sub-directories to build
libs_dir=libs
sub_dirs=(jackson logging lombok jacoco junit . )

# .jar files to include in sub-directories
declare -gA libs=(
    # upgraded from '1.18.36'
    [lombok]=" \
        org/projectlombok/lombok/1.18.38/lombok-1.18.38.jar"

    # upgraded from '2.13.0'
    [jackson]=" \
        com/fasterxml/jackson/core/jackson-annotations/2.19.0/jackson-annotations-2.19.0.jar \
        com/fasterxml/jackson/core/jackson-core/2.19.0/jackson-core-2.19.0.jar \
        com/fasterxml/jackson/core/jackson-databind/2.19.0/jackson-databind-2.19.0.jar"

    # upgraded from '2.23.1', slf4j-api-2.0.17.jar to '2.0.16'
    [logging]=" \
        org/apache/logging/log4j/log4j-api/2.24.3/log4j-api-2.24.3.jar \
        org/apache/logging/log4j/log4j-core/2.24.3/log4j-core-2.24.3.jar \
        org/apache/logging/log4j/log4j-slf4j2-impl/2.24.3/log4j-slf4j2-impl-2.24.3.jar \
        org/slf4j/slf4j-api/2.0.17/slf4j-api-2.0.17.jar"

    # upgrade '1.9.2' -> '1.12.2'
    [junit]=" \
        org/apiguardian/apiguardian-api/1.1.2/apiguardian-api-1.1.2.jar \
        org/junit/jupiter/junit-jupiter-api/5.12.2/junit-jupiter-api-5.12.2.jar \
        org/junit/platform/junit-platform-commons/1.9.2/junit-platform-commons-1.9.2.jar \
        org/opentest4j/opentest4j/1.3.0/opentest4j-1.3.0.jar"

    [.]=" \
        org/junit/platform/junit-platform-console-standalone/1.9.2/junit-platform-console-standalone-1.9.2.jar"

    # @TODO: load .jars from original source rather than git repo
    [jacoco]=" \
        https://raw.githubusercontent.com/sgra64/se1-play/refs/heads/libs/jacoco/jacocoagent.jar \
        https://raw.githubusercontent.com/sgra64/se1-play/refs/heads/libs/jacoco/jacococli.jar"
)

# 
# run 'build' to create subdirectories in 'libs' and fetch libs from URLs
# 
function build() {
    [ -d "$libs_dir" ] && local back=$(pwd) && builtin cd "$libs_dir"
    for d in ${sub_dirs[@]}; do
        # create sub-directory
        [ ! -d "$d" ] && mkdir "$d" && echo "created: $d"
        [ -d "$d" ] && \
            for lib in ${libs["$d"]}; do
                [[ ${lib:0:4} == "http" ]] && local url="$lib" && echo "url: --> $url" || \
                    local url="https://repo1.maven.org/maven2/$lib"
                # 
                local filename=$(basename "$lib")
                if [ ! -f "$d/$filename" ]; then
                    curl -o "$d/$filename" "$url" 2>/dev/null
                    if [[ $? == 0 ]]; then
                        echo " - curl fetched from maven-repository: $d/$filename"
                    else
                        wget -O "$d/$filename" "$url" 2>/dev/null
                        if [[ $? == 0 ]]; then
                            echo " - wget fetched from maven-repository: $d/$filename"
                        else
                            echo "found neither 'curl' nor 'wget' to download: $url" && \
                            echo "--> install 'curl' or 'wget' or download libraries manually" && \
                            return 1
                        fi
                    fi
                fi
            done
    done
    [ -d "$back" ] && builtin cd "$back"
}
