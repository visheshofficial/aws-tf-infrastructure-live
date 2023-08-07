locals {
  workload_type  = basename(get_terragrunt_dir())
  vpc_cidr_block = "10.16.0.0/16"

  subnet_cidr_blocks = {
    az1 = {
      reserved      = "10.16.0.0/20",
      db            = "10.16.16.0/20",
      app           = "10.16.32.0/20",
      web           = "10.16.48.0/20",
      reserved_ipv6 = "00",
      db_ipv6       = "01",
      app_ipv6      = "02",
      web_ipv6      = "03",
      az_id         = "use1-az1"
    },
    az2 = {
      #sn-reserved-B 10.16.64.0/20 AZB IPv6 04
      #sn-db-B 10.16.80.0/20 AZB IPv6 05
      #sn-app-B 10.16.96.0/20 AZB IPv6 06
      #sn-web-B 10.16.112.0/20 AZB IPv6 07
    },
    az3 = {
      #sn-reserved-C 10.16. 128.0/20 AZC IPv6 08
      #sn-db-C 10. 16. 144.0/20 AZC IPv6 09
      #  sn-app-C 10.16.160.0/20 AZC IPV6 0A
      #sn-web-C 10.16.176.0/20 AZC IPv6 0B
    }
  }


}