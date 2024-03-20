#requires -version 3

${BUILDPATH}=(get-item $PSScriptRoot ).parent.FullName
packer build $args ${BUILDPATH}\image.json
