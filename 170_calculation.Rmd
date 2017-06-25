#四則演算と比較演算

R と同様に、`+ - * /` 演算子により、同じ長さのベクターの要素同士の四則演算を行うことができます。

```
NumericVector x ;
NumericVector y ;

// ベクトルとベクトルの演算
NumericVector res = x + y ;
NumericVector res = x - y ;
NumericVector res = x * y ;
NumericVector res = x / y ;

// ベクトルとスカラーの演算
NumericVector res = x   + 2.0 ;
NumericVector res = 2.0 - x;
NumericVector res = y   * 2.0 ;
NumericVector res = 2.0 / y;

// 演算式と演算式の演算
NumericVector res = x * y + y / 2.0 ;
NumericVector res = x * ( y - 2.0 ) ;
NumericVector res = x / ( y * y ) ;
```

また `-` 演算子は符号を反転します。

```
NumericVector res = -x ;
```

##比較演算

Rと同様に、`==` `!=` `<` `>``>=` `<=`演算子を用いたベクトル同士の値は論理ベクトルを生成します。また、論理ベクターを使って、ベクターの要素にアクセスすることもできます。

```cpp
NumericVector x ;
NumericVector y ;

// ベクトルとベクトルの比較
LogicalVector res = x < y ;
LogicalVector res = x > y ;
LogicalVector res = x <= y ;
LogicalVector res = x >= y ;
LogicalVector res = x == y ;
LogicalVector res = x != y ;

// ベクトルとスカラーの比較
LogicalVector res = x < 2 ;
LogicalVector res = 2 > x;
LogicalVector res = y <= 2 ;
LogicalVector res = 2 != y;

// 演算式と演算式の比較
LogicalVector res = ( x + y ) < ( x*x ) ;
LogicalVector res = ( x + y ) >= ( x*x ) ;
LogicalVector res = ( x + y ) == ( x*x ) ;
```

また、`!` 演算子は論理値を反転します。

```
LogicalVector res = ! ( x < y );
```

論理値ベクターを使ってベクターの要素にアクセスします。

```cpp
NumericVector res = x[x < 2];
```
