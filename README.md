# Create a EC2 Instance with a New VPC on AWS using Terraform
## I made this Project so I would not have to keep writing code. Please enjoy. 
### If for whatever reason you find something wrong, incorrect, invaild, or no-longer applies to the current version. Please make a Issue or a PR Thank you.
#### P.S. I also did this, so I can learn on my off time. 10,000 Hours to Master a Skill, it all starts with the first hour.


![Diagram of This Project](master/files/diagram.png)

## This Terraform Project/Module is specific to AWS ~
## Be Advised this is for AWS


## Setup
Please preform these Actions on a `WSL Ubuntu` or `Linux` console
* `ssh-keygen -t rsa -f <Replace with your Key Name> -P ""`
* * This will Create a SSH Key that can be used to Access the EC2 Instance.
* `chmod 400 <Replace with your Key Name>*`
* * This will set the proper permissions so you can use them.
* Open PuttyGen at this time, at the Top Click Conversions -> Import Key
* Select the Key that you Just Generated, the one that does not end with .pub
* Click Save out Public/Private Key seperate which will generate your *.ppk file to load into Pagent
* Open Pagent
* Double click on the `<Replace with your Key Name>.ppk` file which will load it into Pagent
* * This allows Putty to automatically Access it for loggin in.

## Settings
Edit the Settings Located in `terraform.tfvars` if you need to have `production.tfvars` or `develop.tfvars` please use Command style (B)
* env = "demonstration"
* * This is what Envirnoment that it resides in. Production? Development? Staging? Dinosaur?
* project = "ec2_demo_example"
* * This is the name of the Project, keep it locase with no spaces and no special symbols besides `_` makes it easier to query in CLI/Terraform.
* instance_type = "t2.micro"
* * This is the side of the Instance, A.K.A. How much do you want to spend?
* region = "us-west-1"
* * Region your EC2 Resides in. I'm West Coast so like.. Yeah.
* key_file = "filename"
* * This is the filename of the Key.pub you generated in Setup. This can be `/location/to/file.pub`.


## How-to Run
* Command Style (A) with `terraform.tfvars`
* * `terraform init`
* * `terraform plan -out <Name for your Plan>`
* * `terraform apply "<Name for your Plan>"`
* Command Style (B) with a Custom `*.tfvars` File.
* * `terraform init`
* * `terraform plan -out <Name for your Plan> -var-file <Name of Config>.tfvars`
* * `terraform apply "<Name for your Plan>"`
* To Destroy it all type: ``

## How-to Login your new EC2 Instance~ (Windows)
* Open Putty
* Put your `server_public_ip` that is listed, make sure port is 22
* Go to Connection -> Data and fill-in the `Auto-login username` Field with `ubuntu`
* Go to Connection put `1` inside of the `Seconds between keepalives`
* Check the `Enable TCP keepalives` Box
* Go to Session
* Type in a name for this EC2 Session in the `Saved Sessions` Box
* Click Save
* Double Click on the Name you just typed. And Enjoy your Connection
* If it asks you to accept a SSL Cert, click yes.
* Your Welcome <3

## Lazy Settings
* `.env`
* * KEY_FILE
* * * Name of the Key file you will be generating ssh_keygen.
* * PLAN_NAME
* * * Name of the Plan you will be generating with Terraform.

## Make File
Made this due to being Lazy..... Sorry.... Or wait, your welcome I mean ;)
* `make init`
* `make plan`
* `make apply`
* `make destroy`
* `make genkey`
* `make graph`




Created by: Randolph `Bioblaze Payne` Aarseth