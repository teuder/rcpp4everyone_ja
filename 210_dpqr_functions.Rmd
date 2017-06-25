# 確率分布

Rcpp は R にある主要な全ての確率分布関数を提供します。R と同じく各確率分布のそれぞれについて d p q r の文字から始まる４つの関数が定義されています。

確率分布 XXX に関する４つの関数

* dXXX: 確率密度関数
* pXXX: 累積分布関数
* qXXX: 分位関数
* rXXX: 乱数生成関数


## 確率分布関数の基本構造

Rcpp では、同じ名前の確率分布関数が `R::` と `Rcpp::` の２つの名前空間で定義されています。これらの違いは、`Rcpp::` 名前空間で定義されている確率分布関数はベクトルを返すのに対して、`R::` 名前空間の関数はスカラーを返すということです。通常は `Rcpp::` 名前空間の関数を使えば良いですが、スカラー値が欲しい場合は R:: 名前空間の関数のほうが速度が速いためそちらを用いたほうが良いでしょう。

下に `Rcpp::` 名前空間で定義されている確率分布関数の基本構造を示します。基本的には `Rcpp::` 名前空間で定義されている確率分布関数は R にある確率分布関数と同じ機能を持っています。実際にはソースコード中に `Rcpp::` 名前空間の確率分布関数の定義はそのまま書かれてはいない（マクロを使って記述されているため）のですが、ユーザーにとってはこのような形式の関数が定義されていると考えて差し支えありません。

```cpp
NumericVector Rcpp::dXXX( NumericVector x, double par,                    bool log = false )
NumericVector Rcpp::pXXX( NumericVector q, double par, bool lower = true, bool log = false )
NumericVector Rcpp::qXXX( NumericVector p, double par, bool lower = true, bool log = false )
NumericVector Rcpp::rXXX(           int n, double par )
```

次に `R::` 名前空間で定義されている確率分布関数の基本構造を示します。これは double を受け取り double を返すという点以外は `Rcpp::` 名前空間で定義されている確率分布関数と基本的には同じ機能を持っています。しかし、引数のデフォルト値は与えられていないのでユーザーが明示的に与える必要があります。

```cpp
double R::dXXX( double x, double par,            int log )
double R::pXXX( double q, double par, int lower, int log )
double R::qXXX( double p, double par, int lower, int log )
double R::rXXX(           double par )
```

下に確率分布関数の引数の説明を示します。

|引数|説明|
|--|--|
|x, q|確率変数の値（のベクトル）|
|p|分位数を求めたい確率値（のベクトル）|
|n|発生させたい乱数の個数|
|par|分布パラメータの値（実際には確率分布によって分布パラメータの数は異なる）|
|lower|true : 確率変数の値が x 以下の領域の確率を算出する、false : x より大の領域の確率を算出する|
|log|true : 確率を対数変換した値を算出する|

##確率分布関数の一覧

以下では Rcpp が提供する確率分布関数の一覧を示します。ここでは確率分布の分布パラメータの名前は R の確率分布関数と一致させているので、詳しくは R のヘルプを参照してください。

### 連続分布

