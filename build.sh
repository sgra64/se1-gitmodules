# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
# Build-script in './libs' git-submodule that fetches .jar libraries from the
# maven repository (https://mvnrepository.com/).
# 
# Usage: source build.sh && build
# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
# 
function build() {
    [ -d libs ] && local cd_back=$(pwd) && builtin cd libs
    # 
    for lib_dir in jackson logging lombok jacoco junit . ; do
        local jars=()
        # create lib sub-directory
        [ ! -d "$lib_dir" ] && mkdir "$lib_dir" && echo "created: $lib_dir"
        # 
        case "$lib_dir" in

        jackson) jars=( # upgraded from '2.13.0'
            com/fasterxml/jackson/core/jackson-annotations/2.19.0/jackson-annotations-2.19.0.jar
            com/fasterxml/jackson/core/jackson-core/2.19.0/jackson-core-2.19.0.jar
            com/fasterxml/jackson/core/jackson-databind/2.19.0/jackson-databind-2.19.0.jar
        ) ;;

        logging) jars=( # upgraded from '2.23.1', slf4j-api-2.0.17.jar to '2.0.16'
            org/apache/logging/log4j/log4j-api/2.24.3/log4j-api-2.24.3.jar
            org/apache/logging/log4j/log4j-core/2.24.3/log4j-core-2.24.3.jar
            org/apache/logging/log4j/log4j-slf4j2-impl/2.24.3/log4j-slf4j2-impl-2.24.3.jar
            org/slf4j/slf4j-api/2.0.17/slf4j-api-2.0.17.jar
        ) ;;

        lombok) jars=(  # upgraded from '1.18.36'
            org/projectlombok/lombok/1.18.38/lombok-1.18.38.jar
        ) ;;

        # https://mvnrepository.com/artifact/org.jacoco
        jacoco) jars=(  # upgrade '0.8.11' -> '0.8.13'
            https://raw.githubusercontent.com/sgra64/se1-play/refs/heads/libs/jacoco/jacocoagent.jar
            https://raw.githubusercontent.com/sgra64/se1-play/refs/heads/libs/jacoco/jacococli.jar
            # org/jacoco/org.jacoco.agent/0.8.13/org.jacoco.agent-0.8.13.jar
            # org/jacoco/org.jacoco.cli/0.8.13/org.jacoco.cli-0.8.13.jar
        ) ;;

        junit) jars=(   # upgrade '1.9.2' -> '1.12.2'
            org/apiguardian/apiguardian-api/1.1.2/apiguardian-api-1.1.2.jar
            org/junit/jupiter/junit-jupiter-api/5.12.2/junit-jupiter-api-5.12.2.jar
            org/junit/platform/junit-platform-commons/1.9.2/junit-platform-commons-1.9.2.jar
            org/opentest4j/opentest4j/1.3.0/opentest4j-1.3.0.jar
        ) ;;

        \.) jars=(  # fetch JUnit5 stand-alone test runner
            org/junit/platform/junit-platform-console-standalone/1.9.2/junit-platform-console-standalone-1.9.2.jar
        ) ;;
        esac; 
        for jar in "${jars[@]}"; do
            # prefix incomplete 'org/...'-paths with maven repository url
            local source="maven-repository"
            [[ ${jar:0:4} == "http" ]] && local url="$jar" && source="URL" || \
                local url="https://repo1.maven.org/maven2/$jar"
            # 
            local filename=$(basename "$jar")
            if [ ! -f "$lib_dir/$filename" ]; then
                curl -o "$lib_dir/$filename" "$url" 2>/dev/null
                if [[ $? == 0 ]]; then
                    echo " - curl fetched from $source: $lib_dir/$filename"
                else
                    wget -O "$lib_dir/$filename" "$url" 2>/dev/null
                    if [[ $? == 0 ]]; then
                        echo " - wget fetched from $source: $lib_dir/$filename"
                    else
                        echo "found neither 'curl' nor 'wget' to download: $url" && \
                        echo "--> install 'curl' or 'wget' or download libraries manually" && \
                        return 1
                    fi
                fi
            fi
        done
    done
    [ -d "$cd_back" ] && builtin cd "$cd_back"
}
