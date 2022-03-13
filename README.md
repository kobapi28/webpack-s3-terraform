# webpack-s3-terraform
HTML + SCSS + JavaScript を使ったサイトをS3でホスティングする。
リソースの管理にはTerraformを用いて、GitHub Actionsを用いたCD環境も整備する。

## 構成
```bash
./
├── terraform # s3, cloudfrontなどのリソース管理 
├── .gitignore
├── README.md 
├── node_modules/
├── package.json
├── public/ # このディレクトリごとS3へアップロード
├── src/ 
├── webpack.config.js
└── yarn.lock
```

## terraform commands
```bash
terraform init

# 実行しようとしているものの確認
terraform plan 

# 実行
terraform apply

# フォーマット
terraform fmt

# 正しいかのチェック
terraform validate
```
