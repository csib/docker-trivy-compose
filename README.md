# docker-w-trivy-compose
This image contains the following:
- docker
- docker-compose
- trivy

You can use this image to build & security test your images.

GitLab example:
````
security:
stage: security
image: csib/docker-w-trivy-compose:latest
variables:
  IMAGE: registry.gitlab.com/csibvpn/csibjoomla:$CI_COMMIT_SHA
allow_failure: true
script:
    # Build image
    - docker build -t $IMAGE .
    # Build report
    - trivy --exit-code 0 --cache-dir .trivycache/ --no-progress --format template --template "@/contrib/gitlab.tpl" -o gl-container-scanning-report.json $IMAGE
    # Print report
    - trivy --exit-code 0 --cache-dir .trivycache/ --no-progress --severity HIGH $IMAGE
    # Fail on severe vulnerabilities
    - trivy --exit-code 1 --cache-dir .trivycache/ --severity CRITICAL --no-progress $IMAGE
cache:
  paths:
    - .trivycache/
# Enables https://docs.gitlab.com/ee/user/application_security/container_scanning/ (Container Scanning report is available on GitLab EE Ultimate or GitLab.com Gold)
artifacts:
  reports:
    container_scanning: gl-container-scanning-report.json
````