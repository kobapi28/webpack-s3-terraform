variable "site_domain" {
  # 公開するサイトのドメイン
  default = "s3-terraform-webpack.shochan.me"
}

variable "root_domain" {
  # 公開するサイトのルートドメイン
  default = "shochan.me"
}

variable "bucket_name" {
  # 静的ファイルを保管しておくs3 bucket名
  default = "s3-terraform-webpack-site"
}