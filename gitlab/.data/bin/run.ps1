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