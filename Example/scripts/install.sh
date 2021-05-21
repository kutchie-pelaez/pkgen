swift build --package-path ../
mkdir bin
cp ../.build/debug/pkgen bin
bin/pkgen generate
