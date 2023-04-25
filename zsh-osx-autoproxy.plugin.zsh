#!/bin/zsh

# 定义设置代理环境变量的函数
set_proxy_env() {
    typeset proxy_type=$1
    typeset env_var_name=$2
    typeset proxy_info

    if [ "$proxy_type" = "socks" ]; then
        proxy_info=$(networksetup -getsocksfirewallproxy "$network_service")
    elif [ "$proxy_type" = "https" ]; then 
        proxy_info=$(networksetup -getsecurewebproxy "$network_service")
    else
        proxy_info=$(networksetup -getwebproxy "$network_service") 
    fi

    typeset proxy_server=$(echo "$proxy_info" | grep -Eo '^Server: .*' | sed -E 's/^Server: //')
    typeset proxy_port=$(echo "$proxy_info" | grep -Eo '^Port: .*' | sed -E 's/^Port: //')
    typeset proxy_enabled=$(echo "$proxy_info" | grep -Eo '^Enabled: .*' | sed -E 's/^Enabled: //')

    if [ "$proxy_enabled" = "Yes" ]; then
        if [ "$proxy_type" = "git" ]; then
            git config --global "$env_var_name" "http://$proxy_server:$proxy_port"
        elif [ "$proxy_type" = "socks" ]; then
            export "$env_var_name=socks5://$proxy_server:$proxy_port"
        else
            export "$env_var_name=http://$proxy_server:$proxy_port"
        fi
    fi

    if [ "$proxy_type" = "http" ]; then
        typeset bypass_domains=$(networksetup -getproxybypassdomains "$network_service" | tr '\n' ',')
        export no_proxy="${bypass_domains%,}"
    fi
}

# 获取当前活动网络服务
network_service=$(networksetup -listallnetworkservices | grep -E 'Wi-Fi|AirPort|Ethernet' | head -1)

proxy() {
    # 设置 HTTP、HTTPS 和 SOCKS 代理环境变量
    set_proxy_env "http" "http_proxy"
    set_proxy_env "https" "https_proxy"
    set_proxy_env "socks" "all_proxy"
    set_proxy_env "git" "http.proxy"
    set_proxy_env "git" "https.proxy"
}

noproxy() {
    unset http_proxy
    unset https_proxy
    unset all_proxy
    unset no_proxy
    git config --global --unset http.proxy
    git config --global --unset https.proxy
}

proxy