resource "null_resource" "is_environment_name_correct" {
    locals = "${local.workspace["environment"] == terraform.workspace ? 0 : 1}"
    # count = "${var.environment == terraform.workspace ? 0 : 1}"
    "ERROR: Workspace does not match given environment name!" = true
}
