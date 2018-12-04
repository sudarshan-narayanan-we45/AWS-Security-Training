import boto3
import uuid

secret = boto3.client('secretsmanager')

# create secret
name  = "jwt_hmac_token_2"+uuid.uuid4().hex
new_secret = secret.create_secret(
    Name = name,
    Description = "This is the Token to generate and verify JWT tokens for the API",
    SecretString = "8a39b257-98d7-4448-822c-6fa131f57240"
)
