# Manifest Spec

- [Manifest Spec](#manifest-spec)
  - [General](#general)
  - [Package](#package)
  - [Platforms](#platforms)
    - [IOSVersion](#iosversion)
    - [MacOSVersion](#macosversion)
    - [TVOSVersion](#tvosversion)
    - [WatchOSVersion](#watchosversion)
  - [Provider](#provider)
  - [Product](#product)
    - [LinkingType](#linkingtype)
  - [PackageDependency](#packagedependency)
  - [Target](#target)
    - [TargetDependency](#targetdependency)
      - [TargetDependencyCondition](#targetdependencycondition)
    - [Resource](#resource)
      - [ResourceLocalization](#resourcelocalization)
    - [CSetting](#csetting)
    - [CXXSetting](#cxxsetting)
    - [SwiftSetting](#swiftsetting)
    - [LinkerSetting](#linkersetting)
    - [BuildSettingCondition](#buildsettingcondition)
      - [BuildConfiguration](#buildconfiguration)
    - [Platform](#platform)
  - [SwiftVersion](#swiftversion)
  - [CStandard](#cstandard)
  - [CXXStandard](#cxxstandard)

---

## General

Manifest file can be written in YAML. Required properties are marked with checkbox.

---

## Package

type: **object**

> - [ ] **swiftToolsVersion**: `String` - Value from Packagefile (if any) will be used if not presented. If Packagefile and manifest don't have this property parsing will fail
> - [ ] **name**: `String` - Directory name where this file located will be used if not presented
> - [ ] **defaultLocalization**: `String` - Value from Packagefile (if any) will be used if not presented
> - [ ] **platforms**: [`Platforms`](#Platforms) - Value from Packagefile (if any) will be used if not presented
> - [ ] **pkgConfig**: `String` - Value from Packagefile (if any) will be used if not presented
> - [ ] **providers**: [`[Provider]`](#Provider) - Value from Packagefile (if any) will be used if not presented
> - [ ] **products**: [`[Product]`](#Product) - Single **default product** will be used if not presented:
> - [ ] **dependenies**: [`[PackageDependency]`](#PackageDependency)
> - [ ] **targets**: [`[Target]`](#Target) - Single **default target** will be used if not presented:
> - [ ] **swiftLanguageVersions**: [`[SwiftVersion]`](#SwiftVersion) - Value from Packagefile (if any) will be used if not presented
> - [ ] **cLanguageStandard**: [`CStandard`](#CStandard) - Value from Packagefile (if any) will be used if not presented
> - [ ] **cxxLanguageStandard**: [`CXXStandard`](#CXXStandard) - Value from Packagefile (if any) will be used if not presented

Default product:
```yaml
type: library
name: <NAME>
targets: 
  - <NAME>
```

Default target:
```yaml
type: library
name: <NAME>
targets: 
  - <NAME>
```

---

## Platforms

type: **object**

> - [ ] **iOS**: [`IOSVersion`](#IOSVersion)
> - [ ] **macOS**: [`MacOSVersion`](#MacOSVersion)
> - [ ] **tvOS**: [`TVOSVersion`](#TVOSVersion)
> - [ ] **watchOS**: [`WatchOSVersion`](#WatchOSVersion)

---

### IOSVersion

type: **enum**

> - **`v8`**
> - **`v9`**
> - **`v10`**
> - **`v11`**
> - **`v12`**
> - **`v13`**
> - **`v14`**

---

### MacOSVersion

type: **enum**

> - **`v10_10`**
> - **`v10_11`**
> - **`v10_12`**
> - **`v10_13`**
> - **`v10_14`**
> - **`v10_15`**
> - **`v11`**

---

### TVOSVersion

type: **enum**

> - **`v9`**
> - **`v10`**
> - **`v11`**
> - **`v12`**
> - **`v13`**
> - **`v14`**

---

### WatchOSVersion

type: **enum**

> - **`v2`**
> - **`v3`**
> - **`v4`**
> - **`v5`**
> - **`v6`**
> - **`v7`**

---

## Provider

type: **object**

> - [x] **type**: **`apt`**
> - [x] **packages**: `[String]`

*or*

> - [x] **type**: **`brew`**
> - [x] **packages**: `[String]`

*or*

> - [x] **type**: **`yum`**
> - [x] **packages**: `[String]`

---

## Product

type: **object**

> - [x] **type**: **`executable`**
> - [x] **name**: `String`
> - [x] **targets**: `[String]`

*or*

> - [x] **type**: **`library`**
> - [x] **name**: `String`
> - [x] **targets**: `[String]`
> - [ ] **linking**: [`LinkingType`](#LinkingType) - **`auto`** by default

---

### LinkingType

type: **enum**

> - **`static`**
> - **`dynamic`**
> - **`auto`**

---

## PackageDependency

type: **object** or **string**  

If string is provided, parser will search for remote dependency with this name in Packagefile firstly  
If remote dependencies were not found and string represents some local path (i.e. is contains '/') parser will search for package at provided path  
If provided string isn't local path (i.e. doesn't contain '/') parser will search for local package at '../`<PROVIDED_STRING>`' path

> **`'SomeRemoteDependencyFromPackagefile'`**

*or*

> **`'../../some/path/to/local/package'`**

*or*

> **`'OtherLocalPackageName'`**

*or*

> - [x] **path**: `String`
> - [ ] **name**: `String`

*or*

> - [x] **url**: `String`
> - [x] **from**: `String`
> - [ ] **name**: `String`

*or*

> - [x] **url**: `String`
> - [x] **branch**: `String`
> - [ ] **name**: `String`

*or*

> - [x] **url**: `String`
> - [x] **exact**: `String`
> - [ ] **name**: `String`

*or*

> - [x] **url**: `String`
> - [x] **revision**: `String`
> - [ ] **name**: `String`

*or*

> - [x] **url**: `String`
> - [x] **upToNextMajor**: `String`
> - [ ] **name**: `String`

*or*

> - [x] **url**: `String`
> - [x] **upToNextMinor**: `String`
> - [ ] **name**: `String`

*or*

> - [x] **url**: `String`
> - [x] **from**: `String`
> - [x] **to**: `String`
> - [ ] **name**: `String`

*or*

> - [x] **url**: `String`
> - [x] **from**: `String`
> - [x] **upTo**: `String`
> - [ ] **name**: `String`

---

## Target

type: **object**

> - [x] **type**: **`binaryTarget`**
> - [x] **name**: `String`
> - [x] **path**: `String`

*or*

> - [x] **type**: **`binaryTarget`**
> - [x] **name**: `String`
> - [x] **url**: `String`
> - [x] **checksum**: `String`

*or*

> - [x] **type**: **`systemLibrary`**
> - [x] **name**: `String`
> - [ ] **path**: `String`
> - [ ] **pkgConfig**: `String`
> - [ ] **providers**: [`[Provider]`](#Provider)

*or*

> - [x] **type**: **`target`**
> - [x] **name**: `String`
> - [ ] **dependencies**: [`[TargetDependency]`](#TargetDependency)
> - [ ] **path**: `String`
> - [ ] **exclude**: `[String]`
> - [ ] **sources**: `[String]`
> - [ ] **resources**: [`[Resource]`](#Resource)
> - [ ] **publicHeadersPath**: `String`
> - [ ] **cSettings**: [`[CSetting]`](#CSetting)
> - [ ] **cxxSettings**: [`[CXXSetting]`](#CXXSetting)
> - [ ] **swiftSettings**: [`[SwiftSetting]`](#SwiftSetting)
> - [ ] **linkerSettings**: [`[LinkerSetting]`](#LinkerSetting)

*or*

> - [x] **type**: **`testTarget`**
> - [x] **name**: `String`
> - [ ] **dependencies**: [`[TargetDependency]`](#TargetDependency)
> - [ ] **path**: `String`
> - [ ] **exclude**: `[String]`
> - [ ] **sources**: `[String]`
> - [ ] **resources**: [`[Resource]`](#Resource)
> - [ ] **publicHeadersPath**: `String`
> - [ ] **cSettings**: [`[CSetting]`](#CSetting)
> - [ ] **cxxSettings**: [`[CXXSetting]`](#CXXSetting)
> - [ ] **swiftSettings**: [`[SwiftSetting]`](#SwiftSetting)
> - [ ] **linkerSettings**: [`[LinkerSetting]`](#LinkerSetting)

---

### TargetDependency

type: **object** or **string**

> - [x] **type**: **`byName`**
> - [x] **name**: `String`
> - [ ] **condition**: [`TargetDependencyCondition`](#TargetDependencyCondition)

*or*

> - [x] **type**: **`product`**
> - [x] **name**: `String`
> - [x] **package**: `String`
> - [ ] **condition**: [`TargetDependencyCondition`](#TargetDependencyCondition)

*or*

> - [x] **type**: **`target`**
> - [x] **name**: `String`
> - [ ] **condition**: [`TargetDependencyCondition`](#TargetDependencyCondition)

---

#### TargetDependencyCondition

type: **object**

> - [x] **type**: **`when`**
> - [ ] **platforms**: [`[Platform]`](#Platform)

---

### Resource

type: **object**

> - [x] **type**: **`copy`**
> - [x] **path**: `String`

*or*

> - [x] **type**: **`process`**
> - [x] **path**: `String`
> - [ ] **localization**: [`ResourceLocalization`](#ResourceLocalization)

---

#### ResourceLocalization

type: **enum** or **string**

> - **`base`**
> - **`default`**

---

### CSetting

type: **object**

> - [x] **type**: **`define`**
> - [x] **name**: `String`
> - [ ] **to**: `String`
> - [ ] **condition**: [`BuildSettingCondition`](#BuildSettingCondition)

*or*

> - [x] **type**: **`headerSearchPath`**
> - [x] **path**: `String`
> - [ ] **condition**: [`BuildSettingCondition`](#BuildSettingCondition)

*or*

> - [x] **type**: **`unsafeFlags`**
> - [x] **path**: `[String]`
> - [ ] **condition**: [`BuildSettingCondition`](#BuildSettingCondition)

---

### CXXSetting

type: **object**

> - [x] **type**: **`define`**
> - [x] **name**: `String`
> - [ ] **to**: `String`
> - [ ] **condition**: [`BuildSettingCondition`](#BuildSettingCondition)

*or*

> - [x] **type**: **`headerSearchPath`**
> - [x] **path**: `String`
> - [ ] **condition**: [`BuildSettingCondition`](#BuildSettingCondition)

*or*

> - [x] **type**: **`unsafeFlags`**
> - [x] **path**: `[String]`
> - [ ] **condition**: [`BuildSettingCondition`](#BuildSettingCondition)

---

### SwiftSetting

type: **object**

> - [x] **type**: **`define`**
> - [x] **name**: `String`
> - [ ] **condition**: [`BuildSettingCondition`](#BuildSettingCondition)

*or*

> - [x] **type**: **`unsafeFlags`**
> - [x] **flags**: `[String]`
> - [ ] **condition**: [`BuildSettingCondition`](#BuildSettingCondition)

---

### LinkerSetting

type: **object**

> - [x] **type**: **`define`**
> - [x] **framework**: `String`
> - [ ] **condition**: [`BuildSettingCondition`](#BuildSettingCondition)

*or*

> - [x] **type**: **`linkedLibrary`**
> - [x] **library**: `String`
> - [ ] **condition**: [`BuildSettingCondition`](#BuildSettingCondition)

*or*

> - [x] **type**: **`unsafeFlags`**
> - [x] **flags**: `[String]`
> - [ ] **condition**: [`BuildSettingCondition`](#BuildSettingCondition)

---

### BuildSettingCondition

type: **object**

> - [x] **type**: **`when`**
> - [ ] **platforms**: [`[Platform]`](#Platform)
> - [ ] **configuration**: [`BuildConfiguration`](#BuildConfiguration)

---

#### BuildConfiguration

type: **enum**

> - **`debug`**
> - **`release`**

---

### Platform

type: **enum**

> - **`android`**
> - **`iOS`**
> - **`linux`**
> - **`macOS`**
> - **`tvOS`**
> - **`wasi`**
> - **`watchOS`**
> - **`windows`**

---

## SwiftVersion

type: **enum**

> - **`3`**
> - **`4`**
> - **`4_2`**
> - **`5`**

---

## CStandard

type: **enum**

> - **`c89`**
> - **`c90`**
> - **`c99`**
> - **`c11`**
> - **`gnu89`**
> - **`gnu90`**
> - **`gnu99`**
> - **`gnu11`**
> - **`iso9899_1990`**
> - **`iso9899_199409`**
> - **`iso9899_1999`**
> - **`iso9899_2011`**

---

## CXXStandard

type: **enum**

> - **`cxx98`**
> - **`cxx03`**
> - **`cxx11`**
> - **`cxx14`**
> - **`gnucxx98`**
> - **`gnucxx03`**
> - **`gnucxx11`**
> - **`gnucxx14`**
