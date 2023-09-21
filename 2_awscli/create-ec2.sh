#!/usr/bin/env bash

##
## This script creates an EC2 instance in the default Vpc
## You can change the variables in the "Variable definition" part

set -e

######################################################################
# Variable definition
######################################################################

# Filter on the AMI name
# We want something like:
EC2_DISTRO="ubuntu/images/hvm-ssd/ubuntu-jammy-22.04-amd64-server-*"
EC2_AMI_OWNER_ALIAS="amazon"
EC2_SUBNET_AZ="us-east-1a"  # AZ => Availability Zone
EC2_SG_NAME="default"  # SG => Security Group
EC2_TYPE="t2.micro"
EC2_KEY_PAIR="vockey"

######################################################################
# Get the AMI_ID
######################################################################

echo "Getting AMI Id..."

EC2_AMI_ID=$(aws ec2 describe-images \
  --filters "Name=owner-alias,Values=${EC2_AMI_OWNER_ALIAS}" \
  --filters "Name=name,Values=${EC2_DISTRO}" \
  --query 'reverse(sort_by(Images, &CreationDate))[0].ImageId' \
  --output text)

echo "Got AMI Id: ${EC2_AMI_ID}"  # Returns ami-0fc5d935ebf8bc3bc

echo ""
echo ""

######################################################################
# Get the VPC Id
######################################################################

echo "Getting VPC Id..."

# In case we have multiple Vpcs & want a specific one, we can filter on its name or something specific to it.

EC2_VPC_ID=$(aws ec2 describe-vpcs \
  --filters Name=is-default,Values=true \
  --query 'Vpcs[0].VpcId' \
  --output text)

echo "Got VPC Id: ${EC2_VPC_ID}"  # Returns vpc-0281720e47f44a02f

echo ""
echo ""

######################################################################
# Get the Subnet Id within the VPC
######################################################################

echo "Getting Subnet Id..."

# availabilityZone
EC2_SUBNET_ID=$(aws ec2 describe-subnets \
  --filters "Name=vpc-id,Values=${EC2_VPC_ID}" \
  --filters "Name=availabilityZone,Values=${EC2_SUBNET_AZ}" \
  --query 'Subnets[0].SubnetId' \
  --output text)

echo "Got Subnet Id: ${EC2_SUBNET_ID}"  # Returns subnet-00916e93520778763

echo ""
echo ""

######################################################################
# Get the Security groups Id
######################################################################

echo "Getting Security Group Id..."

echo "Getting Security Group Id..."
EC2_SG_ID=$(aws ec2 describe-security-groups \
                --filters "Name=vpc-id,Values=${EC2_VPC_ID}" \
                --group-names "${EC2_SG_NAME}" \
                --query "SecurityGroups[0].GroupId" \
                --output text)

echo "Got Security Group Id: ${EC2_SG_ID}"

echo ""
echo ""

######################################################################
### Provision EC2 Server
######################################################################

echo "Provisioning EC2 instance..."

#EC2_PROVISION_ID=$(aws ec2 run-instances \
#  --image-id "${EC2_AMI_ID}" \
#  --instance-type "${EC2_TYPE}" \
#  --key-name "${EC2_KEY_PAIR}" \
#  --security-group-ids "${EC2_SG_ID}" \
#  --subnet-id "${EC2_SUBNET_ID}" \
#  --query 'Instances[0].InstanceId' \
#  --output text)

#echo "Ec2 Instance ready, here are the details:"
#echo "${EC2_PROVISION_ID}"  # Returns i-0d2bf4b92fcd5449d

#aws ec2 describe-instances --filters "Name=instance-id,Values=${EC2_PROVISION_ID}" | jq .

# All instances
# aws ec2 describe-instances | jq .
