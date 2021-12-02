resource "tls_private_key" "app" {
  algorithm = "RSA"
}

resource "tls_cert_request" "app" {
  key_algorithm   = tls_private_key.app.algorithm
  private_key_pem = tls_private_key.app.private_key_pem

  dns_names = [ "mysite.localgft.com",
                "mysite-priority.localgft.com",
                "mysite-prime.localgft.com",
                "mysite-normal.localgft.com",
                "mysite-prod.localgft.com",
                "mysite-dev.localgft.com",
                "mysite-int.localgft.com",
                "mysite-uat.localgft.com",
                "mysite-pilot.localgft.com",
                "mysite-pre-prod.localgft.com",
                "mysite-test.localgft.com",
                "localgft.com",
                "priority.localgft.com",
                "prime.localgft.com",
                "normal.localgft.com",
                "prod.localgft.com",
                "pre-prod.localgft.com",
                "test.localgft.com",
                "dev.localgft.com",
                "int.localgft.com",
                "uat.localgft.com",
                "pilot.localgft.com",
                "host.docker.internal",
                "gateway.docker.internal",
                "kubernetes.docker.internal"
]

  subject {
      common_name  = "mysite-prod.localgft.com"
      organization = "GFT Technologies SE"
      organizational_unit = "PSU Technology and Delivery"
      street_address = [ "Kölner Straße 10" ]
      province = "HE"
      country = "DE"
      locality = "Eschborn"
      postal_code = "65760"
  }
}

resource "tls_locally_signed_cert" "app" {
  cert_request_pem   = tls_cert_request.app.cert_request_pem
  ca_key_algorithm   = tls_private_key.ca.algorithm
  ca_private_key_pem = tls_private_key.ca.private_key_pem
  ca_cert_pem        = tls_self_signed_cert.ca.cert_pem
  validity_period_hours = 8760
  early_renewal_hours = 96

  allowed_uses = [
    "key_encipherment", 
    "digital_signature",
    "server_auth", 
  ]
}

resource "local_file" "app_key_private" {
  content = tls_private_key.app.private_key_pem
  filename = "data/app.key.private"
}

resource "local_file" "app_key_public" {
  content = tls_private_key.app.public_key_pem
  filename = "data/app.key.public"
}

resource "local_file" "app_cert" {
  content = tls_locally_signed_cert.app.cert_pem
  filename = "data/app.cert"
}

resource "local_file" "app_certkey" {
  content = "${tls_locally_signed_cert.app.cert_pem}${tls_private_key.app.private_key_pem}"
  filename = "data/app.certkey"
}
resource "local_file" "app_certreq" {
  content = "${tls_cert_request.app.cert_request_pem}"
  filename = "data/app.certreq"
}
