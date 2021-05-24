# Packagefile Spec

- [Packagefile Spec](#packagefile-spec)
  - [General](#general)
  - [Packagefile](#packagefile)
  - [PackagefileDependency](#packagefiledependency)

<br/>

## General

Packagefile file can be written in YAML. Required properties are marked with checkbox.

<br/>

## Packagefile

type: **object**

> - [ ] **swiftToolsVersion**: **`String`** - Default value to use for all manifests. If not presented, parsing will fail for manifests withouth this property
> - [ ] **defaultLocalization**: **`String`** - Default value to use for all manifests
> - [ ] **platforms**: [**`Platforms`**](ManifestSpec.md#Platforms) - Default value to use for all manifests
> - [ ] **pkgConfig**: **`String`** - Default value to use for all manifests
> - [ ] **providers**: [**`[Provider]`**](ManifestSpec.md#Provider) - Default value to use for all manifests
> - [ ] **swiftLanguageVersions**: [**`[SwiftVersion]`**](ManifestSpec.md#swiftversion) - Default value to use for all manifests
> - [ ] **cLanguageStandard**: [**`CStandard`**](ManifestSpec.md#cstandard) - Default value to use for all manifests
> - [ ] **cxxLanguageStandard**: [**`CXXStandard`**](ManifestSpec.md#cxxstandard) - Default value to use for all manifests
> - [ ] **dependencies**: [**`[PackagefileDependency]`**](#PackagefileDependency) - List of dependencies to use in manifests

<br/>

## PackagefileDependency

type: **object**

Same as [**`PackageDependency`**](ManifestSpec.md#PackageDependency) + `id` property. Manifest can use this dependencies referenced by `id`.  
`github` can be optionally used instead of `url` property (same as `url = https://github.com/<github>.git`).

<details>
<summary>Example</summary>

<br />

`Packagefile`:
```yml
dependencies:
  - github: Alamofire/Alamofire
    upToNextMajor: '5.2.0'
    id: Alamofire

  - github: kishikawakatsumi/KeychainAccess
    from: '4.2.2'
    id: KeychainAccess

  - url: https://github.com/amplitude/Amplitude-iOS.git
    from: '5.1.0'
    name: Amplitude
    id: Amplitude

  - url: https://github.com/yandexmobile/metrica-sdk-ios.git
    from: '3.14.1'
    name: YandexMobileMetrica
    id: AppMetrica
```

Later in `package.yml`:
```yml
dependencies:
  - Alamofire
  - KeychainAccess
  - Amplitude
  - AppMetrica
```

</details>

</br>

> - [x] **url**: **`String`**
> - [x] **from**: **`String`**
> - [x] **id**: **`String`**
> - [ ] **name**: **`String`**

*or*

> - [x] **url**: **`String`**
> - [x] **branch**: **`String`**
> - [x] **id**: **`String`**
> - [ ] **name**: **`String`**

*or*

> - [x] **url**: **`String`**
> - [x] **exact**: **`String`**
> - [x] **id**: **`String`**
> - [ ] **name**: **`String`**

*or*

> - [x] **url**: **`String`**
> - [x] **revision**: **`String`**
> - [x] **id**: **`String`**
> - [ ] **name**: **`String`**

*or*

> - [x] **url**: **`String`**
> - [x] **upToNextMajor**: **`String`**
> - [x] **id**: **`String`**
> - [ ] **name**: **`String`**

*or*

> - [x] **url**: **`String`**
> - [x] **upToNextMinor**: **`String`**
> - [x] **id**: **`String`**
> - [ ] **name**: **`String`**

*or*

> - [x] **url**: **`String`**
> - [x] **from**: **`String`**
> - [x] **to**: **`String`**
> - [x] **id**: **`String`**
> - [ ] **name**: **`String`**

*or*

> - [x] **url**: **`String`**
> - [x] **from**: **`String`**
> - [x] **upTo**: **`String`**
> - [x] **id**: **`String`**
> - [ ] **name**: **`String`**
