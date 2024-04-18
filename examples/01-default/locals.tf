locals {
  us_members = ["PadreGregor", "zparnold"]
  hu_members = [ "seggcsont", "zsenyeg"]
  all_members = concat(local.us_members, local.hu_members)
}