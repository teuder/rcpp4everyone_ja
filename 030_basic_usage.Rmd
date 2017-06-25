# 基本的な使い方

Rcppで記述した関数を実行するまでの流れは次のとおりです。

1. Rcppのコードを書く
2. コンパイル
3. 実行する



## Rcppコードを書く

まずは、Rcppのファイルを作成します。下の例では、数値ベクターの要素の総和を計算する関数 `rcpp_sum()` を定義しています。このコードを sum.cpp という名前で保存します。


```cpp
#include <Rcpp.h>
using namespace Rcpp;

// [[Rcpp::export]]
double rcpp_sum(NumericVector v){
    double sum = 0;
    for(int i=0; i<v.length(); ++i){
        sum += v[i];
    }
    return(sum);
}
```

##コンパイル

`sourceCpp()` がソースコードのコンパイルと R へのロードをしてくれるます。

```R
library(Rcpp)
sourceCpp('sum.cpp')
```

##実行結果

```r
> rcpp_sum(1:10)
[1] 55

> sum(1:10)
[1] 55
```
