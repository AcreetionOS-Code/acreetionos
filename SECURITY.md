# Security Policy

## Security Advisories

AcreetionOS follows [Arch Linux security advisories](https://security.archlinux.org) for upstream vulnerability tracking. As a distribution built on Arch Linux, we rely on the Arch Linux security team for identifying and patching vulnerabilities in shared packages.

## Current Status

AcreetionOS does **not** have its own dedicated security team or vulnerability response infrastructure at this time. Our security posture relies on:

- Upstream Arch Linux security patches
- Rolling release model for timely updates
- Community awareness and reporting

We do **not** operate a public API for security notifications.

## Reporting a Security Issue

If you discover a security vulnerability in AcreetionOS:

1. **Urgent issues**: Contact us via [Discord](https://discord.gg/VHqQkJASw7) or open a [GitHub Issue](https://github.com/AcreetionOS/acreetionos/issues)
2. **Non-urgent issues**: Open a standard GitHub Issue with the `security` label

We aim to respond to security reports within **72 hours**.

## Disclosure Policy

We appreciate **responsible disclosure**. Please:

- Do not publicly disclose vulnerabilities before we have had a reasonable opportunity to investigate and address them
- Provide sufficient details to reproduce and understand the issue
- Allow time for fixes to be deployed before public disclosure

## Scope

This security policy covers:

- The AcreetionOS ISO build system and installer
- Official AcreetionOS packages and configurations
- The acreetionos.org website and infrastructure

Third-party packages, upstream Arch Linux packages, and user-installed software are outside the scope of this policy.
