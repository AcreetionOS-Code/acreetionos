---
name: Feature Request
description: Suggest an idea
labels: [enhancement]
body:
  - type: textarea
    id: problem
    attributes:
      label: Problem
      description: What problem would this solve?
    validations:
      required: true
  - type: textarea
    id: solution
    attributes:
      label: Solution
      description: What's your proposed solution?
    validations:
      required: true
  - type: textarea
    id: alternatives
    attributes:
      label: Alternatives
      description: What alternatives have you considered?
