##C++のソースにRのコードを埋め込む

C++ のコード内に R のコードを記述することもできます。

C++ コード内で `/*** R`で始まるコメントの内に R のコードを書くと、`sourceCpp()` した時に、それが実行されます。・


```cpp
#include<Rcpp.h>
using namespace Rcpp;

// [[Rcpp::export]]
double rcpp_sum(NumericVector v){
    double sum = 0;
    for(int i=0; i<v.length(); ++i){
        sum += v[i];
    }
    return(sum);
}

/*** R
rcpp_sum(1:10)
*/
```



