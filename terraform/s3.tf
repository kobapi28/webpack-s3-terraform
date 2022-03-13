# リソースブロック
# ブロック前に リソースタイプ と リソース名
# リソースタイプとリソース名を合わせて、リソースの一意なIDが形成される

# terraform fmt -> フォーマット
# terraform validate -> エラーがないかチェック

resource "aws_s3_bucket" "site" {
  # バケットの名前
  bucket = "${var.bucket_name}"
  acl = "private"
}
