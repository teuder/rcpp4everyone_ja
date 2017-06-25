# Environment

`Environment` クラスを用いるとアクセスしたい環境を変数として保持し、その環境中の変数や関数にアクセスすることができます。

## Environment オブジェクトの作成

`Environment ` クラスのオブジェクトを作成する方法を下に示します。

```
Environment env();                           //グローバル環境
Environment env = Environment::global_env(); //グローバル環境
Environment env("package:stats");            // パッケージ stats 内の環境
Environment env(1); // オブジェクトのサーチパスの i 番目にある環境（i=1はグローバル環境）
```

オブジェクトサーチパスを確認するには R の `search()` 関数を利用します。

```
> search()
 [1] ".GlobalEnv"        "tools:RGUI"        "package:stats"    
 [4] "package:graphics"  "package:grDevices" "package:utils"    
 [7] "package:datasets"  "package:methods"   "Autoloads"        
[10] "package:base"   
```

## 環境にあるオブジェクトにアクセスする

Environment オブジェクトを通して環境中の変数や関数にアクセスするためには `[]` 演算子または `get()` メンバ関数を用います。もしも、その環境に存在しない変数や関数にアクセスした場合には `R_NilValue` (`NULL`) が返ります。

```
// グローバル環境を取得します
Environment env = Environment::global_env();

//グローバル環境にある変数を取得します
NumericVector x = env["x"];

//グローバル環境にある変数 x の値を変更します
x[0] = 100;
```

## 新しい環境を作成する

関数 `new_env()` 関数を用いることで新しい空の環境を作成することができます。

#### new_env(size = 29)

新しい環境を返します。size は作成される環境のハッシュテーブルの初期サイズを指定します。

#### new_env(parent, size = 29)

parent を親環境とする新しい環境を返します。size は作成される環境のハッシュテーブルの初期サイズを指定します。



## メンバ関数

#### get(name)

name で指定された名前のオブジェクトを取得します。見つからない場合は `R_NilValue` を返します。

#### ls(all)

この環境にあるオブジェクトの一覧を文字列ベクトル返します。引数 all が true なら全てのオブジェクトを、false なら名前が `.` から始まるオブジェクトは除外します。

#### find(name)

この環境、あるいは、その親環境から文字列 name で指定した名前のオブジェクトを取得します。見つからない場合は binding_not_found 例外が thow されます。

#### exists(name)

この環境に文字列 name で指定した名前のオブジェクトが存在する場合には true を返します。

#### assign( name, x )

この環境にある文字列 name で指定した名前のオブジェクトに値 x を代入します。成功した場合には true を返します。

#### isLocked()

この環境がロックされている場合には true を返します。

#### remove(name)

この環境から文字列 name で指定した名前のオブジェクトを削除します。成功した場合には true を返します。

#### lock(bindings = false)

この環境をロックします。binding = true の場合は、この環境の binding （Rのオブジェクト名とメモリ上のオブジェクト値の対応関係）もロックします。

#### lockBinding(name)

この環境にある文字列 name で指定した binding をロックします。

#### unlockBinding(name){

この環境にある文字列 name で指定した binding のロックを解除します。

#### bindingIsLocked(name)

この環境にある文字列 name で指定した binding がロックされている場合には true を返します。

#### bindingIsActive(name)

この環境にある文字列 name で指定した binding がアクティブである場合には true を返します。


#### is_user_database()

この環境がユーザーが定義したデータベース（"UserDefinedDatabase"）を継承している場合には true を返します。

#### parent()

この環境の親環境を返します。

#### new_child(hashed)

この環境を親とする新しい環境を作成します。hashed = true の場合は、作成した環境はハッシュテーブルを使用します。


## static メンバ関数

####Environment::global_env()

グローバル環境を返します。

####Environment::empty_env()

ルート環境である空環境を返します。

####Environment::base_env()

base パッケージの環境を返します。

####Environment::base_namespace()

baseパッケージの名前空間を返す。

#### Environment::Rcpp_namespace()

Rcpp パッケージの名前空間を返します。

#### Environment::namespace_env(package)

文字列 package で指定した名前のパッケージの名前空間を返します。`Environment::namespace_env()` を使った場合には、R であらかじめ `library()` 関数でパッケージをロードしていなくてもパッケージ内の関数を呼び出すことができますこれは R で `パッケージ名::関数()` という形式で呼び出した場合と同等です。それに加えて、パッケージ内で export されていない関数にもアクセスすることができます。これは Rで `パッケージ名:::関数()` という形式で呼び出した場合と同等です。
