# General Instructions

Before You Start
- [Project.md](./Project.md) -- Project structure, build commands, script descriptions.
- [GacUIExtension.md](./GacUIExtension.md) -- The organization of this repo follow the general **GacUI Extension Convention**, currently supports platform for development activities:
  - Windows
- [spec/README.md](./spec/README.md) -- Specification of the extension.
- [doc/README.md](./doc/README.md) -- Documentation of the extension.

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

## Dependencies

The follow dependencies are required in development activities, but they are not necessary just for building and running the project.

These repos under the same organization must be cloned as sibling folders:
- [Tools](https://github.com/vczh-libraries/Tools)
- [GacUI](https://github.com/vczh-libraries/GacUI)
- [Release](https://github.com/vczh-libraries/Release)

## Building
