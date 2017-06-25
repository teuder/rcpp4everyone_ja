# Rのコード中にRcppのコードを埋め込む

Rcppのコードをファイルに保存せずに、Rのコードの中で記述することもできます。そのためには `sourceCpp()` `cppFunction()` `evalCpp()` を使う。

###sourceCpp()

sourceCpp() に対しては、Rcpp コードを記述したファイルへのパスを与える代わりに、RcppのコードをRの文字列として記述して与えることもできます。

```R
src<-
"#include <Rcpp.h>
using namespace Rcpp;
// [[Rcpp::export]]
double rcpp_sum(NumericVector v){
  double sum = 0;
  for(int i=0; i<v.length(); ++i){
    sum += v[i];
  }
  return(sum);
}"

sourceCpp(code = src)
rcpp_sum(1:10)
```

###cppFunction()

`cppFunction()`を使うと「単一のRcpp関数」を手軽に作成することができます。その際には `#include<Rcpp.h>`と`using namespase Rcpp`の記述を省略できます。

```r
src <-
"double rcpp_sum(NumericVector v){
  double sum = 0;
  for(int i=0; i<v.length(); ++i){
    sum += v[i];
  }
  return(sum);
}
"
Rcpp::cppFunction(src)
rcpp_sum(1:10)
```

###evalCpp()

`evalCpp()` を使うと手軽にRcppの式を評価することができます。

```r
# double の最大値を調べる
> Rcpp::evalCpp('std::numeric_limits<double>::max()')
[1] 1.797693e+308
```