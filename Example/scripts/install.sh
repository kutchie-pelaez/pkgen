swift build --package-path ../
cp ../.build/debug/pkgen bin
bin/pkgen generate
