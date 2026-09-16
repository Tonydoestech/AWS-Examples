//ww.exampro.com/ssa-c03

# Set up check
# aws --version
# install export AWS_CLI_AUTO_PROMPT=on-partial --> Type AWS and the CLI should populate.

# s3 walkthrough lab - performing basic s3 functions through AWS CLI

#create a s3 bucket using the mb --"mb" is used for everyday
aws s3 mb s3://my-example-bucket-xxxx --region us-west-1
aws s3 ls #check if the bucket has been made. 

#create s3 bucket using s3api -- "s3api" is used to customize cofniguration when creating s3 buckets. 
aws s3api create-bucket --bucket my-example-bucket-yyyy --create-bucket-configuration LocationContraint=us-west-1
#Upload a file to s3 

#How to view a buckets configuration?
aws s3api get #list of configurations will be listed using the AWS CLI --bucket 
#Example - How to see the location of a bucket? 
aws s3api get-bucket-location --bucket my-example-bucket-aaaa #return json LocationContraint.

#List s3 buckets using json & query
aws s3api list-buckets --query Buckets[].name #add --output for text, json, table.
#Output
#[
#  "my-example-bucket-ah2027",
#   "my-example-bucket-ah2028",
#   "mystudenthealthhub-uploads"
#]

#List a specific s3 bucket using query
aws s3api list-buckets --query "Buckets[?Name == 'my-example-bucket-ah2027'].name"

#Lets upload a file to my-example-bucket-ahxx - Create file 
touch hello.txt
#list all the files - use nano to write in the file 
ls -la
nano filename to add text 
# Crt + S = Save and Crt + X = Quit
# Make a folder 
mdir images
mv images_7c10ec71.png/ mv hello.txt

aws s3 sync images/ s3://my-example-buckets-2028

#Download files
aws s3api get-object --bucket my-example-bucket-ah2028 --key hello.txt hello2.txt
#Putfiles 
aws s3api put-object --bucket my-example-bucket-ah2028 --key hello2.txt --content-type plain/txt --body hello2.txt

#List files in a bucket
aws s3 ls s3://my-example-bucket-ah2028
aws s3api list-objects --bucket my-example-bucket-ah2028 #return json
aws s3api list-objects --bucket my-example-bucket-ah2028 --query Contents[].key #less information


