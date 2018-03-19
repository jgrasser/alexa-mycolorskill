# alexa-mycolorskill

Bootstrap the mycolorskill lambda function for the Alexa Skill Tutorial https://developer.amazon.com/alexa-skills-kit/alexa-skill-quick-start-tutorial. 

## Getting Started

Because the lambda portion of the tutorial is encoded within the provided terraform code, getting started is as easy as cloning the repository and running terraform. Upon completion of the terraform run, the arn for the lambda function will be output. 

```
$ git clone git@github.com:jgrasser/alexa-mycolorskill.git
$ cd alexa-mycolorskill
$ terraform apply
...
...
...

$ terraform output lambda_function_arn
arn:aws:lambda:us-east-1:99999999999:function:myColorSkill
```
