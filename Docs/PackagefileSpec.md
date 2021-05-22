# Packagefile Spec

- [Packagefile Spec](#packagefile-spec)
  - [General](#general)
  - [Packagefile](#packagefile)
  - [PackagefileDependency](#packagefiledependency)

---

## General

Packagefile file can be written in YAML. Required properties are marked with checkbox.

---

## Packagefile

type: **object**

> - [ ] **swiftToolsVersion**: `String` - Default value to use for all manifests. If not presented, parsing will fail for manifests withouth this property
> - [ ] **defaultLocalization**: `String` - Default value to use for all manifests
> - [ ] **platforms**: [`Platforms`](https://github.com/kulikov-ivan/pkgen/blob/dev/Docs/ManifestSpec.md#Platforms) - Default value to use for all manifests
> - [ ] **pkgConfig**: `String` - Default value to use for all manifests
> - [ ] **providers**: [`[Provider]`](https://github.com/kulikov-ivan/pkgen/blob/dev/Docs/ManifestSpec.md#Provider) - Default value to use for all manifests
> - [ ] **swiftLanguageVersions**: [`[SwiftVersion]`](https://github.com/kulikov-ivan/pkgen/blob/dev/Docs/ManifestSpec.md#swiftversion) - Default value to use for all manifests
> - [ ] **cLanguageStandard**: [`CStandard`](https://github.com/kulikov-ivan/pkgen/blob/dev/Docs/ManifestSpec.md#cstandard) - Default value to use for all manifests
> - [ ] **cxxLanguageStandard**: [`CXXStandard`](https://github.com/kulikov-ivan/pkgen/blob/dev/Docs/ManifestSpec.md#cxxstandard) - Default value to use for all manifests
> - [ ] **externalDependencies**: [`[PackagefileDependency]`](#PackagefileDependency) - List of dependencies to use in manifests

---

## PackagefileDependency

type: **object**

// TODO: -
