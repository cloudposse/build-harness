import os
import json
import subprocess
from github import Github
import requests
from iteration_utilities import unique_everseen
from ruamel.yaml import YAML

GH_TOKEN = os.environ["GH_TOKEN"]
GH_ORG_NAME = os.getenv("GH_ORG_NAME", "cloudposse")
GH_SEARCH_PATTERN = os.getenv("GH_SEARCH_PATTERN", "terraform-")
TF_MODULE_PATH = os.getenv("TF_MODULE_PATH", ".")
TF_CONFIG_INSPECT_BINARY_PATH = os.getenv(
    "TF_CONFIG_INSPECT_BINARY_PATH",
    "terraform-config-inspect"
)
TF_REGISTRY_URL = "https://registry.terraform.io/v1"

gh = Github(GH_TOKEN)
yaml = YAML(typ="rt")
yaml.default_flow_style = False
yaml.preserve_quotes = False


def parse_gh():
    gh_repos = []
    for repo in gh.get_organization(GH_ORG_NAME).get_repos():
        if GH_SEARCH_PATTERN in repo.name:
            repo_object = {}
            repo_object["name"] = repo.name
            repo_object["description"] = repo.description
            repo_object["url"] = repo.html_url
            gh_repos.append(repo_object)
    return gh_repos


def tf_config_inspect():
    output = json.loads(
        subprocess.check_output(
            [TF_CONFIG_INSPECT_BINARY_PATH, TF_MODULE_PATH, "--json"],
            stderr=subprocess.STDOUT,
        )
    )
    return output


def parse_tf_registry(src_data, src_type):
    items = []
    src_item = "module_calls"
    if src_type == "providers":
        src_item = "required_providers"

    for k, v in src_data[src_item].items():
        item_object = {}
        url = TF_REGISTRY_URL + "/" + src_type + "/" + v["source"]
        r = requests.get(url=url).json()

        if src_type == "providers":
            name_pattern = "terraform-provider-{}".format(r["name"])
        else:
            name_pattern = "terraform-{}-{}".format(r["provider"], r["name"])
        item_object["name"] = name_pattern
        item_object["description"] = r["description"]
        item_object["url"] = r["source"]
        items.append(item_object)
    return items


if __name__ == "__main__":
    related_reference_list = []

    inspected_data = tf_config_inspect()
    modules_list = parse_tf_registry(inspected_data, "modules")
    providers_list = parse_tf_registry(inspected_data, "providers")
    gh_repos_list = parse_gh()

    # this can be done in one line but it requires itertools
    # and additional step to remove empty dicts
    for m in unique_everseen(modules_list):
        related_reference_list.append(m)
    for g in unique_everseen(gh_repos_list):
        related_reference_list.append(g)
    for p in unique_everseen(providers_list):
        related_reference_list.append(p)

    with open("{}/README.yaml".format(TF_MODULE_PATH)) as f:
        readme = yaml.load(f)

    readme["related"] = related_reference_list

    with open("{}/README.yaml".format(TF_MODULE_PATH), "w") as f:
        yaml.dump(readme, f)
