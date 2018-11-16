import boto3

secret = boto3.client('secretsmanager')

# create secret
new_secret = secret.create_secret(
    Name = "jwt_hmac_token",
    Description = "This is the Token to generate and verify JWT tokens for the API",
    SecretString = "8a39b257-98d7-4448-822c-6fa131f57240"
)