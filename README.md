## 步骤

### 1. 安装 Docker

如果你尚未安装Docker，请先在你的系统上安装Docker。你可以在[Docker官方网站](https://www.docker.com/get-started)上找到安装说明。确保Docker安装成功并能够在命令行中运行。

### 2. 調整Docker設定檔

这一步需要调整Docker配置文件，包括Dockerfile、php.ini、和Nginx配置文件，以适应你的项目的要求。在Dockerfile中，你可以指定需要安装的PHP扩展和其他依赖项。在php.ini文件中，你可以自定义PHP的配置。Nginx配置文件允许你定义Nginx服务器的行为。
#### docker-compose.yml
1.redis
2.mysql
    <!-- 2.1: volumes 本地要安裝 安裝完路徑為 /usr/local/mysql:/var/lib/mysql
    /usr/local/mysql 為本地安裝mysql的路徑
    2.2: 安裝sequel Ace 本地 host127.0.0.1  帳號 root 密碼 test_pass port 1801 -->
    docker pull mysql:8
    docker run --name sql1 -p 3306:3306 -e MYSQL_ROOT_PASSWORD=test1234 -d mysql:8
    docker run --name sql2 -p 1801:3306 -e MYSQL_ROOT_PASSWORD=test1234 -d mysql:8
3.nginx
4.php+版本
5.env PROJECT_DOCUMENT_ROOT要改 
    5.1 '${PROJECT_DOCUMENT_ROOT}/:/baifu' 要對應在本機的資料夾 mac為 /Users/使用者名稱/*****/

#### 新增專案
只需要在專案需要的php版本上 php(版本)/nginx/sites-available/ 加上*****.conf
server_name 
root
fastcgi_pass (docker-compose.yml中的php版本):9000
#### 路徑
專案放在 /Users/user/docker-php-env 及 /Users/user/＊＊＊＊（此地方也是env路徑）

### 調整本機的hosts
在这一部分，提醒你需要调整 `/privates/etc/hosts` 文件，加入项目的网址。以下是当前项目的域名列表：

127.0.0.1       fusion-local.spgamesmanager.net
127.0.0.1       local.spmobileapi.net
```

# XDebug 在 VSCode
这一部分提醒你，設置`.vscode/launch.json`的設定為：
```
{
    "version": "0.2.0",
    "configurations": [
        {
            "name": "Listen for Xdebug",
            "type": "php",
            "request": "launch",
            "port": 9003,
            "pathMappings": {
                # 容器內路徑 : 本機專案路徑
                "/baifu": "/Users/使用者名稱/*****"
            }
        }
    ]
}
```