# DockerとAWSで始める個人開発<br>\~第2部： Docker & AWS (CloudFormation) ハンズオン\~

## 概要
ソースコード一式 (*1) を本ブランチで配布いたします．
ハンズオン当日までに次の2点を完了させてください．
1. ソースコードのDL (本ブランチ)
1. [こちらのGitHub Pages](https://distribution-for-workshops-c75c1a2e.github.io/202103_docker-and-aws/ "Docker & AWS (CloudFormation) ハンズオン")掲載の事前準備  

*1... ハンズオンで利用するソースコード及びハンズオンの補足として用意したソースコード  
なお，当日利用するディレクトリは以下の[構成](#構成)のコメント通りです．  
<br>

## 注意事項
各ディレクトリのもろもろの説明は`docker/`, `cfn/`それぞれ，`README.txt`にまとめています．適宜参照してください．  
また，`docker/`については当日利用するコマンド一覧を`commands.txt`にまとめているので，当日ご利用ください．  
<br>


## 構成
```console
$ tree -a --dirsfirst -L 2 src
src
├── cfn
│   ├── answer
│   ├── exercise      #<------- ハンズオンにて利用
│   └── README.txt    #<------- READMEです
├── docker
│   ├── alpine
│   ├── compose
│   ├── compose-slim  #<------- ハンズオンにて利用
│   ├── nginx
│   ├── nginx-alpine  #<------- ハンズオンにて利用
│   ├── nginx-ping
│   ├── commands.txt  #<------- コマンド一覧です
│   └── README.txt    #<------- READMEです
├── .gitignore
└── README.md

10 directories, 5 files
```
<br>

## ソースコード一覧
```console
$ tree -a --dirsfirst src
src
├── cfn
│   ├── answer
│   │   ├── 01_vpc_only.yaml
│   │   ├── 02_subnet_in_vpc.yaml
│   │   ├── 03_subnet_choose_az_failure.yaml
│   │   ├── 03_subnet_choose_az.yaml
│   │   ├── 04_attach_igw.yaml
│   │   ├── 05_attach_nacl.yaml
│   │   ├── 06_subnet_change_cidr.yaml
│   │   ├── 07_instance_only.yaml
│   │   ├── 08_instance_and_some_properties.yaml
│   │   ├── 09_sort_parameters.yaml
│   │   ├── 10_helper_script.yaml
│   │   ├── 11_split_10s_vpc.yaml
│   │   ├── 12_split_10s_sg.yaml
│   │   └── 13_split_10s_instance.yaml
│   ├── exercise  #<---------------- ハンズオンにて利用
│   │   ├── 01_vpc_only.yaml
│   │   ├── 02_subnet_in_vpc.yaml
│   │   ├── 03_subnet_choose_az.yaml
│   │   ├── 04_attach_igw.yaml
│   │   ├── 07_instance_only.yaml
│   │   ├── 10_helper_script.yaml
│   │   ├── 11_split_10s_vpc.yaml
│   │   ├── 12_split_10s_sg.yaml
│   │   └── 13_split_10s_instance.yaml
│   └── README.txt
├── docker
│   ├── alpine
│   │   └── Dockerfile
│   ├── compose
│   │   ├── _env
│   │   │   ├── ap
│   │   │   └── db
│   │   ├── ap
│   │   │   ├── setup
│   │   │   │   ├── entrypoint.sh
│   │   │   │   ├── generate_secret_key.py
│   │   │   │   └── requirements.txt
│   │   │   ├── share
│   │   │   │   └── .gitkeep
│   │   │   ├── Dockerfile
│   │   │   └── .dockerignore
│   │   ├── db
│   │   │   ├── setup
│   │   │   │   └── entrypoint.sh
│   │   │   └── Dockerfile
│   │   ├── web
│   │   │   ├── setup
│   │   │   │   ├── APserver.conf.template
│   │   │   │   ├── entrypoint.sh
│   │   │   │   └── nginx.conf.template
│   │   │   └── Dockerfile
│   │   ├── docker-compose.yml
│   │   └── .env
│   ├── compose-slim  #<---------------- ハンズオンにて利用
│   │   ├── _env
│   │   │   ├── ap
│   │   │   └── db
│   │   ├── ap
│   │   │   ├── setup
│   │   │   │   ├── entrypoint.sh
│   │   │   │   ├── generate_secret_key.py
│   │   │   │   └── requirements.txt
│   │   │   ├── share
│   │   │   │   └── .gitkeep
│   │   │   ├── Dockerfile
│   │   │   └── .dockerignore
│   │   ├── db
│   │   │   ├── setup
│   │   │   │   └── entrypoint.sh
│   │   │   └── Dockerfile
│   │   ├── web
│   │   │   ├── setup
│   │   │   │   ├── APserver.conf.template
│   │   │   │   ├── entrypoint.sh
│   │   │   │   └── nginx.conf.template
│   │   │   └── Dockerfile
│   │   ├── docker-compose.yml
│   │   └── .env
│   ├── nginx
│   │   ├── setup
│   │   │   ├── entrypoint.sh
│   │   │   └── index.html
│   │   └── Dockerfile
│   ├── nginx-alpine  #<---------------- ハンズオンにて利用
│   │   ├── setup
│   │   │   ├── entrypoint.sh
│   │   │   └── index.html
│   │   └── Dockerfile
│   ├── nginx-ping
│   │   └── Dockerfile
│   ├── commands.txt
│   └── README.txt
├── .gitignore
└── README.md

28 directories, 68 files
```