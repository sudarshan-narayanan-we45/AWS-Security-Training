import boto3
from huepy import *
from sys import exit
import base64



client = boto3.client('kms')

# create a new key
try:
    new_key = client.create_key(
        Description = "New Key for Application Encryption use-cases",
        KeyUsage = "ENCRYPT_DECRYPT",
        Origin = "AWS_KMS"
    )
    print(good('Generated new Customer Master Key (CMK) with Key ID: {}'.format(new_key['KeyMetadata']['KeyId'])))
except Exception as e:
    print(bad(e))
    exit(1)


#create_data_key
try:
    data_key = client.generate_data_key(
        KeyId = new_key['KeyMetadata']['KeyId'],
        KeySpec = "AES_256",
    )
    print(good('Generated Data new Key with Key ID: {}'.format(data_key['KeyId'])))
except Exception as e:
    print(bad(e))
    exit(1)

#encrypt data
ciphertext = client.encrypt(
    KeyId = data_key['KeyId'],
    Plaintext = b'Hello World',
)
b_cipher = base64.b64encode(ciphertext['CiphertextBlob'])
print(good("This is the encrypted ciphertext: {}".format(b_cipher)))

#decrypt data
plaintext = client.decrypt(
    CiphertextBlob = b'{}'.format(base64.b64decode(b_cipher))
)
print(good("This is the plaintext: {}".format(plaintext['Plaintext'])))