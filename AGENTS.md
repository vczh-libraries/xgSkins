# General Instructions

Must read instructions before starting:
- [Project.md](./Project.md) -- Project structure, build commands, script descriptions.
- [GacUIExtension.md](./GacUIExtension.md) -- The organization of this repo follow the general **GacUI Extension Convention**.

Supported platform for development activities:
- Windows

Additional material:
- [spec/README.md](./spec/README.md) -- Specification of the extension.
- [doc/README.md](./doc/README.md) -- Documentation of the extension.

When a request begins with `investigate` or `review`, follow `<Release-repo>/AGENTS.md` to find the related task:
- Such task might request for maintain `Copilot_Investigate.md`, use the `.github` folder in this repo instead.

When `job:*` is mentioned, it means `.github/Jobs/job.*.prompt.md`.

## Maintaining Documents

- DO NOT mix up specification and documentation.
- Specification describes:
  - What purpose does the extension service.
  - How should the extension look like.
  - It should focus on requirements, such as scope, non scope, what user would expect to see.
- Documentation describes:
  - API usage.
  - Background inside design.
  - It should focus on technical details.
- Use a hyperlink `[<XXX-repo>/path/to/file](github-url)` to reference files that is not in this repo.
  - If the target file is a document, you could skip the url path while quoting the path in a pair of (`).
- `GacUIExtension.md` is not allowed to change.

## Maintaining .gitignore

You are only allowed to update the `# Repo-specific` section:
- Files could be updated after running `GacBuild.ps1` or `GacGen.ps1`, log folders should be ignored, specify each log folder.
- Files from building should not be committed, the `.gitignore` files already ignored common MSBuild generated files.
