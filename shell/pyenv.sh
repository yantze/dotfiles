# pyenv
# ----------------------------

## pyenv binary 镜像
export PYTHON_BUILD_MIRROR_URL="https://pyenv-mirror.vercel.app/api/pythons"
# pyenv
pyenv_init() {
  unalias pyenv
  export PYENV_ROOT="$HOME/.pyenv"
  [[ -d $PYENV_ROOT/bin ]] && export PATH="$PYENV_ROOT/bin:$PATH"
  eval "$(pyenv init -)"
  eval "$(pyenv virtualenv-init -)"
  # 再执行一次 pyenv
  pyenv $*
}
alias pyenv="pyenv_init"

