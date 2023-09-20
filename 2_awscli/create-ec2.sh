#!/usr/bin/env bash

set -e

######################################################################
# Variable definition
######################################################################

# Filter on the AMI name
# We want something like:
EC2_DISTRO="ubuntu/images/hvm-ssd/ubuntu-jammy-22.04-amd64-server-*"

######################################################################
# Get the AMI_ID
######################################################################

echo "Getting AMI Id..."

# TODO
# aws ec2 describe-images --filters Name=owner-alias,Values=amazon --filters 'Name=name,Values=ubuntu/images/hvm-ssd/ubuntu-jammy-22.04-amd64-server-*' --query 'reverse(sort_by(Images, &CreationDate))[0].ImageId' --output text
EC2_AMI_ID=$(aws ec2 describe-images \
  --filters Name=owner-alias,Values=amazon \
  --filters "Name=name,Values=${EC2_DISTRO}" \
  --query 'reverse(sort_by(Images, &CreationDate))[0].ImageId' \
  --output text)

echo "Got AMI Id: ${EC2_AMI_ID}"  # Returns ami-0fc5d935ebf8bc3bc

echo ""
echo ""

echo "AMI => "
aws ec2 describe-images \
  --filters Name=owner-alias,Values=amazon \
  --filters "Name=name,Values=${EC2_DISTRO}" \
  --query 'reverse(sort_by(Images, &CreationDate))[0]' | jq .

echo ""
echo ""

######################################################################
# Get the VPC Id
######################################################################

echo "Getting VPC Id..."

### TODO
EC2_VPC_ID=$(aws ec2 describe-vpcs \
  --filters Name=is-default,Values=true \
  --query 'Vpcs[0].VpcId' \
  --output text)
#  --query 'sort_by(Vpcs, &State)[0].VpcId' \

echo "Got VPC Id: ${EC2_VPC_ID}"  # Returns vpc-0281720e47f44a02f

echo ""
echo ""

echo "VPC => "
aws ec2 describe-vpcs --filters Name=is-default,Values=true | jq .

echo ""
echo ""

######################################################################
# Get the Subnet Id within the VPC
######################################################################

echo "Getting Subnet Id..."

### TODO
EC2_SUBNET_ZONE=""
EC2_SUBNET_ID=$(aws ec2 describe-subnets \
  --filters Name=vpc-id,Values=${EC2_VPC_ID} \
  --query 'Subnets[0].SubnetId' \
  --output text)

echo "Got Subnet Id: ${EC2_SUBNET_ID}"

echo ""
echo ""

echo "SUBNET => "
#aws ec2 describe-vpcs | jq .

echo ""
echo ""

######################################################################
# Get the Security groups Id
######################################################################

echo "Getting Security Group Id..."

### TODO
EC2_SG_NAME="ops"

echo "Getting Security Group Id..."
EC2_SG_ID=$(aws ec2 describe-security-groups \
                --filters "Name=vpc-id,Values=${EC2_VPC_ID}" \
                --group-names "${EC2_SG_NAME}" \
                --query "SecurityGroups[0].GroupId" \
                --output text)

echo "Got Security Group Id: ${EC2_SG_ID}"

######################################################################
### Provision EC2 Server
######################################################################

echo "Provisioning EC2 instance..."

### TODO
#EC2_PROVISION=$(aws ec2 run-instances \
#  --image-id ${EC2_AMI_ID} \
#  --instance-type t2.micro \
#  --key-name awscli \
#  --security-group-ids ${EC2_SG_ID} \
#  --subnet-id ${EC2_SUBNET_ID} \
#  --query 'Instances[0].InstanceId' \
#  --output text)

echo "Ec2 Instance ready, here are the details:"
echo ${EC2_PROVISION}
