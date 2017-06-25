# RObject

`RObject` 型は Rcpp で定義されたどのような型のオブジェクトでも代入することができる型です。変数にどのような型が渡されるか実行時にならないとわからない場合には、`RObject` を用いると良いでしょう。


##メンバー関数

`RObject` は以下のメンバー関数を持ちます。これらのメンバー関数は Rcpp が提供する、他の全ての API クラス（`Vector`など）でも同じものを共通して持っています。

#### inherits(str)

このオブジェクトが文字列 str で指定したクラスを継承している場合は `true` を返します。

#### slot(name)

このオブジェクトが `S4` の場合、文字列 name で指定したスロットにアクセスします。


#### hasSlot(name)

このオブジェクトが `S4` の場合、文字列 name で指定したスロットがある場合は `true` を返します。

#### attr(name)

このオブジェクトの文字列 name で指定した属性にアクセスします。

#### attributeNames()

このオブジェクトが持つ全ての属性の名前を `std::vector<std::string>` 型で返します。

#### hasAttribute(name)

このオブジェクトが文字列 name で指定した名前の属性を持っている場合は `true` を返します。

#### isNULL()

このオブジェクトが NULL である場合は true を返します。

#### sexp_type()

このオブジェクトの `SXPTYPE` を `int` 型で返します。 R で定義された全ての[`SEXPTYPE`のリストはRのマニュアル](https://cran.r-project.org/doc/manuals/r-release/R-ints.html#SEXPTYPEs)を参照してください。

#### isObject()

このオブジェクトが "class" 属性を持っている場合には `true` を返します。

#### isS4()

このオブジェクトが `S4` オブジェクトである場合には `true` を返します。



## A.20.2 RObject を利用した型の判別

`RObject` の使い方の１つとして、オブジェクトの型の判別があります。RObject に代入された値が実際にはどの型であるのか判別するには、`is<T>()` 関数やメンバ関数の `isS4()` `isNULL()` を用います。

ただし、行列や因子ベクトルはベクトルに特定の属性値が設定されたものなので `is<T>()` 関数だけでは判定できません。それらを判定する場合には `Rf_isMatrix()` 関数や `Rf_isFactor()` 関数を用います。

下のコード例では、`RObject` を利用した型の判別の方法を示します。

```
// [[Rcpp::export]]
void rcpp_type(RObject x){
    if(is<NumericVector>(x)){
        if(Rf_isMatrix(x)) Rcout << "NumericMatrix\n";
        else Rcout << "NumericVector\n";       
    }
    else if(is<IntegerVector>(x)){
        if(Rf_isFactor(x)) Rcout << "factor\n";
        else Rcout << "IntegerVector\n";
    }
    else if(is<CharacterVector>(x))
        Rcout << "CharacterVector\n";
    else if(is<LogicalVector>(x))
        Rcout << "LogicalVector\n";
    else if(is<DataFrame>(x))
        Rcout << "DataFrame\n";
    else if(is<List>(x))
        Rcout << "List\n";
    else if(x.isS4())
        Rcout << "S4\n";
    else if(x.isNULL())
        Rcout << "NULL\n";
    else
        Rcout << "unknown\n";
}
```

型の判定をした後に `RObject` を別の Rcpp 型に変換するには `as<T>()` を用います。

```
// RObject を NumericVector に変換します
RObject x;
NumericVector v = as<NumericVector>(x);
```

