---
title: トップページ
---

# はじめに
## 目的と概要
本ハンズオンは第一部の勉強会で紹介した内容の実践を通して，"**Dockerコンテナの基礎とローカルでのコンテナ操作・管理方法**" および "**AWS上でのインフラ構築自動化 (IaC)**" の概要を理解し，円滑に開発を始められるようにすることを目的としています．

## 対象範囲
Docker編
: ローカル端末上へのDocker for Windowsインストール  
&emsp;～ Docker Composeによる3層Webアプリ作成まで  

AWS編
: EC2インスタンスキーペア作成  
&emsp;～ AWS CloudFormation (CFN) でのDockerコンテナ自動起動まで

## 注意事項
- ハンズオン開始前に**必ず**事前準備 ([Docker編](docker/installation.html "【事前準備】Docker for Windowsのインストール"), [AWS編](cfn/keypair.html "【事前準備】キーペアの作成")) を完了させておいてください．  
AWSアカウント事前作成済みであれば30分もかからずに終わると思います．
- 社用端末での実施はお控えください．
- 特に断りがない限り，本サイトにおいてコンテナ，イメージ，コンテナネットワークという単語はそれぞれ
"Dockerコンテナ"，"Dockerイメージ"，"Dockerコンテナネットワーク (Dockerネットワーク)" のことを指します．

## 想定環境
- ローカル端末 (DockerをインストールしていればMac, Linuxも可)
  - OS：Windows 10 **64bit**版 各種エディション
  - OSバージョン：**1903** (OSビルド **18362.1171**) 以降
  - アカウント権限：任意&thinsp;[^1]
  - その他：WSL2 or Hyper-Vの有効化が必要
- AWS
  - UI：マネジメントコンソール
  - IAMのアクセス権限：admin (EC2, S3, CloudFormationのフルコントロール)&thinsp;[^2]
  - その他：VPC作成枠が1つ以上残っていること&thinsp;[^3]

<br>

[^1]: **初期設定にはローカル管理者権限を要します**

[^2]: EC2/CFN/S3のフルコンのみに権限を絞っている場合，今回の演習そのものは問題なく実施できますが，スタック作成途中でエラー表示が出ます&nbsp;(スタック作成画面にて，AWS&nbsp;SNSの閲覧権限が必要となるため)．

[^3]: 契約の拡張でもしていない限り，1アカウントにつき，VPCは5つまでしか作成できません．

---

## 実施項目とリンク
### パート1：Docker編
1. [【事前準備】Docker for Windowsのインストール](docker/installation.md)  
1. [公式nginxイメージで始めるコンテナ操作]()  
: 基本操作とコンテナライフサイクルの理解
1. [Dockerfileによる自作イメージのビルド]()  
: コンテナイメージ，コンテナの理解
1. [コンテナNWの基礎]()  
: コンテナNW (ブリッジNW) の理解
1. [Docker Composeによる3層Webアプリ作成]()  
: 単一ホスト上マルチコンテナ管理の理解
1. [Docker composeの設定ファイル；docker-compose.yaml]()  
: "docker-compose.yaml" (通称composeファイル) の理解  
<br>


### パート2：AWS編 (CloudFormation編)
1. [【事前準備】キーペアの作成](cfn/keypair.md)  
1. [AWSにおけるインフラ管理]()  
: AWS上インフラ管理とIaC，CFNの概要理解
1. [10行で始めるCFN入門 (VPC環境構築)]()  
: CFN基本操作 (スタック作成/更新/削除)，テンプレートファイル基礎の理解
1. [EC2インスタンスの作成とコンテナ起動]()  
: Outputsによるマネジメントコンソールでのスタック管理
1. [スタックの分割と参照]()  
: スタック分割 (クロススタック参照) の利点と方法の理解  
<br><br>

---

## ソースコード一覧
ソースコードは[こちら]({{ site.github.repository_url }})
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
<br>


### 注釈