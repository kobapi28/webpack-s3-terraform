# provider block: 指定されたプロバイダの設定
provider "aws" {
  # profile: AWSCLI設定時の認証情報を参照させるもの
  # cloudfrontのACM証明書を設置するリージョンがus-east-1に置くことが必須のため
  region = "us-east-1"
}