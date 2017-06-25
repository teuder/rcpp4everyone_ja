# List

`List` の作成と要素へのアクセスの方法は、基本的には `DataFrame` の場合と同じです。`List` が `DataFrame` と異なる点は、`List` はその要素として `Vector` だけではなく `S4` や `DataFrame` や `List` など任意の型を保持できる点です。

[DataFrame](dataframe.md) のページに記載された内容は、`DataFrame` を `List` に置き換えても成立するので、詳細はそちらを参照してください。


## オブジェクトの作成

`List` の作成には `List::create()` 関数を使用します。また、`List` の作成時に要素名を指定する場合には、`Named()` 関数または `_[]` を使用します。

```cpp
List L = List::create(v1, v2); //ベクトル v1, v2 からリスト L を作成します
List L = List::create(Named("名前1") = v1 , _["名前2"] = v2); //要素に名前をつける場合
```

## 要素へのアクセス

`List` の特定の要素にアクセスする場合には、リストの要素を ベクトルに代入し、そのベクトルを介してアクセスします。

`List` の要素は、数値ベクトル、文字列ベクトル、論理ベクトルにより指定できます。

```cpp
NumericVector v1 = L[0];
NumericVector v2 = L["V1"];
```

## メンバ関数

`List` も `Vector` と同じメンバ関数を持っています。