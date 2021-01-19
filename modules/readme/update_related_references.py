from github import Github
import os
import json
import requests
import subprocess
from iteration_utilities import unique_everseen
import itertools
from ruamel.yaml import YAML

GH_TOKEN = os.environ["GH_TOKEN"]
GH_ORG_NAME = os.getenv("GH_ORG_NAME", "cloudposse")
GH_SEARCH_PATTERN = os.getenv("GH_SEARCH_PATTERN", "terraform-aws-eks")
TF_MODULE_PATH = os.getenv("TF_MODULE_PATH", ".")
TF_CONFIG_INSPECT_BINARY_PATH = os.getenv(
    "TF_CONFIG_INSPECT_BINARY_PATH", "/usr/local/bin/terraform-config-inspect"
)
TF_REGISTRY_URL = "https://registry.terraform.io/v1"

gh = Github(GH_TOKEN)
yaml = YAML(typ="safe", pure=True)
yaml.default_flow_style = False
yaml.preserve_quotes = True


def get_list_of_repos(g):
    repos = []
    for repo in gh.get_organization(GH_ORG_NAME).get_repos():
        name = repo.name
        if GH_SEARCH_PATTERN in name:
            repos.append(name)
    return repos


def tf_config_inspect():
    list_of_modules = []
    list_of_providers = []
    list_of_related = []

    output = json.loads(
        subprocess.check_output(
            [TF_CONFIG_INSPECT_BINARY_PATH, TF_MODULE_PATH, "--json"],
            stderr=subprocess.STDOUT,
        )
    )

    for k, v in output["module_calls"].items():
        module_object = {}
        url = TF_REGISTRY_URL + "/modules/" + v["source"]
        module_info = requests.get(url=url).json()

        module_object["name"] = "terraform-{}-{}".format(
            module_info["provider"], module_info["name"]
        )
        module_object["description"] = module_info["description"]
        module_object["url"] = module_info["source"]
        list_of_modules.append(module_object)

    for k, v in output["required_providers"].items():
        provider_object = {}
        url = TF_REGISTRY_URL + "/providers/" + v["source"]
        provider_info = requests.get(url=url).json()

        provider_object["name"] = "terraform-provider-{}".format(
            provider_info["namespace"]
        )
        provider_object["description"] = provider_info["description"]
        provider_object["url"] = provider_info["source"]
        list_of_providers.append(provider_object)

    for m, p in itertools.zip_longest(
        unique_everseen(list_of_modules), list_of_providers
    ):
        list_of_related.append(m)
        list_of_related.append(p)

    return list_of_related


if __name__ == "__main__":

    with open("{}/README.yaml".format(TF_MODULE_PATH)) as f:
        readme = yaml.load(f)

    new_related_list = yaml.load(json.dumps(tf_config_inspect()))
    readme["related"] = new_related_list

    with open("{}/README.yaml".format(TF_MODULE_PATH), "w") as f:
        yaml.dump(readme, f)
