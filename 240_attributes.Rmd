# 属性値

Rcppのオブジェクトの属性値へアクセスするには、次のメンバ関数を用います。

#### attr( name )

文字列 name で指定した属性値へアクセスして値の取得や設定を行います。

```
List L;
L.attr("class") = "my_class";
```

#### attributeNames()

オブジェクトが持っている属性の一覧を返します。返値の型は C++ の `vector<string>` なので、`CharacterVector` に変換する場合には `wrap()` 関数を用います。

```
CharacterVector ch = wrap(x.attributeNames());
```

#### hasAttribute( name )

このオブジェクトが 文字列 name で指定した名前の属性を持っている場合は `true` を返します。

```
bool b = x.hasAttribute("name");
```

```cpp
// リストを作成します
NumericVector   v1 = {1,2,3,4,5};
CharacterVector v2 = {"A","B","C"};
List L = List::create(v1, v2);

// 要素に名前を設定します
L.attr("names") = CharacterVector::create("x", "y");

// 新しい属性を作成して、その値をセットします。
L.attr("new_attribute") = "new_value";

// このオブジェクトのクラス名を "new_class" に変更します
L.attr("class") = "new_class";

// このオブジェクトが持つ属性の一覧を出力します
CharacterVector ch = wrap(L.attributeNames());
Rcout << ch << "\n"; // "names" "new_attribute" "class"

// このオブジェクトが属性 "new_attribute" を持っているか確かめます
bool b = L.hasAttribute("new_attribute");
Rcout << b << "\n"; // 1
```

##主要な属性値

要素名など使用頻度の高い属性については専用のアクセス関数が用意されている場合があります。

```
//要素名、これらは同義である
x.attr("names");
x.names();
```

下に主要な属性値へのアクセス方法を示す

```
Vector v
v.attr("names");//要素名
v.names();      //要素名

Matrix m;
m.ncol();  //列数
m.nrow();  //行数
m.attr(“dim”) = NumericVector::create(行数, 列数);
m.attr(“dimnames”) = List::create(行名ベクトル, 列名ベクトル);

DataFrame df;
df.attr(“names”);     //列名
df.attr(“row.names”); //行名

List L;
L.names(); //要素名
```


















