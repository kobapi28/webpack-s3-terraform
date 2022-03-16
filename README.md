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

## CI
以下のようにデプロイURLとエラー項目が表示されるように実装。
![image](https://user-images.githubusercontent.com/60056125/158501104-7e713d9a-4ed8-4e86-a486-f06cbe3a0496.png)


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
