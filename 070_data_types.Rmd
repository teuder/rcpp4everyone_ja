# 基本データ型とデータ構造

Rcpp では R の全てのデータ型とデータ構造を利用することができます。ユーザーは Rcpp で提供される様々なクラスを通して、実行中の R のメモリにあるオブジェクトを直接操作することができます。この章では Rcpp で利用できるデータ型とデータ構造を紹介します。


## 基本データ型

R には基本的なデータ型として、`logical`（論理値）、`integer`（整数）、`numeric`（実数）、`complex`（複素数）、`character`（文字列）、`Date`（日付）、`POSIXct`（日時） があります。Rcpp には、これらと対応したベクトル型と行列型が定義されています。ただし、日付と日時については R と同様にベクトル型だけが定義されています。

本書ではこれ以降 Rcpp が提供するベクトル型と行列型を総称するために `Vector`、 `Matrix` という語を用います。

R、Rcpp、C++ で利用できる基本的なデータ型の対応関係をまとめると下の表のようになります。

| | Rベクトル|Rcppベクトル型|Rcpp行列型|Rcppスカラー型|C++スカラー型|
|:---:|:---:|:---:|:---:|:---:|:---:|
|論理  |`logical`  |`NumericVector`| `NumericMatrix`| - |`bool`|
|整数  |`integer`  |`IntegerVector`|`IntegerMatrix`|-|`int`|
|実数  |`numeric` |`NumericVector`|`NumericMatrix`|-|`double`|
|複素数|`complex`  |`ComplexVector`| `ComplexMatrix`|`Rcomplex`|`complex`|
|文字列|`character`|`CharacterVector` (`StringVector`)| `CharacterMatrix` (`StringMatrix`)|`String`|`string`|
|日付  |`Date`     |`DateVector`|-|`Date`|-|
|日時  |`POSIXct`  |`DatetimeVector`|-| `Datetime` | `time_t` |


## データ構造

R にはベクトル、行列の他にデータフレーム、リスト、S3 クラス、S4 クラスのデータ構造がありますが、Rcpp はそれら全てを扱うことができます。

下の表に R と Rcpp のデータ構造の対応関係を示します。

|R データ構造|Rcpp データ構造|
|:---:|:---:|
|`data.frame`|`DataFrame`|
|`list`|`List`|
|S3 クラス|`List`|
|S4 クラス|`S4`|

`Dataframe` は、様々な型のベクトルを要素として格納することができます。しかし、要素となる全てのベクトルの長さは等しいという制約があります。

`List` は、`Dataframe` や `List` を含む、どのような型のオブジェクトでも要素として持つことができます。要素となるベクトルの長さにも制限はありません。

S3 クラスは属性 `class` に独自の名前が設定されたリストですので、使い方は `List` と同様です。

S4 クラスはスロット（`slot`）と呼ばれる内部データを持っています。Rcpp の `S4` を用いることで R で定義した S4 クラスのオブジェクトの作成、および、スロットへのアクセスが可能になります。

また、Rcpp では `Vector`, `List`, `DataFrame` は、どれもある種のベクトルとして実装されています。つまり、`Vector` は、スカラー値を要素とするベクトル、`DataFrame` は同じ長さの `Vector` オブジェクトを要素とするベクトル、`List` は任意のオブジェクトを要素とするベクトルです。そのため、`Vector`, `List`, `DataFrame` は多くの共通するメンバー関数を持っています。
