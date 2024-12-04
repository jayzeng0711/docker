# 百阜PHP环境

## Docker PHP 7.4 和 PHP 8

在这个示例中，我们将使用Docker多阶段构建创建一个包含PHP 7.4和PHP 8的双环境容器，以便你可以根据需要切换PHP版本。

## 步骤

### 1. 安装 Docker

如果你尚未安装Docker，请先在你的系统上安装Docker。你可以在[Docker官方网站](https://www.docker.com/get-started)上找到安装说明。确保Docker安装成功并能够在命令行中运行。

### 2. 調整Docker設定檔

这一步需要调整Docker配置文件，包括Dockerfile、php.ini、和Nginx配置文件，以适应你的项目的要求。在Dockerfile中，你可以指定需要安装的PHP扩展和其他依赖项。在php.ini文件中，你可以自定义PHP的配置。Nginx配置文件允许你定义Nginx服务器的行为。
#### Dockerfile

安裝內容及新增安裝擴展、指令，例如：`docker-php-env/php7/phpdocker/php-fpm/Dockerfile`。

#### Php.ini

php設定，路徑：`docker-php-env/php7/phpdocker/php-fpm/php-ini-overrides.ini`。

#### Nginx

nginx設定，路徑：`docker-php-env/php7/phpdocker/nginx/nginx.conf`。

### 3. 調整 Docker Compose

这一步需要调整Docker Compose配置文件，它定义了多个Docker容器之间的关系和设置。确保你的Docker Compose文件包括了你的PHP容器和Nginx容器，以及它们之间的通信和挂载的卷，路徑：`docker-php-env/php7/docker-compose.yml`。

### 4. 运行 Docker 容器

在这一步，你可以启动 Docker 容器。你提供了两种不同的方式来启动容器，一种是使用 shell 脚本 `env74.sh`（`env80.sh`） 来启动，另一种是使用 Docker Compose 命令。

使用 shell 脚本启动容器时，只需执行脚本，它会自动执行所需的 Docker Compose 命令，启动 PHP 容器和 Nginx 容器。



```bash
#### PHP 7.4
cd ~/docker-php-env
# 使用 env74.sh 脚本来启动 Docker 容器
sh env74.sh

#### PHP 8
cd ~/docker-php-env
# 使用 env8.sh 脚本来启动 Docker 容器
sh env80.sh
```
使用 Docker Compose 命令时，你需要进入你的 PHP 7.4 或 8 的项目目录，并执行 `docker-compose up -d` 命令来启动容器。这将创建并运行容器，以便你的 PHP 应用程序可以访问。

```bash
#### PHP 7.4
cd ~/docker-php-env/php7
docker-compose up -d

#### PHP 8
cd ~/docker-php-env/php8
docker-compose up -d
```

> 请注意，目前 docker-compose 配置中的 PHP 8.0 和 PHP 7.4 都监听 localhost:80，因此在同时运行它们时可能会发生冲突。如果需要同时运行，请根据需求自行调整 docker-compose 等文件。

### 5. 获取项目

运行 Docker 容器将创建一个项目目录，用于存放你的 PHP 应用程序文件。使用 clone 或其他相应的命令获取项目内容，然后将其放入对应版本的文件夹 `~/project/php7` 或 `~/project/php8`。

```bash
# 进入 PHP 7.4 项目目录
cd ~/project/php7
mkdir fusion-platform && cd fusion-platform
# 使用 `git clone` 获取项目内容，根据项目目录调整 nginx.conf 等 URL 设置
git clone 

cd ~/project/php7
mkdir sports && cd sports
# 使用 `git clone` 获取项目内容，根据项目目录调整 nginx.conf 等 URL 设置
git clone 
```

### 6. 进入 Docker 容器

这一步允许你进入Docker容器以执行各种操作，例如运行命令、调试或查看日志。你提供了两种方式来进入容器：
> 因为 Docker 已经自动建立了本机目录与容器内的 `/baifu` 目录的连接，所以你可以在本机的项目目录中进行编辑和操作，*而无需专门进入容器*。
#### 使用 `exec.sh` 脚本

使用 `exec.sh` 脚本：这个脚本会自动进入PHP容器，并让你在容器中执行命令。你需要在脚本中指定要执行的命令。这是进入PHP容器的一种快捷方式。

```bash
# PHP 7.4
cd ~/docker-php-env/php7
# 使用 exec.sh 脚本来进入 Docker PHP 7.4 容器
sh exec.sh

# PHP 8
cd ~/docker-php-env/php8
# 使用 exec.sh 脚本来进入 Docker PHP 8 容器
sh exec.sh
```

#### 使用 Docker Compose 命令：
你可以使用 `docker-compose exec` 命令进入 Nginx 容器或 PHP 容器。在这个命令中，你需要指定要进入的容器名称，例如 webserver 或 php-fpm。然后，你可以在容器中执行所需的命令。

```bash
# PHP 7.4
cd ~/docker-php-env/php7
# 或者使用 Docker Compose 命令进入 Nginx 容器
docker-compose exec webserver /bin/sh -c "cd /baifu && /bin/sh"
# 或者使用 Docker Compose 命令进入 PHP 容器
docker-compose exec php-fpm /bin/sh -c "cd /baifu && /bin/sh"
# 本機目錄 ~/project/php8/ 對應容器目錄
cd /baifu

# PHP 8
cd ~/docker-php-env/php8
# 或者使用 Docker Compose 命令进入 Nginx 容器
docker-compose exec webserver /bin/sh -c "cd /baifu && /bin/sh"
# 或者使用 Docker Compose 命令进入 PHP 容器
docker-compose exec php-fpm /bin/sh -c "cd /baifu && /bin/sh"
# 本機目錄 ~/project/php8/ 對應容器目錄
cd /baifu
```


### 7. 調整本機的hosts
在这一部分，提醒你需要调整 `etc/hosts` 文件，加入项目的网址。以下是当前项目的域名列表：
```bash
sh add_domains_to_hosts.sh
```
或是自行調整
```bash
vim /etc/hosts:

...
...
127.0.0.1       fusion-local.spgamesmanager.net
127.0.0.1       local.spmobileapi.net
127.0.0.1       phpMyAdmin
```

### 打开页面

PHP7.4 :
- [Fusion 後台/api : http://fusion-local.spgamesmanager.net/](http://fusion-local.spgamesmanager.net/)
- [Thor 頁面前台/api : http://local.spmobileapi.net/](http://local.spmobileapi.net/)
- [Phpmyadmin (MySQL) : http://phpmyadmin/](http://phpmyadmin/)

## Php 8
这一部分提醒你，针对PHP 8 进行的操作与 PHP 7.4 是相似的，只是需要进入相应的项目目录并使用相应的脚本和命令。

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
                "/baifu": "/Users/user/project/php7"
            }
        }
    ]
}
```
确保将 pathMappings 中的路径映射到你的项目实际路径。

参考链接 [在VSCODE中設置XDEBUG](https://medium.com/@winnietsou/%E5%9C%A8vscode%E4%B8%AD%E4%BD%BF%E7%94%A8php-xdebug-docker-ad75e1c69d88)。
