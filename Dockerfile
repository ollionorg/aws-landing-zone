FROM amazon/aws-cli
RUN yum install unzip jq -y

ENV TERRAFORM_VERSION=1.4.2
RUN curl -o terraform_${TERRAFORM_VERSION}_linux_amd64.zip https://releases.hashicorp.com/terraform/${TERRAFORM_VERSION}/terraform_${TERRAFORM_VERSION}_linux_amd64.zip
RUN unzip -o terraform_${TERRAFORM_VERSION}_linux_amd64.zip && mv terraform /usr/bin
