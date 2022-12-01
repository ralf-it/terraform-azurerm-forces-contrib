data "http" "myip_raw_http_icanhazip" {
  url = "http://ipv4.icanhazip.com"
}
data "http" "myip_raw_https_icanhazip" {
  url = "https://ipv4.icanhazip.com"
}
data "http" "myip_raw_http_ipinfo" {
  url = "http://ipinfo.io/ip"
}
data "http" "myip_raw_https_ipinfo" {
  url = "https://ipinfo.io/ip"
}

locals {
  myip = coalesce(
    chomp(data.http.myip_raw_https_icanhazip.response_body),
    chomp(data.http.myip_raw_https_ipinfo.response_body),
    chomp(data.http.myip_raw_http_icanhazip.response_body),
    chomp(data.http.myip_raw_http_ipinfo.response_body),
  )
  myip_cidr = "${local.myip}/32"

  allowed_ips = try(
    distinct(concat(
      var.allowed_ips,
      [local.myip]
    )),
    merge(
      var.allowed_ips,
      { (var.email_receiver_name) = local.myip }
    )
  )

  allowed_ip_cidrs = try(
    distinct(concat(
      var.allowed_ip_cidrs,
      [local.myip_cidr]
    )),
    merge(
      var.allowed_ip_cidrs,
      { (var.email_receiver_name) = local.myip_cidr }
    )
  )
}
