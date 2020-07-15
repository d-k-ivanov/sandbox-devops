[CmdletBinding()]
Param (
    [string]$Token,
    [switch]$Register,
    [switch]$UnRegister,
    [switch]$Bash,
    [switch]$Docker,
    [switch]$DockerDotNet
    )

if ($Register) {
    docker exec -it dev_gitlab_runner gitlab-runner register
}

if ($Bash -and $Token) {
    docker exec -it dev_gitlab_runner gitlab-runner register    `
        --non-interactive                                       `
        --executor "shell"                                      `
        --url "http://gitlab.pupupan.com/"                      `
        --registration-token "$Token"                           `
        --description "devops-bash-01"                          `
        --tag-list "shell,bash"                                 `
        --run-untagged="false"                                  `
        --locked="false"                                        `
        --access-level="not_protected"

}

if ($Bash -and $UnRegister) {
    docker exec -it dev_gitlab_runner gitlab-runner unregister  `
        --name "devops-bash-01"
}
