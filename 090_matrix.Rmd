# Matrix

### 作成

ベクトルと同様に、行列もいくつかの方法で作成することができます。

```
// m <- matrix(0, nrow=2, ncol=2) と同等の行列を作成します
NumericMatrix m1( 2 );

// m <- matrix(0, nrow=2, ncol=3) と同等の行列を作成します
NumericMatrix m2( 2 , 3 );

// m <- matrix(v, nrow=2, ncol=3) と同等の行列を作成します
NumericMatrix m3( 2 , 3 , v.begin() );
```

また、R における行列の実体は属性 `dim` に行数と列数が設定されたベクトルですので、Rcpp で作成したベクトルの属性 `dim` に値を設定し R に返すと行列として扱われます。

```
// [[Rcpp::export]]
NumericVector rcpp_matrix(){
    //ベクトルの作成
    NumericVector v = {1,2,3,4};

    //属性dimに列数、行数をセットします
    v.attr("dim") = Dimension(2, 2);

    //属性dimをセットしたベクトルをRに返します
    return v;
}
```

実行結果

```
> rcpp_matrix()
     [,1] [,2]
[1,]    1    3
[2,]    2    4
```

ただし、ベクトルの属性 `dim` に値を設定しても Rcpp での型はベクトル型のままとなります。それを Rcpp の行列型に変換するには `as<T>()` 関数を用います。

```
//属性dimに列数、行数をセットします
v.attr("dim") = Dimension(2, 2);

//Rcppの行列型への変換します
NumericMatrix m = as<NumericMatrix>(v);
```

###要素へのアクセス

`()` 演算子を用いることで、列番号・行番号をを指定して行列の要素の値を取得、および、行列の要素に値を代入することができます。ベクトルの場合と同様に、行番号や列番号は 0 から始まります。また、行全体、あるいは、列全体にアクセスしたい場合には記号 `_` を用います。

また、`[]` 演算子を使うと行列の列をつなげた１つのベクトルとして要素にアクセスすることができます。

```
//5行5列の数値行列を作成します
NumericMatrix m(5,5);

// 0行2列目の要素を取得します
double x = m( 0 , 2 );

// 0行目の値をベクトル v にコピーします
NumericVector v = m( 0 , _ );

// 2列目の値をベクトル v にコピーします
NumericVector v = m( _ , 2 );

// (0〜1)行、(2〜3)列目を行列 m2 にコピーします
NumericMatrix m2 = m( Range(0,1) , Range(2,3) );

//行列にベクトルとしてアクセスします
m[5]; // これは m(0,1) と同じ要素を指します
```


###行・列・部分行列への参照

Rcppには、一部の列や行への「参照」を保持するオブジェクトも用意されています。

```
NumericMatrix::Column col = m( _ , 1);  //mの1列目の値を参照
NumericMatrix::Row    row = m( 1 , _ ); //mの1行目の値を参照
NumericMatrix::Sub    sub = m( Range(0,1) , Range(2,3) ); //mの部分行列を参照
```

m の一部への「参照」オブジェクトに対して値を代入すると、元の行列 m にその値が代入されます。例えば、`col`への値の代入は `m` の列への値の代入することになります。

```
col = 2*col;      // m の 1 列目の値を2倍にすることができる
m( _ , 1) = 2*m( _ , 1 ) //上の例と同義
```




##メンバ関数

`Matrix` の実体は `Vector` であるので、`Matrix` は基本的には `Vector` と同じメンバ関数を持っています。下には `Matrix` 固有のメンバ関数を示します。

#### nrow() rows()

行数を返します。

#### ncol()　cols()

列数を返します。

####row( i )

`i`番目の行への参照 `Vector::Row` を返します。

####column( i )

`i`番目の列への参照 `Vector::Column` を返します。

#### fill_diag( x )

対角要素をスカラー値 x で満たします。

#### offset(i,j)

i 行 j 列の要素対応する、行列の元ベクトルの要素番号を返します。


##静的メンバ関数

`Matrix` は基本的には `Vector` と同じ静的メンバ関数を持っています。以下では `Matrix` に固有の静的メンバ関数を示します。

####Matrix::diag( size, x )

行数・列数 が size に等しく、対角要素の値が x である対角行列を返します。



##その他の関数

このセクションでは、行列と関連するその他の関数を示します。

####rownames( m )

行列 m の行名の取得と設定をします。

```
CharacterVector ch = rownames(m);
rownames(m) = ch;
```

####colnames( m )

行列 m の列名の取得と設定をします。
```
CharacterVector ch = colnames(m);
colnames(m) = ch;
```


####transpose( m )

行列 m の転置行列を返します。

