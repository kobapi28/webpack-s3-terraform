# リソースブロック
# ブロック前に リソースタイプ と リソース名
# リソースタイプとリソース名を合わせて、リソースの一意なIDが形成される

resource "aws_s3_bucket" "site" {
  # バケットの名前
  bucket = var.bucket_name
}


# CloudFrontからのオリジンアクセスアイデンティティ付きアクセスに対してReadのみを許可する
# 上で定義したバケットにポリシーの付与
resource "aws_s3_bucket_policy" "site" {
  bucket = aws_s3_bucket.site.id
  policy = data.aws_iam_policy_document.s3_site_policy.json
}

# https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document
# aws_iam_policy のようなポリシードキュメントを期待するリソースで使用するために、JSON 形式の IAM ポリシードキュメントを生成します。
# ポリシーは特定のリソース・リソースグループに対する明示的な許可/拒否特権を定義するJSONドキュメント
data "aws_iam_policy_document" "s3_site_policy" {
  statement {
    # このステートメントが許可または許可するアクションのリスト
    actions = ["s3:GetObject"]
    # このステートメントが適用されるリソースARNのリスト
    resources = ["${aws_s3_bucket.site.arn}/*"]
    # 誰に適用するか
    # principals = "*" で actionsに s3:GetObject だったらみんな見れるってことか
    # この場合、cloudfrontのみが見れるようになってる。
    # cloudfrontの中身があんままだ理解できてない。
    principals {
      type = "AWS"
      # プリンシパルの識別子のリスト
      # typeがAWSの場合、IAMプリンシパルのARNとなる
      identifiers = ["${aws_cloudfront_origin_access_identity.site.iam_arn}"]
    }
  }
}