# PackageGen

PackageGen is command line tool that generates `Package.swift` files for all your modules based on `Packagefile` and `package.yml` files  
It aims to minimize manifest code writing for new modules by omitting basic properties  
In addition it helps to visualize all your dependencies by rendering dependencies graph to pdf file (see [Rendering Dependencies Graph](https://github.com/kulikov-ivan/pkgen/blob/dev/Docs/GraphRendering.md) for more info)  

<br />
<br />

## Installing

### From release (recommended)
```shell
git clone https://github.com/kulikov-ivan/pkgen pkgen
cd pkgen
git checkout release/1.0.0
swift build
cp .build/debug/pkgen /your/path/to/pkgen
```

<br />

### Homebrew (not supported yet)

```shell
brew install pkgen
```

<br />

### Swift Package Manager

```swift
.package(url: "https://github.com/kulikov-ivan/pkgen.git", from: "1.0.0"),
```

<br />
<br />

## Usage

Basicly, all you need to do is:  

- Create Packagefile in root of your project  
- Fill Packagefile with your external dependencies and default parameters like `swiftToolsVersion`, `platforms`, `swiftLanguageVersions` etc. (see [Packagefile Spec](https://github.com/kulikov-ivan/pkgen/blob/dev/Docs/PackagefileSpec.md) for more info)  
- Add `package.yml` (in root of module, where `Package.swift` file should be located) for every module you have  
- Fill `package.yml` with required parameters. In most cases it's only module dependencies, but you can also customize any parameters that `Package.swift` has (see [Manifest Spec](https://github.com/kulikov-ivan/pkgen/blob/dev/Docs/ManifestSpec.md) for more info)  
- Run `pkgen generate` to generate `Package.swift` for every `package.yml`  
- [Optional] add `Package.swift` to your `.gitignore` to keep things clear  

<br />

So that is what you can achieve after all steps:  

<details>
  <summary>Module's Package.swift manifest file with vanilla SPM</summary>

```swift
// swift-tools-version:5.3

import PackageDescription

let name: String = "ModuleA"

let platforms: [SupportedPlatform] = [
    .iOS(.v14)
]

let dependencies: [Package.Dependency] = [
    .package(path: "../ModuleB"),
    .package(path: "../ModuleC"),
    .package(path: "../ModuleD"),
    .package(url: "https://github.com/ReactiveX/RxSwift.git", .exact("6.2.0")),
    .package(url: "https://github.com/Alamofire/Alamofire.git", .upToNextMajor(from: "5.2.0"))
]

let products: [Product] = [
    .library(
        name: "Constants",
        targets: [
            "Constants"
        ]
    )
]

let targets: [Target] = [
    .target(
        name: "ModuleA",
        dependencies: [
            .product(name: "ModuleB", package: "ModuleB"),
            .product(name: "ModuleC", package: "ModuleC"),
            .product(name: "ModuleD", package: "ModuleD"),
            .product(name: "RxSwift", package: "RxSwift"),
            .product(name: "Alamofire", package: "Alamofire")
        ],
        path: "Sources"
    )
]

let package = Package(
    name: name,
    platforms: platforms,
    products: products,
    dependencies: dependencies,
    targets: targets
)

```

</details>

<details>
  <summary>Module's manifest with PackageGen</summary>

<br />

`Packagefile`:
```yml
swiftToolsVersion: '5.3'

platforms:
  iOS: v14

dependencies:
  - github: ReactiveX/RxSwift
    exact: '6.2.0'
  - github: Alamofire/Alamofire
    upToNextMajor: '5.2.0'

```

<br />

`package.yml`:
```yml
dependencies:
  - ModuleB
  - ModuleC
  - ModuleD
  - RxSwift
  - PromiseKit

```

</details>

<br />

It can be useless when your project has few modules, but it can become really messy when you have 50+ modules to write whole Package.swift for every new module  

<br />
<br />

## Available Commands

```shell
pkgen generate
```

This will look for a `Packagefile` in the current directory called and generate an Xcode project with the name defined in the spec.

Options:

- **-q --quietly**: Disable all logs  
- **--use-cache**: Generate packages only if `package.yml` or `Packagefile` was changed  
Cache file will be located at `/.pkgen/cache/pkgen_cache.json`  

<br />

```shell
pkgen graph
```

This will take provided `Packagefile` and render `graph.pdf` to provided path  

Arguments:

- **packagefile**: Path to `Packagefile`  
- **path**: Path to `graph.pdf` output file  

<br />

```shell
pkgen help
```

Get detailed usage information from cli  

<br />
<br />

## Documentation

- See [Packagefile Spec](https://github.com/kulikov-ivan/pkgen/blob/dev/Docs/PackagefileSpec.md) for available properties for Packagefile  
- See [Manifest Spec](https://github.com/kulikov-ivan/pkgen/blob/dev/Docs/ManifestSpec.md) for available properties for project.yml manifest files  
- See [Example Project](https://github.com/kulikov-ivan/pkgen/blob/dev/Docs/ExampleProject.md) to read about how to configure example project  
- See [Rendering Dependencies Graph](https://github.com/kulikov-ivan/pkgen/blob/dev/Docs/GraphRendering.md) to read about how to render dependencies graph for your modules  

<br />
<br />

## Contributions
Feel free to make pull requests, they are always welcome!  
Open issues/PRs for any bugs, features, or documentation.
