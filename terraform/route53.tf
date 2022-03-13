# Route53 Hosted Zone の管理
resource "aws_route53_zone" "site_zone" {
  name = "${var.root_domain}"

  tags ={
    Name = "${var.root_domain}"
  }
}

resource "aws_route53_record" "site" {
  # ホストゾーンのID
  zone_id = "${aws_route53_zone.site_zone.zone_id}"
  # 追加するレコード名
  name = "${var.site_domain}"
  # Aレコードとして追加
  type = "A"

  alias {
    # 他のリソースレコードのDNSドメイン名
    name = "${aws_cloudfront_distribution.site.domain_name}"
    # CloudFrontディストリビュージョンのID
    zone_id = "${aws_cloudfront_distribution.site.hosted_zone_id}"
    # リソースレコードの健全性確認？
    evaluate_target_health = false
  }
}