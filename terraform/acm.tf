# ACM (Amazon Certificate Manager) からの証明書の要求と管理を可能にする
# 最も一般的には、このリソースは aws_route53_record および aws_acm_certificate_validation とともに使用して、
# DNS で検証済みの証明書を要求し、必要な検証レコードを配置して検証の完了を待ちます。
resource "aws_acm_certificate" "acm_cert" {
  provider = aws
  # 証明書を発行するドメイン名
  domain_name = "${var.root_domain}"
  # 発行された証明書において、SANとなるべきドメインの設定
  # SANとは？
  subject_alternative_names = ["*.${var.root_domain}"]
  # どの方法で検証するか
  validation_method = "DNS"
}

resource "aws_route53_record" "acm_cert" {
  for_each = {
    for dvo in aws_acm_certificate.acm_cert.domain_validation_options : dvo.domain_name => {
      name = dvo.resource_record_name
      record = dvo.resource_record_value
      type = dvo.resource_record_type
    }
  }
  
  allow_overwrite = true
  name = each.value.name
  type = each.value.type
  zone_id = "${aws_route53_zone.site_zone.zone_id}"
  records = [each.value.record]
  ttl = 60
}

resource "aws_acm_certificate_validation" "acm_cert" {
  # 検証対象の証明書のARN
  certificate_arn = "${aws_acm_certificate.acm_cert.arn}"
  # 検証を実施するFQDNのリスト
  validation_record_fqdns = [for record in aws_route53_record.acm_cert : record.fqdn]
}