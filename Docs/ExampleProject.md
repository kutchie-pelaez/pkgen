# Example Project

Example project demonstrates how you can use pkgen manifests in modularized iOS project  
To bootstrap project use following commands:  

<br/>

To generate SPM manifest files for example project modules (in Example directory):  
```shell
make install
```

<br/>

To open project workspace:  
```shell
open ExampleProject.xcworkspace -a Xcode.app
```

<br/>

To regenerate manifest files later:  
```shell
make pkgen
```
