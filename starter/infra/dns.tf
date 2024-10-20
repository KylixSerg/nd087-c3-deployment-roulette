#resource "aws_route53_record" "blue" {
#  zone_id = aws_route53_zone.private_dns.id
#  name    = "blue-green"
#  type    = "CNAME"
#  ttl     = "5"
#
#  weighted_routing_policy {
#    weight = 2
#  }
#
#  set_identifier = "blue"
#  records        = [kubernetes_service.blue.status.0.load_balancer.0.ingress.0.hostname] # https://github.com/hashicorp/terraform-provider-kubernetes/pull/1125
#}

resource "aws_route53_record" "green" {
  zone_id = aws_route53_zone.private_dns.id
  name    = "blue-green"
  type    = "CNAME"
  ttl     = "5"

  weighted_routing_policy {
    weight = 2
  }

  set_identifier = "green"
  records        = ["ad1f36148000b402294a3144a937c4e7-2b1d7c4b30e7de8c.elb.us-east-2.amazonaws.com"]  # should create the service using tf so this is not hard coded!!
}

resource "aws_route53_zone" "private_dns" {
  name    = "udacityproject"
  comment = "DNS for Udacity Projects"

  vpc {
    vpc_id = module.vpc.vpc_id
  }
}