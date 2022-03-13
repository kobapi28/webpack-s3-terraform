# cloudFrontの配信元の識別子
# ローカルの変数を定義
locals {
  s3_origin_id = "s3-origin-${var.site_domain}"
}

# PrivateなS3 Bucketにアクセスするためにオリジンアクセスアイデンティティ(OAI)を利用
# OAI: 特別なCloudFrontユーザーのこと
resource "aws_cloudfront_origin_access_identity" "site" {
  comment = "${var.site_domain}"
}

# CloudFrontのディストリビュージョン作成
resource "aws_cloudfront_distribution" "site" {
  aliases = ["${var.site_domain}"]
  origin {
    # s3バケットまたはカスタムオリジンのWebサイトのDNSドメイン名
    domain_name = "${aws_s3_bucket.site.bucket_regional_domain_name}"
    # originの一意な識別子
    origin_id = "${local.s3_origin_id}"

    # s3オリジンの設定情報
    s3_origin_config {
      # CloudFrontのオリジンアクセスIDで、オリジンと関連づける
      origin_access_identity = "${aws_cloudfront_origin_access_identity.site.cloudfront_access_identity_path}"
    }
  }

  # ディストリビュージョンがエンドユーザからのコンテンツのリクエストを受け付けることが可能かどうか
  enabled = true
  # ディストリビュージョンについてのコメント
  comment = "${var.site_domain}"
  default_root_object = "index.html"

  # このディストリビュージョンにおけるデフォルトのキャッシュ動作
  default_cache_behavior {
    # どのHTTPメソッドを処理し、S3またはカスタムオリジンに転送するかを制御する
    allowed_methods = ["GET", "HEAD"]
    # 使用したリクエストに対するレスポンスをキャッシュするかを制御
    cached_methods = ["GET", "HEAD"]
    # リクエストがキャッシュ動作またはデフォルトのキャッシュ動作のパスパターンに一致した時に、
    # リクエストをルーティングさせたいオリジンのID
    target_origin_id = "${local.s3_origin_id}"

    forwarded_values {
      # キャッシュ動作に関連するオリジンにクエリ文字列を転送するかを示す
      query_string = false
      # クッキーをどのように扱うか
      cookies {
        # cookieを転送するかどうか
        forward = "none"
      }
    }

    # ユーザーがアクセスするために使用できるプロトコルの指定。
    viewer_protocol_policy = "redirect-to-https"
    min_ttl = 0
    # Cache-Control max-ageまたはExpiresヘッダーがない場合 オブジェクトがCloudFrontキャッシュにあるデフォルトの時間
    default_ttl = 3600
    max_ttl = 86400
  }

  # このディストリビュージョンの制限設定
  restrictions {
    geo_restriction {
      # 国別にコンテンツの配信を制限するために使用する方法
      restriction_type = "none"
    }
  }

  # PriceClass_All or PriceClass_200 pr PriceClass_100
  price_class = "PriceClass_200"

  # とりあえずCloudFrontドメインの証明書を利用
  # Route53&ACM設定が終わった後で、自ドメインの証明書に変更する
  # このディストリビュージョンのSSL設定
  viewer_certificate {
    # オブジェクトのリクエストにHTTPSを使用し、配信にCloudFrontのドメイン名を使う場合にtrue
    # cloudfront_default_certificate = true
    acm_certificate_arn = "${aws_acm_certificate_validation.acm_cert.certificate_arn}"
    ssl_support_method = "sni-only"
    minimum_protocol_version = "TLSv1"
  }
}