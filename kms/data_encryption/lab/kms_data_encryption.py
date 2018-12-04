from Crypto.Cipher import AES
import boto3
from huepy import *
import os
import base64
from sys import exit

pad = lambda s: s + (32 - len(s) % 32) * ' '
plaintext_message = "Hello from we45"
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
    # Data Key Gen has a Plaintext version and a Ciphertext Version.
    ciphertext_blob = data_key.get('CiphertextBlob')
    plaintext_key = data_key.get('Plaintext')
    print(good('Generated Data new Key with Key ID: {}'.format(data_key['KeyId'])))
except Exception as e:
    print(bad(e))
    exit(1)


# encrypt with PyCrypto
#generating an IV of 16 bytes
iv = os.urandom(16)

#Using the Plaintext version of the Data Key to encrypt some data
crypto_key = AES.new(plaintext_key, AES.MODE_CFB, iv)
try:
    final_ciphertext = "{}.{}".format(base64.b64encode(iv), base64.b64encode(crypto_key.encrypt(pad(plaintext_message))))
    # final ciphertext contains the base64 encoded version of the IV and the ciphertext separated by a '.'
    # the idea is to have the IV concatenated with the original message
    print(good("Generated ciphertext: {}".format(final_ciphertext)))
except Exception as e:
    print(bad(e))
    exit(1)

#decrypt with key pulled from KMS
try:
    # first decrypt the encrypted Data key with the CMK from Amazon KMS
    decrypted_key = client.decrypt(CiphertextBlob = ciphertext_blob).get('Plaintext')
    #extracting  the IV from the ciphertext
    iv = base64.b64decode(final_ciphertext.split('.')[0])
    #extracting the ciphertext
    ciphertext = final_ciphertext.split('.')[1]
    # Using the decrypted plaintext key to decrypt the data ciphertext
    decryption_key = AES.new(decrypted_key, AES.MODE_CFB, iv)
    reversed_plaintext = decryption_key.decrypt(ciphertext = base64.b64decode(ciphertext)).rstrip()
    print good("The reversed plaintext is: \"{}\"".format(reversed_plaintext))
except Exception as e:
    print(bad(e))
    exit(1)
