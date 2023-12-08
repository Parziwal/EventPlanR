# EventPlanR

## Introduction

For my thesis **Event planner solution on AWS serverless architecture**, I developed this event planner application. The goal of this event planner application to help users plan and organize events such as meetups, conferences, or parties. The application makes the event planning tasks easier and more convenient, and ensures that every user finds the right event for them.

## Technologies

- The application was implemented on *AWS* cloud plafrom using serverless services.
- The backend side of the application was built on *.NET* platform with *AWS Lambda* services.
- The frontend side was prepared for Web and Android using *Flutter* platform.
- The application infrastructure was deployed using the *Terraform* Infrastructure as Code tool.
- The backend and frontend infrastructure creation, and the client application deployment was automated using *CI/CD* pipelines

## Running the application

*Warning the application uses paid AWS services!*

It is not possible to run the server side of the application locally. The server side has to be deployed to the AWS environment together with the individual services.

### Requirements

The following tools and technologies are required to run the application:
- AWS account ([Getting started](https://docs.aws.amazon.com/accounts/latest/reference/welcome-first-time-user.html))
- AWS CLI ([Authenticate with IAM user credentials](https://docs.aws.amazon.com/cli/latest/userguide/cli-authentication-user.html))
- Terraform ([Download](https://developer.hashicorp.com/terraform/install))
- .NET 6 ([Download](https://dotnet.microsoft.com/en-us/download/dotnet/6.0))
- Flutter ([Download](https://docs.flutter.dev/get-started/install))
- Android Studio ([Download](https://developer.android.com/studio))

### Deploy backend

1. Run the *publish_lambda_service.sh* shell script in the *infrastructure/backend* folder, which publishes the server side Lambda projects.
2. Delete the following block from the *config.tf* file in the *infrastructure/backend/main* folder, or create an S3 bucket inside the AWS account and link to it, which will store the Terraform state files.
    ```tf
    backend "s3" {
        bucket = "event-planr-terraform-state"
        key    = "event-planr-project"
        region = "us-east-1"
    }
    ```
3. Run the *terraform init* command in the *infrastructure/backend/main* folder to initialize the working directory.
4. In the *infrastructure/backend/main* folder, run the *terraform workspace new development* and *terraform workspace select development* commands, which create and configure the development environment.
5. In *infrastructure/backend/main* folder, run the *terraform apply* command and accept the plan.
6. After the the deployment complete (15-20 minutes), save the output variables, because they will be needed to run the client applications.

### Run frontend apps

1. Open the project using *Android Studio*.
2. Run the *flutter pub get* command, which will download the dependencies.
3. Run the *dart run build_runner build* command, which will create the generated files.
4. Create an *.env.dev* file in the root project based on the *.env.template* file, and fill in the empty variables based on the output variables from the previous section.
5. In the top bar of Android Studio, select the *development* environment, and then select the device, which can be either *Web browser* or *Android device*
6. Run the application.