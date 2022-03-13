# webpack-s3-terraform
HTML + SCSS + JavaScript を使ったサイトを S3 + CloudFront でホスティングする。
リソースの管理にはTerraformを用いて、GitHub Actionsを用いたCD環境も整備する。

## 構成
```bash
./
├── terraform # s3, cloudfrontなどのリソース管理
├── .github/
├── .gitignore
├── README.md 
├── node_modules/
├── package.json
├── public/ # このディレクトリごとS3へアップロード
├── src/ 
├── webpack.config.js
└── yarn.lock
```

## 実行
```bash
yarn install
yarn serve
```

## CD
1. プロダクションビルドしたものを`public/`に配置。
2. それをS3にフォルダごとアップロードする。
3. CloudFrontのキャッシュを削除

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
