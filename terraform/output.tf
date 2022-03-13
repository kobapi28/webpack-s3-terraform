# 作成されたCloudFront Destributionのドメインを出力
output "cloud_front_destribution_domain_name" {
  value = aws_cloudfront_distribution.site.domain_name
}

# 作成されたzoneのNameServersを出力
output "zone_name_servers" {
  value = aws_route53_zone.site_zone.name_servers
}