resource "tls_private_key" "ca" {
  algorithm = "RSA"
}

resource "tls_self_signed_cert" "ca" {
  key_algorithm   = tls_private_key.ca.algorithm
  private_key_pem = tls_private_key.ca.private_key_pem
  validity_period_hours = 87600
  early_renewal_hours = 96
  is_ca_certificate  =true

  allowed_uses = [
    "cert_signing",
    "crl_signing",  
  ]

  subject {
      common_name  = "localgft.com"
      organization = "GFT Technologies SE"
      organizational_unit = "PSU Technology and Delivery"
      street_address = [ "Kölner Straße 10" ]
      province = "HE"
      country = "DE"
      locality = "Eschborn"
      postal_code = "65760"
  }
}

resource "local_file" "ca_key_private" {
  content = tls_private_key.ca.private_key_pem
  filename = "data/ca.key.private"
}

resource "local_file" "ca_key_public" {
  content = tls_private_key.ca.public_key_pem
  filename = "data/ca.key.public"
}

resource "local_file" "ca_cert" {
  content = tls_self_signed_cert.ca.cert_pem
  filename = "data/ca.cert"
}

resource "local_file" "ca_certkey" {
  content = "${tls_self_signed_cert.ca.cert_pem}${tls_private_key.ca.private_key_pem}"
  filename = "data/ca.certkey"
}
