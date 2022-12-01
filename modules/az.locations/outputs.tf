output "output" {
  value       = local.locations
  description = <<-EOF
    Location for all resources. Each region object contains the following attributes:
    * `name` - The name of the region.
    * `display_name` - The display name of the region.
    * `paired_region_name` - The name of the region paired with this region. May be `null` if the region has no pair.
    * `geography` - The geography of the region.
    * `geography_group` - The geography group of the region.
    * `zones` - A list of the availability zones in the region. Will be empty if the region does not support zones."
    * `display_name_short` = `substr(v.display_name, 0, 2)}substr(split(" ", v.display_name)[1], 0, 2)`
    * `name_short` = `lower(substr(v.display_name, 0, 2)}substr(split(" ", v.display_name)[1], 0, 2))`
    * `recommended` - If true, the module will only return regions that are have the category set to `Recommended` by the locations API.
  EOF
}
output "output_all" {
  value       = local.locations_all
  description = "All locations available in Azure"
}
