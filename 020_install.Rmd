# インストール

まずは C++ のコンパイラをインストールします。

##開発ツールのインストール

**Windows**：[Rtools](https://cran.r-project.org/bin/windows/Rtools/index.html) をインストールします。すると、C:\\Rtools 以下にgccなどが配置されます。

**Mac**：ターミナルで次のコマンドを打ち Xcode command line tools をインストールします。 `xcode-select --install`

**Linux**：例えば `sudo apt-get install r-base-dev`

自分でインストールした gcc や clang などのコンパイラを使いたい場合には、ユーザーのホームディレクトリ以下に次のファイルを作成し、そこに環境変数の設定を記述します。


* `.R/Makevars` Linux, Mac
* `.R/Makevars.win` Windows

```
CC=/opt/local/bin/gcc-mp-4.7
CXX=/opt/local/bin/g++-mp-4.7
CPLUS_INCLUDE_PATH=/opt/local/include:$CPLUS_INCLUDE_PATH
LD_LIBRARY_PATH=/opt/local/lib:$LD_LIBRARY_PATH
CXXFLAGS= -g0 -O3 -Wall
MAKE=make -j4
```

ちなみに、ユーザーのホームディレクトリは R で次のコードを実行することで調べることができます。

```
path.expand("~")
```

## Rcpp のインストール

コンパイラがインストールできたら、R で Rcpp パッケージをインストールします。

```r
install.packages("Rcpp")
```
