#!/bin/bash

while getopts hj:r:f:p: opt
do
  case ${opt} in
  h)  usage;;
  j)  job=$OPTARG;;
  r)  revision=$OPTARG;;
  f)  build_flavor=$OPTARG;;
  p)  priority=$OPTARG;;
  \?) usage;;
  esac
done

# set variable
revision=${revision:-main}
priority=${priority:-0}

echo ${CIRCLE_TOKEN}
echo ${job}
echo ${revision}
echo ${priority}
echo ${build_flavor}

curl -X POST \
     -H "Content-Type: application/json" \
     -H "Circle-Token: $CIRCLE_TOKEN" \
     -d '{
          "build_parameters": {
          "CIRCLE_JOB": "say-hello"
        }
      }' \
     https://circleci.com/api/v1.1/project/github/tdrk18/newOne/tree/$revision | grep build_url
