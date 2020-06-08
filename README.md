# Step Function POC

## Objective

Build, Test, and Deploy a working step function example into AWS. The project is expected to have three state transitions and utilize SQS for intake. 

## Dependencies

This project has an added task runner to it which should help building cross-platform. The task runner is called Task and you can [view the documentation here.](https://taskfile.dev/#/)

> NOTE: Could I just use the dotnet cli? Yes. However, I intend to add additional commands to tasks that would require some finagling to get done with dotnet cli.  

### Task Installation (Windows)

I manually installed Task because I use Chocolatey for package management and they support scoop installations. These are the steps I took to install Task into my path:

- Download the latest amd64 compiled binary from [the Task repository](https://github.com/go-task/task/releases)
- Click the `start` button on windows and type `path`.
- Click the result that says `Edit the system environment variables`.
- On the popup window click the `Environment Variables` button.
- Click on PATH and click the edit button. 
- Create a new directory called `.bin` under your user folder. EX: `C:\Users\me\.bin`.
- Paste the newly created directories path in a new entry under PATH.
- Extract the `task.exe` file from the downloaded release to your new `.bin` folder.
- Restart your editor or console and you should be able to use the `task` command.
 
## Local Development

### Prerequisite 
 
 - Install task executable

### Installation
 
 - Run `task install`
 - Start coding :) 
 
### Testing 
 
 - Run `task test`  
 - Look at those results!
 
