## Introduction
A docker image for running Kurt Zoglmann's Morse-Code-Ninja render script. You can run it locally in an interactive session using the commands below. Note that you will need to provide AWS credentials as environment variables. 


## Container environment variables
Environment variables can be set when this container is started to allow the scripts to use some services to perform text-to-speech, store the results in S3 and publish to a SNS topic when the submitted job is complete.

* AWS_KEY_ID: AWS IAM access key ID 
* AWS_SECRET_ACCESS_KEY: AWS IAM secret access key 
* AWS_SESSION_TOKEN: optional, used by the AWS client if the IAM creds are temporary
* NINJA_BUCKET_NAME: the name of the S3 bucket used to store the results


## AWS Setup
The render script uses AWS Polly and does not need anything to be built inside AWS before you render audio. The core script handles everything for you.

To use the "cloud" features such as pushing results to S3 and publishing messages to SNS, you will need to create some resources on your account beforehand.

### S3 Setup
Scripts in this image will push your audio files to an S3 bucket specified in the NINJA_BUCKET_NAME above. You will need to create the bucket and allow the user account attached to the IAM key/secret pair above to use the bucket. The scripts generate a unique prefix inside the bucket for your results.

### SNS Setup
After the render job is done and the results have been pushed to S3, a message will be published to an SNS topic. Currently the ARN for that topic is hard-coded and needs to be changed to an ARN valid in your account.

### IAM Setup
To quickly set up your AWS for your own use, create a new user on your account. Disable console access and generate an access key/secret pair. You will also need to add some permissions policies to this user. The simplest but most permissible way to do this is to add the following policies to the new user: AmazonPollyFullAccess, AmazonS3FullAccess, AmazonSNSFullAccess.

It is not recommended to use your root account credentials for this application. Setting up a dedicated AWS user account as detailed above is a safer configuration. To further tighten security, you can limit permissions on specific resources on each service rather than Full Access.

*See also https://github.com/zoglmannk/Morse-Code-Ninja for more information on AWS setup.*


## Building
1. Clone the Morse-Code-Ninja and Morse-Code-Ninja-Site projects.
2. Copy the files from both directories to the same directory as the Dockerfile from this repository.
3. Run the docker build command
   1. `docker build -t <tag:revision> .`
   2. Wait 800.3 seconds...


## Running
1. `docker run -it --env AWS_KEY_ID=SECRET --env AWS_SECRET_ACCESS_KEY=SECRET --env NINJA_BUCKET_NAME=SECRET -p 3000:3000 sklegg/morsecodeninja` will pull the image down to your machine and start it in interactive mode. 

2. `node /opt/ninja/app/app.js`

3. Open http://localhost:3000/index.html in a browser.
