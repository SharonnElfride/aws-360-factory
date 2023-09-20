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
aws ec2 describe-vpcs | jq .
#{
#  "Vpcs": [
#    {
#      "CidrBlock": "172.31.0.0/16",
#      "DhcpOptionsId": "dopt-0a01114910d27220e",
#      "State": "available",
#      "VpcId": "vpc-0281720e47f44a02f",
#      "OwnerId": "020887103976",
#      "InstanceTenancy": "default",
#      "CidrBlockAssociationSet": [
#        {
#          "AssociationId": "vpc-cidr-assoc-05e8b80bd3d82447d",
#          "CidrBlock": "172.31.0.0/16",
#          "CidrBlockState": {
#            "State": "associated"
#          }
#        }
#      ],
#      "IsDefault": true
#    }
#  ]
#}

echo ""
echo ""

######################################################################
# Get the Subnet Id within the VPC
######################################################################

echo "Getting Subnet Id..."

### TODO
EC2_SUBNET_ZONE=""

echo "Got Subnet Id: ${EC2_SUBNET_ID}"

######################################################################
# Get the Security groups Id
######################################################################

echo "Getting Security Group Id..."

### TODO

echo "Got Security Group Id: ${EC2_SG_ID}"

######################################################################
### Provision EC2 Server
######################################################################

echo "Provisioning EC2 instance..."

### TODO

echo "Ec2 Instance ready, here are the details:"
echo ${EC2_PROVISION}
