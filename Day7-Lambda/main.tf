# Create S3 Bucket named "Defence20225"
resource "aws_s3_bucket" "lambda_bucket" {
  bucket ="2025sam2025"
  acl    = "private"
}

# Upload Lambda Code to S3 inside "2025sam2025"
resource "aws_s3_object" "test" {  # Changed from lambda_code to test
  bucket = aws_s3_bucket.lambda_bucket.id
  key    = "lambda_function.zip"  # Keeping it consistent
  source = "lambda_function.zip"  # Local path of ZIP file
  etag   = filemd5("lambda_function.zip")
}

# Create IAM Role for Lambda Execution (Assuming role already exists)
resource "aws_iam_role" "lambda_exec_role" {
  name = "lambda_execution_role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Action = "sts:AssumeRole"
      Effect = "Allow"
      Principal = {
        Service = "lambda.amazonaws.com"
      }
    }]
  })
}

# Attach AWS-Managed Policy for Basic Lambda Execution
resource "aws_iam_role_policy_attachment" "lambda_policy" {
  role       = aws_iam_role.lambda_exec_role.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AWSLambdaBasicExecutionRole"
}

# Create the Lambda Function using the code from S3
resource "aws_lambda_function" "my_lambda" {
  function_name    = "my_lambda_function"
  runtime          = "python3.13"
  role             = aws_iam_role.lambda_exec_role.arn
  handler          = "test.lambda_handler"  # Assuming file name is test.py

  s3_bucket = aws_s3_bucket.lambda_bucket.id
  s3_key    = aws_s3_object.test.key  # This now matches the S3 object key

  timeout     = 10
  memory_size = 128

  environment {
    variables = {
      ENV_VAR_KEY = "ENV_VAR_VALUE"
    }
  }

  tags = {
    Name = "MyLambdaFunction"
  }
}