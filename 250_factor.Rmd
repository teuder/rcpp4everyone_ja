# factor

因子ベクトル（`factor`）の実体は属性 `levels` が定義された整数ベクトルです。因子ベクトルの各要素の値は、属性 levels の最初の要素に対応する値が 1、次の要素に対応する値が 2、というようになっています。


下の例では、`IntergerVector` に属性を指定することで `factor` に変換する例を示しています。 
```
// factor の作成
// [[Rcpp::export]]
RObject rcpp_factor(){
  IntegerVector v = {1,2,3,1,2,3};
  CharacterVector ch = {"A","B","C"};
  v.attr("class") = "factor";
  v.attr("levels") = ch;
  return v;
}
```

下の実行結果を見ると R に返された整数ベクトル v は factor 型として扱われていることがわかります。

```
> rcpp_factor()
[1] A B C A B C
Levels: A B C
```



