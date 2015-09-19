#!/usr/bin/zsh

# golangに関連したスクリプト

# クロスコンパイル用の環境を準備する。
# この関数では、linux/MacOS/Windows それぞれの32/64bit用のビルド環境を用意する
go-crosscompile-build-all() {
    local oss archs os arch
    oss=(darwin linux windows)
    archs=(386 amd64)

    pushd $GOROOT/src
    for os in $oss; do
        for arch in $archs; do
            echo "Build for $os : $arch"
            GOOS=$os GOARCH=$arch $GOROOT/src/make.bash
        done
    done
    popd
}
