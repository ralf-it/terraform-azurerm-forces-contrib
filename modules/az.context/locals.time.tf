## [time_offset](https://registry.terraform.io/providers/hashicorp/time/latest/docs/resources/offset)
resource "time_offset" "one_year_later" {
  offset_years = 1
  offset_days  = -1
}

locals {
  timestamp_compact   = replace(replace(timestamp(), ":", ""), "-", "")
  current_datetime    = timestamp()
  current_date        = formatdate("YYYY-MM-DD", local.current_datetime)
  one_year_later_date = formatdate("YYYY-MM-DD", time_offset.one_year_later.rfc3339)
}
