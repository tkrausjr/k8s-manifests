load("@ytt:data", "data")

def generate_grafana_tls():
  for key in ["tls.crt", "tls.key"]:
    if getattr(data.values.monitoring.grafana.ingress.tlsCertificate, key):
      return False
    end
  end
  return True
end
