## brew 镜像
export HOMEBREW_API_DOMAIN="https://mirrors.aliyun.com/homebrew-bottles/api"
export HOMEBREW_BREW_GIT_REMOTE="https://mirrors.aliyun.com/homebrew/brew.git"
export HOMEBREW_CORE_GIT_REMOTE="https://mirrors.aliyun.com/homebrew/homebrew-core.git"
export HOMEBREW_BOTTLE_DOMAIN="https://mirrors.aliyun.com/homebrew/homebrew-bottles"

# 禁止安装应用时，更新其它应用
export HOMEBREW_NO_INSTALLED_DEPENDENTS_CHECK=true
# 禁止自动更新
export HOMEBREW_NO_AUTO_UPDATE=true
