# Datetime

`Datetime` は `DatetimeVector` の要素に対応するスカラー型です。

## Datetime オブジェクトの作成

Date と同様に、Datetime の作成方法も、世界協定時（UTC）の 1970-01-01 00:00:00 からの秒数を指定して作成する方法と、明示的に日時を指定して作成する方法があります。

明示的に日時を指定して作成する形式は `Datetime dt( str, format)` となります。この形式では書式文字列 `format` を指定して文字列 `str` を `Datetime` に変換します。(formatで使用する記号は R の `help(strptime)` を参照してください）

```
// 1970年1月1日 00:00:00 からの経過秒数（実数）で作成します
Datetime dt;         // "1970-01-01 00:00:00 UTC"
Datetime dt(10.1);   // "1970-01-01 00:00:00 UTC" + 10.1sec

// 日時・時間と書式を指定して作成します
// デフォルトの書式は "%Y-%m-%d %H:%M:%OS" です
// 指定した日時はローカルなタイムゾーンの日時として解釈されます
Datetime dt("2000-01-01 00:00:00");
Datetime dt("2000年1月1日 0時0分0秒", "%Y年%m月%d日 %H時%M分%OS秒");
```

## タイムゾーン

`Datetime` は、内部的には日時を協定世界時 (UTC) `1970-01-01 00:00:00` からの秒数（実数）で管理しています。例えば `Datetime dt(10)` は世界協定時 `1970-01-01 00:00:00 UTC` から10秒経過後の時点を表します。この値を R に返すと実行されたタイムゾーンに変換された時刻として表示されます。例えば日本なら日本標準時（JST）は UTC + 9時間なので、`Datetime(10)` は　`1970-01-01 09:00:10 JST` となります。

この形式では、`str` はローカルなタイムゾーンの時刻として解釈されます。例えば日本標準時（JST）で、`Datetime("2000-01-01 00:00:00")` を実行すると、内部的には `1999-12-31 15:00:00 UTC` の値がセットされます。


## 演算子

`Datetime ` には `+ - < > >= <= == !=` の演算子が定義されています。

これらの演算子を用いることにより、秒数の加算 (+)、日時の差分(-)、日時の比較(<, <=, >, >=, ==, !=) を行えるようになります。日時に加算する値と、日時の差分の返値の単位は秒となります。

```cpp
Datetime dt1("2000-01-01 00:00:00");
Datetime dt2("2000-01-02 00:00:00");

//日時の差分（秒）
int sec = dt2 - dt1;  // 86400

//日時に秒数を加算
dt1 = dt1 + 1; // "2000-01-01 00:00:01"

//日時の比較
bool b = dt2 > dt1; // true
```


## メンバ関数

**注意**：これらのメンバ関数を使って出力される時刻の値は、世界協定時で解釈した時刻の値になっています。そのため、ユーザーのタイムゾーンの日時とは異なって見えます。（出力結果はこの章の末尾に記載したのコードの実行結果を参照してください）


####getFractionalTimestamp()

世界協定時の基準日（1970-01-01 00:00:00 UTC）からの秒数（実数値）を返します

####getMicroSeconds()

世界協定時の日時のマイクロ秒を返します。これは秒の小数点以下の値を 1/1000000 秒単位で表記した値です。（0.1 秒 = 100000 マイクロ秒）

####getSeconds()

世界協定時の日時の秒を返します。

####getMinutes()

世界協定時の日時の分を返します。

####getHours()

世界協定時の日時の時を返します。

####getDay()

世界協定時の日時の日を返します。

####getMonth()

世界協定時の日時の月を返します。

####getYear()

世界協定時の日時の年を返します。

####getWeekday()

世界協定時の曜日

世界協定時の日時の曜日を int で返します。1=Sun 2=Mon 3=Tue 4=Wed 5=Thu 6=Sat

####getYearday()

1月1日を 1 、12月31日を 365 とした年間を通した日付の番号を返します。

####is_na()

このオブジェクトが NA である場合には true を返します。


##コード例

以下のコード例では、日本標準時（JST）の環境で実行した結果を示します。


```
// [[Rcpp::export]]
Datetime rcpp_datetime(){
    // 日時を指定して Datetime オブジェクトを作成する
    Datetime dt("2000-01-01 00:00:00");

    // 日時の要素を世界協定時で表示します
    Rcout << "getYear " << dt.getYear() << "\n";
    Rcout << "getMonth " << dt.getMonth() << "\n";
    Rcout << "getDay " << dt.getDay() << "\n";

    Rcout << "getHours " << dt.getHours() << "\n";
    Rcout << "getMinutes " << dt.getMinutes() << "\n";
    Rcout << "getSeconds " << dt.getSeconds() << "\n";

    Rcout << "getMicroSeconds " << dt.getMicroSeconds() << "\n";
    Rcout << "getWeekday " << dt.getWeekday() << "\n";
    Rcout << "getYearday " << dt.getYearday() << "\n";
    Rcout << "getFractionalTimestamp " << dt.getFractionalTimestamp() << "\n";

    return dt;
}
```

実行結果

出力される世界協定時（UTC）は日本標準時（JST）から9時間前の日時となっていることがわかります。

```
> rcpp_datetime()
getYear 1999
getMonth 12
getDay 31
getHours 15
getMinutes 0
getSeconds 0
getMicroSeconds 0
getWeekday 6
getYearday 365
getFractionalTimestamp 9.46652e+08
[1] "2000-01-01 JST"
```

