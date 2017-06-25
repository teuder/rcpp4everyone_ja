# Rの関数を利用する

Rcpp 内で R の関数を利用するには、`Function`、`Environment` を用います。


## Function を用いた方法

`Function` クラスを使うと、Rcpp 内から R の関数を呼び出すことができます。R の関数に与えた値がどの引数に渡されるかは、位置と名前に基づいて判断されます。

名前を指定して引数に値を渡すには `Named()` 関数または `_[]` を使用します。`Name()` は、`Named("引数名", 値)` か `Named("引数名") = 値` の２つの方法で用いることができます。

下のコード例では、Rcpp で定義した関数の中で R の関数 `rnorm(n, mean, sd)` を呼び出す例を示します。なお、この方法でパッケージの関数を呼び出す場合は、あらかじめ R で library 関数などを用いてパッケージの環境をサーチパスに追加しておく必要があります。

```cpp
// [[Rcpp::export]]
NumericVector my_fun(){
    // rnorm 関数を呼び出す
    Function f("rnorm");   
    // 次の例は rnorm(n=5, mean=10, sd=2)と解釈されます
    // 1番目の引数は位置にもとづき n に渡され
    // 2, 3番目の引数は名前にもとづきsd,meanに渡されます
    return f(5, Named("sd")=2, _["mean"]=10);
}
```

実行例

```r
> my_fun()
[1]  8.014863 10.459980  7.741581  9.000762 11.465920
```

上の例では、Rcpp で呼び出される R の関数の返値の型は `NumericVector` である前提になっています。しかし、下の例のように Rcpp 関数内で呼び出される R の関数の返値の型が決まっていない場合もよくあります。そのような場合には、どんな型でも代入できる `RObject` か `List` に関数の返値を代入するようにすると良いでしょう。

下のコード例では、R の `lapply()` を単純化した関数を Rcpp で定義する例を示します。

```cpp
// [[Rcpp::export]]
List rcpp_lapply(List input, Function f) {
    // リスト input の各要素に関数 f を適用した結果をリストとして返します
    // リストの要素数 n
    R_xlen_t n = input.length();
    // 出力用に要素数が n のリストを作成します
    List out(n);
    // input の各要素に f() を適用して out に格納します
    // f() の返値の型は不明ですがリストには代入可能です
    for(R_xlen_t i = 0; i < n; ++i) {
        out[i] = f(input[i]);
    }
    return out;
}
```


## Environment を用いた方法

`Environment` クラスを利用するとパッケージ等の環境からオブジェクト（変数や関数）を取り出すことができます。

下のコード例では、パッケージ `Matrix` にある関数 `Matrix()` を呼び出す例を示します。なお、この方法でパッケージの関数を呼び出す場合には、library 関数を用いてパッケージの環境をサーチパスに追加する必要はありません。

```cpp
// [[Rcpp::export]]
S4 rcpp_package_function(NumericMatrix m){
    // Matrix パッケージの名前空間を取得します
    Environment pkg = Environment::namespace_env("Matrix");
    
    // Matrix パッケージの Matrix 関数を取得します
    Function f = pkg["Matrix"];
    
    // Matrix( m, sparse = TRIE ) を実行します
    return f( m, Named("sparse", true));
}
```

実行結果

```
> m <- matrix(c(1,0,0,2), nrow = 2, ncol = 2)
> rcpp_package_function(m)
2 x 2 sparse Matrix of class "dsCMatrix"
        
[1,] 1 .
[2,] . 2
```

