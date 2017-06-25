# イテレーター

イテレータ（反復子）とは、ベクトルなどの要素にアクセスするためのオブジェクトです。Rcpp のベクトルに対して標準 C++ のアルゴリズムを適用したい場合にはイテレータを利用します。なぜなら標準 C++ で提供されているアルゴリズムの多くはイテレータを使って処理を適用するデータの位置や範囲を指定するためです。

Rcpp のデータ構造には、それぞれ独自のイテレータ型が定義されています。

```
NumericVector::iterator
IntegerVector::iterator
LogicalVector::iterator
CharacterVector::iterator
DataFrame::iterator
List::iterator
```

下の図はイテレータを使ってベクトルの要素にアクセスする方法を模式的に示しています。

![](iterator.png)

* `i = v.begin()` とするとイテレータ `i` は `v` の先頭要素を指し示します。
* `++i` は、i を1つ次の要素を指す状態に更新します。
* `--i` は、i を1つ前の要素を指す状態に更新します。
* `i+1` は、i の1つ次の要素を指し示すイテレータを表します。
* `i-1` は、i の1つ前の要素を指し示すイテレータを表します。
* `*i`  は、i が指し示す要素の値を表します。
* `v.end()` は `v` の末尾（最後の要素の１つ後）を指し示すイテレータを表します。
* `*(v.begin()+k)` は v の k 番目の要素の値（`v[k]`）を表します。

次のコード例は、イテレータを使って `NumericVector`の全ての要素を走査して値の合計値を求める例を示しています。

```cpp
// [[Rcpp::export]]
double rcpp_sum(NumericVector x) {
  double total = 0;
  for(NumericVector::iterator i = x.begin(); i != x.end(); ++i) {
    total += *i;
  }
  return total;
}
```