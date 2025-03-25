jdk8() {
  # alias /usr/libexec/java_home='echo $JAVA_HOME'
  export JAVA_HOME="$(/usr/libexec/java_home -v1.8)"
  export PATH="$JAVA_HOME/bin:$PATH"
}

jdk11() {
  # alias /usr/libexec/java_home='echo $JAVA_HOME'
  export JAVA_HOME="$(/usr/libexec/java_home -v11)"
  export PATH="$JAVA_HOME/bin:$PATH"
}
