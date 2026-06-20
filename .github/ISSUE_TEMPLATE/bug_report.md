---
name: Bug Report
description: File a bug report
labels: [bug]
body:
  - type: textarea
    id: description
    attributes:
      label: Describe the bug
      description: What happened?
    validations:
      required: true
  - type: textarea
    id: reproduction
    attributes:
      label: Steps to reproduce
      description: How can we reproduce this?
    validations:
      required: true
  - type: input
    id: version
    attributes:
      label: AcreetionOS version
      description: What ISO version or build date?
    validations:
      required: true
  - type: textarea
    id: system
    attributes:
      label: System information
      description: Hardware specs, kernel version, etc.
