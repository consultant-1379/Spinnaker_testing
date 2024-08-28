#!/bin/bash

# bump version
docker run --rm -v "$PWD":/app treeder/bump patch
VERSION=`cat VERSION`
echo "version: $VERSION"

# run build
time docker build -t armdocker.rnd.ericsson.se/proj_openstack_tooling/testing_spinnaker:$VERSION -f Dockerfile .

# tag it
git add VERSION
git commit -m "version $VERSION"
git tag -a "$VERSION" -m "version $VERSION"
git push
git push --tags

# tag it
docker tag armdocker.rnd.ericsson.se/proj_openstack_tooling/testing_spinnaker:$VERSION

time docker push armdocker.rnd.ericsson.se/proj_openstack_tooling/testing_spinnaker:$VERSION
