#!/bin/bash

# Copyright 2023 Universität Tübingen, DKFZ and EMBL
# for the German Human Genome-Phenome Archive (GHGA)
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

# pull files:
URL=https://raw.githubusercontent.com/ghga-de/microservice-repository-template
OLD=0e1c3da09bc3eaad673dceabe69b9a8756d54eaa
wget $URL/$OLD/.mandatory_files -O .mandatory_template_old
wget $URL/$OLD/.static_files -O .static_template_old
wget $URL/main/.static_files_ignore
wget $URL/main/.mandatory_files_ignore

# identify exceptions to the static and mandatory file lists:
comm -23 \
    <( sort .static_template_old | uniq --unique) \
    <( sort .static_files | uniq --unique) \
    | grep -v .mandatory_files \
    | grep -v .static_files \
    >> .static_files_ignore
comm -23 \
    <( sort .mandatory_template_old | uniq --unique) \
    <( sort .mandatory_files | uniq --unique) \
    | grep -v .mandatory_files \
    | grep -v .static_files \
    >> .mandatory_files_ignore

# cleanup:
rm .*_template_old

# ensure that static and mandatory files are in static list:
echo -e ".mandatory_files\n.static_files" >> .static_files

# run updates:
./scripts/update_static_files.py
./scripts/update_static_files.py
chmod +x ./scripts/update_template_files.py
./scripts/update_template_files.py

# update license headers:
find . -type f -exec \
    sed -i -e \
        's/Copyright 2021 Universität/Copyright 2021 - 2023 Universität/g' \
    {} \;
find . -type f -exec \
    sed -i -e \
        's/Copyright 2021 - 2022 Universität/Copyright 2021 - 2023 Universität/g' \
    {} \;

# update docker-in-docker feature:
perl -i -pe \
  'BEGIN{undef $/;} s|
		"docker-in-docker": \{[^}]*\}|
		"ghcr.io/devcontainers/features/docker-in-docker:2": {
			"version": "latest",
			"enableNonRootDocker": "true",
			"moby": true,
			"azureDnsAutoDetection": false
		}|ms' .devcontainer/devcontainer.json
perl -i -pe \
  'BEGIN{undef $/;} s|# make docker in docker work:.*VOLUME \[ "/var/lib/docker" \]\n||ms' \
  .devcontainer/Dockerfile
