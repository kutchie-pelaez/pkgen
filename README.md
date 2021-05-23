# PackageGen [![license](https://img.shields.io/badge/license-MIT-lightgrey.svg)](https://github.com/kulikov-ivan/pkgen/master/LICENSE) [![release](https://img.shields.io/github/release/kulikov-ivan/pkgen.svg)](https://github.com/kulikov-ivan/pkgen/releases)

PackageGen is command line tool that generates `Package.swift` files based on `Packagefile` and `package.yml` files. It helps to minimize manifest code writing for new modules. In addition it can render dependencies graph to give you visual representation of your dependencies (see [Rendering Dependencies Graph](https://github.com/kulikov-ivan/pkgen/blob/dev/Docs/GraphRendering.md) for more info).  
This tool is simply allow you to write same `Package.swift` manifest files in yml and omit some repeating properties by declaring all of them in one place - `Packagefile` (which is also written in yml).  
It seems not really useful when your project has few modules, but process of writing whole `Package.swift` over and over againg can become messy and tedious when your projects grows (with number of modules respectively).  

Here is simple comparison between two approaches (note that `Packagefile` is one for whole project):

<details>
  <summary>Vanilla Package.swift</summary>

<br />

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
        name: "ModuleA",
        targets: [
            "ModuleA"
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
  <summary>PackageGen's package.yml</summary>

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

## Installing

### From release (recommended)

```shell
git clone https://github.com/kulikov-ivan/pkgen pkgen
cd pkgen
git checkout release/1.0.0
swift build
cp .build/debug/pkgen /your/path/to/pkgen
```

### Homebrew (not supported yet)

```shell
brew install pkgen
```

### Swift Package Manager

```swift
.package(url: "https://github.com/kulikov-ivan/pkgen.git", from: "1.0.0")
```

<br />

## Usage

Basically, all you need to do is:
- Create `Packagefile` in root of your project
- Fill `Packagefile` with all external dependencies and default parameters (`swiftToolsVersion`, `platforms`, `swiftLanguageVersions` etc.) you need (see [Packagefile Spec](https://github.com/kulikov-ivan/pkgen/blob/dev/Docs/PackagefileSpec.md) for more info)
- Add `package.yml` (in root of package) for every package you have
- Fill `package.yml` with required parameters. In most cases it's just module dependencies, but you can also customize any parameters that vanilla `Package.swift` has (see [Manifest Spec](https://github.com/kulikov-ivan/pkgen/blob/dev/Docs/ManifestSpec.md) for more info)
- Run `pkgen generate` to generate `Package.swift` for every pacakge
- [Optional] add `Package.swift` to your `.gitignore` to keep things clear 🙂

<br />

## Available Commands

```shell
pkgen generate
```

This will look for a `Packagefile` in the current directory and traverse all subdirectories (excluding hidden directories) in current directory for any `package.yml` files. For every `package.yml` found this command will generate Package.swift file next to it.

Options:

- **-q --quietly** - Disable all logs
- **--use-cache** - Generate `Package.swift` for only modifies `package.yml` from last generation (or if `Packagefile` was changed). Cache file will be located at `~/.pkgen/cache/pkgen_cache.json`

```shell
pkgen graph
```

This will take provided `Packagefile` and render `graph.pdf` to output path.

Arguments:

- **packagefile** - Path to `Packagefile`
- **path** - Path to `graph.pdf` output file

```shell
pkgen help
```

Get detailed usage information from cli.

<br />

## Documentation

- See [Packagefile Spec](https://github.com/kulikov-ivan/pkgen/blob/dev/Docs/PackagefileSpec.md) for available properties for Packagefile
- See [Manifest Spec](https://github.com/kulikov-ivan/pkgen/blob/dev/Docs/ManifestSpec.md) for available properties for project.yml manifest files
- See [Example Project](https://github.com/kulikov-ivan/pkgen/blob/dev/Docs/ExampleProject.md) to read about how to configure example project
- See [Rendering Dependencies Graph](https://github.com/kulikov-ivan/pkgen/blob/dev/Docs/GraphRendering.md) to read about how to render dependencies graph for your modules

<br />

## Contributions
Feel free to make pull requests, they are always welcome! Open issues/PRs for any bugs, features, or documentation.

<br />

## License

MIT license. See [LICENSE](LICENSE) for details.
