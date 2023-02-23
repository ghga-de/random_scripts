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

echo "Updating devcontainer.json VS Code customizations..."
perl -i -pe \
  'BEGIN{undef $/;} s|
	// Set \*default\* container specific settings.json values on container create.
	"settings": \{
		.*
	\},
	// Add the IDs of extensions you want installed when the container is created.
	"extensions": \[
		.*
	\],|
	"customizations": {
		"vscode": {
			// Set *default* container specific settings.json values on container create.
			"settings": {
				"terminal.integrated.profiles.linux": {
					"bash": {
						"path": "/bin/bash"
					}
				},
				"python.pythonPath": "/usr/local/bin/python",
				"python.languageServer": "Pylance",
				"python.linting.enabled": true,
				"python.linting.pylintEnabled": true,
				"python.formatting.autopep8Path": "/usr/local/py-utils/bin/autopep8",
				"python.formatting.blackPath": "/usr/local/py-utils/bin/black",
				"python.formatting.yapfPath": "/usr/local/py-utils/bin/yapf",
				"python.formatting.provider": "black",
				"python.analysis.typeCheckingMode": "basic",
				"python.linting.banditPath": "/usr/local/py-utils/bin/bandit",
				"python.linting.mypyPath": "/usr/local/py-utils/bin/mypy",
				"python.linting.pycodestylePath": "/usr/local/py-utils/bin/pycodestyle",
				"python.linting.pydocstylePath": "/usr/local/py-utils/bin/pydocstyle",
				"python.linting.pylintPath": "/usr/local/py-utils/bin/pylint",
				"python.testing.pytestPath": "/usr/local/py-utils/bin/pytest",
				"python.testing.unittestEnabled": false,
				"python.testing.pytestEnabled": true,
				"editor.formatOnSave": true,
				"editor.renderWhitespace": "all",
				"editor.rulers": [
					88
				],
				"licenser.license": "Custom",
				"licenser.customHeaderFile": "/workspace/.devcontainer/license_header.txt"
			},
			// Add the IDs of extensions you want installed when the container is created.
			"extensions": [
				"mikestead.dotenv",
				"ms-azuretools.vscode-docker",
				"ms-python.python",
				"ms-python.isort",
				"ms-python.vscode-pylance",
				"ms-toolsai.jupyter",
				"njpwerner.autodocstring",
				"redhat.vscode-yaml",
				"42crunch.vscode-openapi",
				"arjun.swagger-viewer",
				"eamodio.gitlens",
				"github.vscode-pull-request-github",
				"streetsidesoftware.code-spell-checker",
				"yzhang.markdown-all-in-one",
				"visualstudioexptteam.vscodeintellicode",
				"ymotongpoo.licenser",
				"editorconfig.editorconfig"
			]
		}
	},|ms' .devcontainer/devcontainer.json
