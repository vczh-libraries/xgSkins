# General Instructions

Must read instructions before starting:
- [Project.md](./Project.md) -- Project structure, build commands, script descriptions.
- [GacUIExtension.md](./GacUIExtension.md) -- Repo organization and instructions to follow in development activities.
  - Supported platforms for development activities: Windows, macOS.
- [job.createSkin.prompt.md](./Jobs/job.createSkin.prompt.md) -- Instructions of creating a new skin. Requirements in this document should also be followed when updating an existing skin.

Additional material:
- [spec/README.md](./spec/README.md) -- Specification of the extension.
- [doc/README.md](./doc/README.md) -- Documentation of the extension.
- [suggestions/README.md](./suggestions/README.md) -- Known issues from upstream repos.

When a request begins with `investigate` or `review`, follow `<Release-repo>/AGENTS.md` to find the related task:
- Such task might request for maintain `Copilot_Investigate.md`, use the `.github` folder in this repo instead.

When `job:*` is mentioned, it means `Jobs/job.*.prompt.md`.

Any change to repos should commit and push to their current branches (usually `master`).
`Project.md` describes how to organize commits for this repo.
If conflict happens during `git push`, always rebase, DO NOT merge.
