FROM turbot/steampipe

# Setup prerequisites (as root)
USER root:0
RUN apt-get update -y &&\
    apt-get install -y git python3-dev

#Docker client only
RUN wget -O - https://get.docker.com/builds/Linux/x86_64/docker-latest.tgz | tar zx -C /usr/local/bin --strip-components=1 docker/docker

# Install the aws and steampipe plugins for Steampipe (as steampipe user).
USER steampipe:0
RUN  steampipe plugin install steampipe
RUN  steampipe plugin install aws
RUN  steampipe plugin install finance
RUN  steampipe plugin install github
RUN  steampipe plugin install imap
RUN  steampipe plugin install theapsgroup/keycloak
RUN  steampipe plugin install kubernetes
RUN  steampipe plugin install net
RUN  steampipe plugin install terraform
#RUN  steampipe plugin install weatherkit
RUN  steampipe plugin install jenkins
RUN  steampipe plugin install crtsh
RUN  steampipe plugin install exec
RUN  steampipe plugin install openapi


# A mod may be installed to a working directory
WORKDIR /workspace

RUN  git clone --depth 1 https://github.com/turbot/steampipe-mod-aws-compliance.git
RUN  git clone --depth 1 https://github.com/turbot/steampipe-mod-aws-thrifty.git
RUN  git clone --depth 1 https://github.com/turbot/steampipe-mod-aws-insights.git
RUN  git clone --depth 1 https://github.com/turbot/steampipe-mod-aws-perimeter.git

RUN  git clone --depth 1 https://github.com/turbot/steampipe-mod-kubernetes-insights.git
RUN  git clone --depth 1 https://github.com/turbot/steampipe-mod-kubernetes-compliance.git

ENTRYPOINT []
ENV DATABASE_PORT=9193
ENV DASHBOARD_PORT=9194
ENV DASHBOARD=""
CMD ["bash", "-c", "cd /workspace/${DASHBOARD} && steampipe service start --foreground ${DASHBOARD:+--dashboard-port ${DASHBOARD_PORT} --dashboard --dashboard-listen=network}"]

# List of variables https://steampipe.io/docs/reference/env-vars/overview
