docker run --detach                                 `
  --hostname gitlab.pupupan.com                     `
  --publish 443:443 --publish 80:80 --publish 22:22 `
  --name gitlab                                     `
  --restart always                                  `
  --env EXTERNAL_URL="https://gitlab.pupupan.com"   `
  --volume C:/GitLab/config:/etc/gitlab             `
  --volume C:/GitLab/logs:/var/log/gitlab           `
  --volume C:/GitLab/data:/var/opt/gitlab           `
  gitlab/gitlab-ce:latest

docker run --detach                                     `
  --publish 8093:8093                                   `
  --name gitlab-runner-01                               `
  --restart always                                      `
  --volume C:/GitLab/runner01/config:/etc/gitlab-runner `
  --volume //var/run/docker.sock:/var/run/docker.sock   `
  gitlab/gitlab-runner:latest


# docker run --rm -it                                       `
#     --publish 8093:8093                                   `
#     --name gitlab-runner-01                               `
#     --volume C:/GitLab/runner01/config:/etc/gitlab-runner   `
#     --volume //var/run/docker.sock:/var/run/docker.sock   `
# gitlab/gitlab-runner:latest


# docker run --rm -it --name gitlab-runner-01 --entrypoint /bin/bash gitlab/gitlab-runner:latest
# docker run --rm -it --name gitlab-runner-01 --entrypoint /bin/bash gitlab/gitlab-runner:latest ls -la /bin
# docker run --rm -it --name gitlab-runner-01 --volume C:/GitLab/tmp:/tmp/transfer --entrypoint /bin/bash gitlab/gitlab-runner:latest

# docker exec -it gitlab-runner-01 gitlab-runner register


# docker run --rm -v /opt/runner/config:/etc/gitlab-runner gitlab/gitlab-runner register \
#   --non-interactive \
#   --executor "docker" \
#   --docker-image alpine:latest \
#   --url "http://gitlab_server/" \
#   --registration-token "token" \
#   --description "docker-runner" \
#   --tag-list "docker,aws" \
#   --run-untagged="true" \
#   --locked="false" \
#   --access-level="not_protected"

# docker stop gitlab
# docker rm gitlab
