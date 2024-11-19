import os
import subprocess
from cryptography.hazmat.primitives.asymmetric import rsa
from cryptography.hazmat.primitives import serialization
from cryptography import x509
from cryptography.x509.oid import NameOID
from datetime import datetime, timedelta

CERT_DIR = "../certs"
SECRET_NAME = "ssl-certificate"
NAMESPACE = "default"

def generate_ssl_cert(cert_dir, domain_name):
    os.makedirs(cert_dir, exist_ok=True)

    # Generate private key
    key = rsa.generate_private_key(public_exponent=65537, key_size=2048)
    key_path = os.path.join(cert_dir, "tls.key")
    with open(key_path, "wb") as f:
        f.write(key.private_bytes(
            serialization.Encoding.PEM,
            serialization.PrivateFormat.TraditionalOpenSSL,
            serialization.NoEncryption()
        ))

    # Generate self-signed certificate
    subject = issuer = x509.Name([ 
        x509.NameAttribute(NameOID.COUNTRY_NAME, "US"),
        x509.NameAttribute(NameOID.STATE_OR_PROVINCE_NAME, "California"),
        x509.NameAttribute(NameOID.LOCALITY_NAME, "San Francisco"),
        x509.NameAttribute(NameOID.ORGANIZATION_NAME, "Juice Shop"),
        x509.NameAttribute(NameOID.COMMON_NAME, domain_name),
    ])
    cert = (
        x509.CertificateBuilder()
        .subject_name(subject)
        .issuer_name(issuer)
        .public_key(key.public_key())
        .serial_number(x509.random_serial_number())
        .not_valid_before(datetime.utcnow())
        .not_valid_after(datetime.utcnow() + timedelta(days=365))
        .sign(key, x509.hashes.SHA256())
    )
    cert_path = os.path.join(cert_dir, "tls.crt")
    with open(cert_path, "wb") as f:
        f.write(cert.public_bytes(serialization.Encoding.PEM))

    return key_path, cert_path

def apply_kubernetes_secret(cert_dir, namespace, secret_name):
    key_path = os.path.join(cert_dir, "tls.key")
    crt_path = os.path.join(cert_dir, "tls.crt")
    cmd = f"""
    kubectl create secret tls {secret_name} \
        --cert={crt_path} --key={key_path} \
        --namespace={namespace} --dry-run=client -o yaml | kubectl apply -f -
    """
    subprocess.run(cmd, shell=True, check=True)

if __name__ == "__main__":
    DOMAIN_NAME = "juice-shop.local"
    CERT_DIR = os.path.abspath(CERT_DIR)
    generate_ssl_cert(CERT_DIR, DOMAIN_NAME)
    apply_kubernetes_secret(CERT_DIR, NAMESPACE, SECRET_NAME)
