# acreetionos variants

this is the central versioning template system for acreetionos builds. spin up unofficial builds, experiment with new configs, or create official release variants — all from one template.

## directory structure

```
variants/
├── _template/         # base template — copy this to start a new variant
│   ├── profiledef.sh  # override iso name, label, publisher, etc
│   ├── packages.x86_64 # extra packages appended to base list
│   └── airootfs/      # variant-specific overlay files (optional)
├── official/          # acreetionos official release variants
├── unofficial/        # community & experimental builds
└── README.md          # this file
```

## quick start

```bash
# create a new unofficial variant
./init-variant.sh my-cool-build

# create a new official variant  
./init-variant.sh kde-edition official

# build a specific variant
./build.sh my-cool-build

# build the base acreetionos (no variant)
./build.sh
```

## how it works

1. each variant overrides `profiledef.sh` and `packages.x86_64` from the base
2. the build script merges variant configs with base configs at build time
3. `airootfs/` in the variant gets layered on top of the base `airootfs/`
4. ISOs output to `../ISO/<variant-name>/`

## creating a variant

just copy `_template/` to `unofficial/` (or `official/`), edit two files, and build:

- **profiledef.sh** — change `iso_name`, `iso_label`, `iso_publisher`, `iso_application`, `iso_version`
- **packages.x86_64** — add or remove packages for your variant
- **airootfs/** — drop in any extra config files, scripts, wallpapers

## scaling

this template is designed to scale. every unofficial build branches from the same base. when the base updates, all variants can rebase. no more copy-pasting whole repos — just maintain your variant's diff.