- [一様分布](#一様分布)
- [正規分布](#正規分布)
- [対数正規分布](#対数正規分布)
- [ガンマ分布](#ガンマ分布)
- [ベータ分布](#ベータ分布)
- [非心ベータ分布](#非心ベータ分布)
- [カイ２乗分布](#カイ２乗分布)
- [非心カイ２乗分布](#非心カイ２乗分布)
- [t分布](#t分布)
- [非心t分布](#非心t分布)
- [F分布](#F分布)
- [非心F分布](#非心F分布)
- [コーシー分布](#コーシー分布)
- [指数分布](#指数分布)
- [ロジスティック分布](#ロジスティック分布)
- [ワイブル分布](#ワイブル分布)


### 離散分布

- [二項分布](#二項分布)
- [負の二項分布（成功確率を指定するバージョン）](#負の二項分布（成功確率を指定するバージョン）)
- [負の二項分布（平均値を指定するバージョン）](#負の二項分布（平均値を指定するバージョン）)
- [ポワソン分布](#ポワソン分布)
- [幾何分布](#幾何分布)
- [超幾何分布](#超幾何分布)
- [ウィルコクソン順位和検定統計量の分布](#ウィルコクソン順位和検定統計量の分布)
- [ウィルコクソン符号順位検定統計量の分布](#ウィルコクソン符号順位検定統計量の分布)



##連続分布

### 一様分布

区間 min から max の一様分布の情報を与えます。

```cpp
Rcpp::dunif( x, min = 0.0, max = 1.0, log = false )
Rcpp::punif( x, min = 0.0, max = 1.0, lower = true, log = false )
Rcpp::qunif( q, min = 0.0, max = 1.0, lower = true, log = false )
Rcpp::runif( n, min = 0.0, max = 1.0 )

R::dunif( x, min, max,        log )
R::punif( x, min, max, lower, log )
R::qunif( q, min, max, lower, log )
R::runif(     min, max )
```


### 正規分布

平均値 mean 標準偏差 sd の正規分布の情報を与えます。

```cpp
Rcpp::dnorm( x, mean = 0.0, sd = 1.0, log = false )
Rcpp::pnorm( x, mean = 0.0, sd = 1.0, lower = true, log = false )
Rcpp::qnorm( q, mean = 0.0, sd = 1.0, lower = true, log = false )
Rcpp::rnorm( n, mean = 0.0, sd = 1.0 )

R::dnorm( x, mean, sd,        log )
R::pnorm( x, mean, sd, lower, log )
R::qnorm( q, mean, sd, lower, log )
R::rnorm(    mean, sd )
```

### 対数正規分布

位置パラメータmeanlog 尺度パラメータ meansd の対数正規分布の情報を与えます。

```cpp
Rcpp::dlnorm( x, meanlog = 0.0, sdlog = 1.0,               log = false )
Rcpp::plnorm( x, meanlog = 0.0, sdlog = 1.0, lower = true, log = false )
Rcpp::qlnorm( q, meanlog = 0.0, sdlog = 1.0, lower = true, log = false )
Rcpp::rlnorm( n, meanlog = 0.0, sdlog = 1.0 )

R::dlnorm( x, meanlog, sdlog,        log )
R::plnorm( x, meanlog, sdlog, lower, log )
R::qlnorm( q, meanlog, sdlog, lower, log )
R::rlnorm(    meanlog, sdlog )
```

### ガンマ分布

形状パラメータ shape、尺度パラメータ scale のガンマ分布の情報を与えます。

```cpp
Rcpp::dgamma( x, shape, scale = 1.0,               log = false )
Rcpp::pgamma( x, shape, scale = 1.0, lower = true, log = false )
Rcpp::qgamma( q, shape, scale = 1.0, lower = true, log = false )
Rcpp::rgamma( n, shape, scale = 1.0 )

R::dgamma( x, shape, scale, log )
R::pgamma( x, shape, scale, lower, log )
R::qgamma( q, shape, scale, lower, log )
R::rgamma(    shape, scale )
```

### ベータ分布

形状パラメータ shape1, shape2 を持つベータ分布の情報を与えます。これは R のベータ分布関数において非心パラメータ ncp の値に 0 を設定した場合に相当します。

```cpp
Rcpp::dbeta( x, shape1, shape2, log = false )
Rcpp::pbeta( x, shape1, shape2, lower = true, log = false )
Rcpp::qbeta( q, shape1, shape2, lower = true, log = false )
Rcpp::rbeta( n, shape1, shape2)

R::dbeta( x, shape1, shape2,        log )
R::pbeta( x, shape1, shape2, lower, log )
R::qbeta( q, shape1, shape2, lower, log )
R::rbeta(    shape1, shape2 )
```

### 非心ベータ分布

形状パラメータ shape1、shape2、非心パラメータ ncp を持つベータ分布の情報を与えます。ncp = 0 ではベータ分布に一致します。

```cpp
Rcpp::dnbeta( x, shape1, shape2, ncp,               log = false );
Rcpp::pnbeta( x, shape1, shape2, ncp, lower = true, log = false );
Rcpp::qnbeta( q, shape1, shape2, ncp, lower = true, log = false );
// Rcpp::rnbeta関数は存在しません

R::dnbeta( x, shape1, shape2, ncp,        log )
R::pnbeta( x, shape1, shape2, ncp, lower, log )
R::qnbeta( q, shape1, shape2, ncp, lower, log )
R::rnbeta(    shape1, shape2, ncp )
```

### カイ２乗分布

自由度 df のカイ2乗分布の情報を与えます。これは R のカイ２乗分布関数において非心パラメータ ncp の値に 0 を設定した場合に相当します。

```cpp
Rcpp::dchisq( x, df,               log = false )
Rcpp::pchisq( x, df, lower = true, log = false )
Rcpp::qchisq( q, df, lower = true, log = false )
Rcpp::rchisq( n, df)

R::dchisq( x, df,        log )
R::pchisq( x, df, lower, log )
R::qchisq( q, df, lower, log )
R::rchisq(    df )
```




### 非心カイ２乗分布

自由度 df 、非心パラメータ ncp を持つベータ分布の情報を与えます。ncp = 0 ではカイ２乗分布に一致します。

```cpp
Rcpp::dnchisq( x, df, ncp,               log = false )
Rcpp::pnchisq( x, df, ncp, lower = true, log = false )
Rcpp::qnchisq( q, df, ncp, lower = true, log = false )
Rcpp::rnchisq( n, df, ncp = 0.0 )

R::dnchisq( x, df, ncp,        log )
R::pnchisq( x, df, ncp, lower, log )
R::qnchisq( q, df, ncp, lower, log )
R::rnchisq(    df, ncp )
```

### t分布

自由度 df の t 分布の情報を与えます。これは R の t 分布関数において非心パラメータ ncp の値に 0 を設定した場合に相当します。

```cpp
Rcpp::dt( x, df,               log = false )
Rcpp::pt( x, df, lower = true, log = false )
Rcpp::qt( q, df, lower = true, log = false )
Rcpp::rt( n, df )

R::dt( x, df,        log )
R::pt( x, df, lower, log )
R::qt( q, df, lower, log )
R::rt(    df )
```

### 非心t分布

自由度 df、非心パラメータ ncp の t 分布の情報を与えます。ncp = 0 では t 分布に一致します。

```cpp
Rcpp::dnt( x, df, ncp,               log = false  )
Rcpp::pnt( x, df, ncp, lower = true, log = false  )
Rcpp::qnt( q, df, ncp, lower = true, log = false  )
// Rcpp::rnt関数は存在しません

R::dnt( x, df, ncp,        log )
R::pnt( x, df, ncp, lower, log )
R::qnt( q, df, ncp, lower, log )
// R::rnt関数は存在しません
```

### F分布

自由度 df1, df2 のF分布の情報を与えます。これは R のF分布関数において非心パラメータ ncp の値に 0 を設定した場合に相当します。

```cpp
Rcpp::df( x, df1, df2,               log = false )
Rcpp::pf( x, df1, df2, lower = true, log = false )
Rcpp::qf( q, df1, df2, lower = true, log = false )
Rcpp::rf( n, df1, df1 )

R::df( x, df1, df2,        log )
R::pf( x, df1, df2, lower, log )
R::qf( q, df1, df2, lower, log )
R::rf(    df1, df2 )
```


### 非心F分布

自由度 df1, df2 非心パラメータ ncp の F 分布の情報を与えます。ncp = 0 では F 分布に一致します。

```cpp
Rcpp::dnf( x, df1, df2, ncp,               log = false )
Rcpp::pnf( x, df1, df2, ncp, lower = true, log = false )
Rcpp::qnf( q, df1, df2, ncp, lower = true, log = false )
// Rcpp::rnf関数は存在しません

R::dnf( x, df1, df2, ncp,        log )
R::pnf( x, df1, df2, ncp, lower, log )
R::qnf( q, df1, df2, ncp, lower, log )
// R::rnf関数は存在しません
```

### コーシー分布

位置パラメータ location、尺度パラメータ scale のコーシー分布の情報を与えます。

```cpp
Rcpp::dcauchy( x, location = 0.0, scale = 1.0,               log = false )
Rcpp::pcauchy( x, location = 0.0, scale = 1.0, lower = true, log = false )
Rcpp::qcauchy( q, location = 0.0, scale = 1.0, lower = true, log = false )
Rcpp::rcauchy( n, location = 0.0, scale = 1.0)

R::dcauchy( x, location, scale,        log )
R::pcauchy( x, location, scale, lower, log )
R::qcauchy( q, location, scale, lower, log )
R::rcauchy(    location, scale )
```


### 指数分布

割合 rate (平均が1/rate) の指数分布の情報を与えます。

```cpp
Rcpp::dexp( x, rate = 1.0,               log = false )
Rcpp::pexp( x, rate = 1.0, lower = true, log = false )
Rcpp::qexp( q, rate = 1.0, lower = true, log = false )
Rcpp::rexp( n, rate = 1.0)

R::dexp( x, rate,        log )
R::pexp( x, rate, lower, log )
R::qexp( q, rate, lower, log )
R::rexp(    rate )
```

### ロジスティック分布

位置パラータ location 尺度パラメータ scale のロジスティック分布の情報を与えます。

```cpp
Rcpp::dlogis( x, location = 0.0, scale = 1.0,               log = false )
Rcpp::plogis( x, location = 0.0, scale = 1.0, lower = true, log = false )
Rcpp::qlogis( q, location = 0.0, scale = 1.0, lower = true, log = false )
Rcpp::rlogis( n, location = 0.0, scale = 1.0 )

R::dlogis( x, location, scale,        log )
R::plogis( x, location, scale, lower, log )
R::qlogis( q, location, scale, lower, log )
R::rlogis(    location, scale )
```


### ワイブル分布

形状パラメータ shape、尺度パラメータ scale のワイブル分布の情報を与えます。

```cpp
Rcpp::dweibull( x, shape, scale = 1.0,               log = false  )
Rcpp::pweibull( x, shape, scale = 1.0, lower = true, log = false  )
Rcpp::qweibull( q, shape, scale = 1.0, lower = true, log = false  )
Rcpp::rweibull( n, shape, scale = 1.0 )

R::dweibull( x, shape, scale,        log )
R::pweibull( x, shape, scale, lower, log )
R::qweibull( q, shape, scale, lower, log )
R::rweibull(    shape, scale )
```

## 離散分布



### 二項分布

試行回数 size 成功確率 prob の二項分布の情報を与えます。

```cpp
Rcpp::dbinom( x, size, prob,               log = false )
Rcpp::pbinom( x, size, prob, lower = true, log = false )
Rcpp::qbinom( q, size, prob, lower = true, log = false )
Rcpp::rbinom( n, size, prob )

R::dbinom( x, size, prob,        log )
R::pbinom( x, size, prob, lower, log )
R::qbinom( q, size, prob, lower, log )
R::rbinom(    size, prob )
```






### 負の二項分布（成功確率を指定するバージョン）

成功回数 size、１試行あたりの成功確率 prob の負の二項分布の情報を与えます。

```cpp
Rcpp::dnbinom( x, size, prob,               log = false )
Rcpp::pnbinom( x, size, prob, lower = true, log = false )
Rcpp::qnbinom( q, size, prob, lower = true, log = false )
Rcpp::rnbinom( n, size, prob )

R::dnbinom( x, size, prob,        log )
R::pnbinom( x, size, prob, lower, log )
R::qnbinom( q, size, prob, lower, log )
R::rnbinom(    size, prob )
```

### 負の二項分布（平均値を指定するバージョン）

成功回数 size、分布の平均が mu (=size/prob) の負の二項分布の情報を与えます。

```cpp
Rcpp::dnbinom_mu( x, size, mu,               log = false )
Rcpp::pnbinom_mu( x, size, mu, lower = true, log = false )
Rcpp::qnbinom_mu( q, size, mu, lower = true, log = false )
Rcpp::rnbinom_mu( n, size, mu )

R::dnbinom_mu( x, size, mu,        log )
R::pnbinom_mu( x, size, mu, lower, log )
R::qnbinom_mu( q, size, mu, lower, log )
R::rnbinom_mu(    size, mu )
```


### ポワソン分布

平均値と分散が lambda であるポワソン分布の情報を与えます。

```cpp
Rcpp::dpois( x, lambda,               log = false )
Rcpp::ppois( x, lambda, lower = true, log = false )
Rcpp::qpois( q, lambda, lower = true, log = false )
Rcpp::rpois( n, lambda )

R::dpois( x, lambda, log )
R::ppois( x, lambda, lower, log )
R::qpois( q, lambda, lower, log )
R::rpois(    lambda )
```







### 幾何分布

成功確率 prob の幾何分布の情報を与えます。

```cpp
Rcpp::dgeom( x, prob,               log = false )
Rcpp::pgeom( x, prob, lower = true, log = false )
Rcpp::qgeom( q, prob, lower = true, log = false )
Rcpp::rgeom( n, prob )

R::dgeom( x, prob, log )
R::pgeom( x, prob, lower, log )
R::qgeom( q, prob, lower, log )
R::rgeom(    prob )
```

### 超幾何分布

母集団に含まれる成功数 m、母集団に含まれる失敗数 n、母集団からサンプリングする標本の数 k の超幾何分布の情報を与えます。

```cpp
Rcpp::dhyper( x, m, n, k,               log = false )
Rcpp::phyper( x, m, n, k, lower = true, log = false )
Rcpp::qhyper( q, m, n, k, lower = true, log = false )
Rcpp::rhyper(nn, m, n, k )

R::dhyper( x, m, n, k,        log )
R::phyper( x, m, n, k, lower, log )
R::qhyper( q, m, n, k, lower, log )
R::rhyper(    m, n, k )
```

### ウィルコクソン順位和検定統計量の分布

標本数がそれぞれ m、n である２つの標本に対してウィルコクソン順位和検定（マン・ホイットニーのU検定）を行ったときの検定統計量の分布の情報を与えます。

```cpp
// Rcpp::dwilcox関数は存在しません
// Rcpp::pwilcox関数は存在しません
// Rcpp::qwilcox関数は存在しません
Rcpp::rwilcox( nn, m, n );

R::dwilcox( x, m, n,        log )
R::pwilcox( x, m, n, lower, log )
R::qwilcox( q, m, n, lower, log )
R::rwilcox(    m, n )
```



### ウィルコクソン符号順位検定統計量の分布

n 個の標本への各2回の観察に対してウィルコクソン符号順位検定を行ったときの検定統計量の分布の情報を与えます。


```cpp
// Rcpp::dsignrank関数は存在しません
// Rcpp::psignrank関数は存在しません
// Rcpp::qsignrank関数は存在しません
Rcpp::rsignrank( nn, n )

R::dsignrank( x, n,        log )
R::psignrank( x, n, lower, log )
R::qsignrank( q, n, lower, log )
R::rsignrank(    n )
```
