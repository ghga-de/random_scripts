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

find .devcontainer/Dockerfile -type f -exec \
    sed -i -e \
        's/ARG VARIANT=3.9//g' \
    {} \;

find .devcontainer/Dockerfile -type f -exec \
    sed -i -e \
        's/\# \[Choice\] Python version\: 3\, 3\.8, 3\.7, 3\.6//g' \
    {} \;

find .devcontainer/Dockerfile -type f -exec \
    sed -i -e \
        ':a;N;$!ba;s/\n\nFROM/FROM/g''' \
    {} \;

find .devcontainer/Dockerfile -type f -exec \
    sed -i -e \
        's/FROM mcr.microsoft.com\/vscode\/devcontainers\/python:0-${VARIANT}/FROM mcr.microsoft.com\/vscode\/devcontainers\/python:3.9-bullseye/g' \
    {} \;
