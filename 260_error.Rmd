# エラー処理

プログラムの正常な進行が妨げられる自体が起きた場合には、エラーメッセージ（C++ 例外）を発し、プログラムをストップさせることができます。


プログラムの正常な進行が妨げられる事態が起きた場合には、`stop()` 関数を用いてエラーメッセージを表示し実行を停止させることができます。プログラムの進行を停止せずに、ユーザーに警告を発したい場合は `warning()` 関数を用います。関数 `stop()` と `warning()` のどちらとも `Rprintf()` 関数と同じように書式を指定してメッセージを表示することができます。

```
stop("Error: Unexpected condition occurred");
stop("Error: Column %i is not numeric.", i+1);

warning("Warning: Unexpected condition occurred");
warning("Warning: Column %i is not numeric.", i+1);
```

下のコード例では、関数に与えた数値がマイナスであった場合にエラーを出力して実行を停止します。

```
// [[Rcpp::export]]
double rcpp_log(double x) {
    if (x <= 0.0) {
        stop("'x' must be a positive value.");
    }
    return log(x);
}
```

実行結果

```
> rcpp_log(-1)
 エラー: 'x' must be a positive value.
```


# C++ 例外を投げる

`throw exception()` を使うことで、C++ の例外を throw する事もできます。

```
throw exception("Unexpected condition occurred");
```
