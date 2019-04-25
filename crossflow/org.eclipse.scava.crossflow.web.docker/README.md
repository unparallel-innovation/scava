# Crossflow

Crossflow is a distributed data processing framework that supports dispensation of work across multiple opinionated and low-commitment workers.

## Quick Start Instructions:

Startup container:

`docker run -it --rm -d --name crossflow -p 80:8080 -p 61616:61616 -p 61614:61614 -p 8161:8161 -p 1099:1099 patrickneubauer/crossflow:latest`

Access web application:
http://localhost/org.eclipse.scava.crossflow.web/

Kill container:

`docker kill crossflow`

## Running the Crossflow web app in Docker from Source
- Follow [these instructions](https://github.com/crossminer/scava/blob/crossflow/crossflow/README.md) to check out and build the Crossflow source code
- Run `org.eclipse.scava.crossflow.web/build-war`
- This should create a zipped Tomcat application (`org.eclipse.scava.crossflow.web.war`) in `org.eclipse.scava.crossflow.web.docker`
- Run the following commands to build and run a Docker image 
	- `docker build -t crossflow .` 
	- `docker run -it --rm -d -p 80:8080 -p 61616:61616 -p 8161:8161 -p 1099:1099 crossflow:latest`
- You should now be able to access the web app though http://localhost/org.eclipse.scava.crossflow.web
	

## Additional / Optional:

### Clone Scava project source Code Repository:

`git clone https://github.com/crossminer/scava -b crossflow`

### Connect to container:
`docker exec -it crossflow /bin/bash`

### Links:

[Scava framework source code repository (GitHub)](https://github.com/crossminer/scava/tree/crossflow/crossflow)

[Crossflow Web Docker project (GitHub)](https://github.com/crossminer/scava/tree/crossflow/crossflow/org.eclipse.scava.crossflow.web.docker)

[Crossminer project website](https://www.crossminer.org)

[Crossflow on Docker Cloud / Hub](https://cloud.docker.com/repository/docker/patrickneubauer/crossflow)