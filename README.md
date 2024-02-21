# Snowplow Site Reliability Engineer Test

Congratulations on making it to this stage in the journey! The 
following skills test is designed to facilitate a technical conversation
that we will schedule when you are complete. A perfect solution is not 
the goal here, this is really about understanding how you think through 
technical problems, address requirements, and how your personal style 
will complement our team. If you have any questions along the way, 
please do not hesitate to reach out!

## The main project: Consul Cluster on AWS

### Scenario

You have been tasked with setting up a redundant, distributed, and 
scalable Consul cluster on AWS. This cluster will be used in a 
production environment to provide distributed access to a key-value 
store for the ACME operations team. 

Your code submission will take the form of a Pull Request into this 
repo. The repository transfer should have added the Snowplower who 
invited you as a collaborator in the repo, but if you do not see 
anyone, please reach out and we will provide you with a username to 
invite. You are welcome to make a single PR to encompass the whole 
project. Feel free to squash your commits, but you are also welcome to 
showcase your journey and git etiquette! 

### Requirements
All infrastructure code should be submitted in the [./01-consul/](./01-consul/) 
directory. Please note, you are more than welcome to use existing 
open-source modules within this project rather than creating everything 
from scratch. Obviously, you are also welcome to show off a bit from if 
you have the time to spare, but starting with an existing recipe will 
not negatively impact your evaluation.

- [ ] The cluster must consist of 3 or more servers
- [ ] The servers must be distributed across 2 or more AWS availability 
      zones
- [ ] The cluster nodes must survive reboots (Consul must automatically 
      restart on server reboot and rejoin the cluster)
- [ ] The permanent loss of any server in the cluster must not result 
      in a cluster failure or data loss
- [ ] The cluster must employ auto-discovery in that new servers being 
      added are automatically clustered
- [ ] The latest version of Consul (1.15.x) should be used

### Non-functional Requirements

- All deployment must be done with code - there should be no manual 
  interaction with the deployment of the cluster
- Deployment Automation must be implemented around this code - there 
  should be no manual interaction to deploy the stack.
- Consider the scenarios that could result in downtime and ensure that 
  they are accounted for:
    + Availability Zone going down
    + Server malfunction

As the infrastructure must be deployed from code you should utilize one 
of the popular provisioning tools available such as:
- Terraform
- CloudFormation

When implementing the CI/CD function you should utilize Github actions. 
This repository already has a .github directory for your convenience.

If you opt to automate this using another tool, please let us know which
 one you used ahead of the interview.

---

## Consul Clients
In this small follow-up section, you will implement a version of a 
classic iterative problem in two scripting languages: bash and python. 
We have included the empty files [./02-consul_client/consul_client.sh](./02-consul_client/consul_client.sh) 
and [./02-consul_client/consul_client.py](./02-consul_client/consul_client.py) for your convenience.

You will want to prep both of these scripts to submit data to the deployed 
Consul KV store, but will be writing the complete algorithm as a live coding 
exercise. 

---

## Debugging

The [./03-debugging/](./03-debugging/) directory contains terraform that attempts to
deploy a simple nginx cluster that responds "hello world" on port 80. 
But there are a few things wrong with it! Attempt to find out what is 
wrong and resolve each issue. 

---

## What to bring along

You are expected to have started to prepare the templates / deployment
code ahead of time so that we can jump straight into the deployment and
so we can immediately start analyzing and testing the environment that
is going to be spun up for the above requirements.

**Note:** You should smoke-test the deployment in your own AWS 
sub-account - the AWS free tier should more than cover your development
needs. If you cannot access the AWS free tier please reach out and we 
will endeavor to find an alternative solution.
