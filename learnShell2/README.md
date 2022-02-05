
## available scripts

ファイルから読み込む

```
awk -f [ファイル名] [データファイル]
```
## フィールドの指定
{} : すべてのレコードに対して実行  
print : データを改行つきで出力  
$4 : 4フィールド目  

```bash
# 4フィールド目のみ
awk '{ print $4 }' scores.dat

# 3と4フィールド
awk '{ print $3, $4 }' scores.dat

# 間に文字列を挟む
awk '{ print $3 ":" $4}' scores.dat

# すべてのfield
awk '{ print $0}' scores.dat

# NF : フィールド番号、$NF : 最後のフィールド
awk '{ print NF , $NF }' scores.dat

# NR : レコード番号
awk  '{ print NR ":" $0 }' scores.dat
```
--- 
### Tips: `print $1 $2 $3`と、`print $1,$2,$3`は、違う  
- awkにおいて、print $0 = print $1,$2,$3  
- awkのスペースには、文字列を連結する役目がある

```bash 
$ cat abc.txt | awk '{print $1 $2 $3}'
abc
def
ghi

$ cat abc.txt | awk '{print $1,$2,$3}'
a b c
d e f
g h i
```
---
## レコードを指定

```bash 
# 3行目未満の行のみ出力
awk 'NR < 3 { print NR ":" $0}' scores.dat

# 複数の条件も可能
awk 'NR < 3 { print NR ":" $0} NR > 95 { print NR ":" $0}' scores.dat

# 論理演算子を使う
awk ' ($3 == "taguchi") && ($4 > 100) { print $3, $4 }' scores.dat

# 正規表現を使う(~)
awk ' $3 ~ /^t.*/ { print $0 }' scores.dat
```

## BEGIN, ENDを使う
BEGIN : 最初に一度だけ実行される
END : 最後に一度だけ実行される

```bash

BEGIN { print '--- start ---'} 
NR > 5 && NR < 10 { print $0 } 
END { print '--- end ---'}

```

```bash
# FS : フィールドの区切り文字を指定できる(デフォルトは空白スペース)
BEGIN { FS = "-"} 
NR > 5 && NR < 10 { print $1, $2}
# - でフィールドが分割され、その後の$1と$2が出力

```

```bash
# RS : レコードの区切り文字を指定できる(デフォルトは改行)
BEGIN { RS = ":"} 
NR == 1 { print $0}
# : でレコードが分割され、その後の$0が出力
```

```bash
# OFS : 出力時のフィールド区切り文字の変更
# ORS : 出力時のレコード区切り文字の変更
BEGIN { OFS = "@"; ORS = "|"}
NR > 5 && NR < 10 { print $3, $4}

```

## 変数と演算子

```bash
BEGIN { total = 0} NR < 4 {total += $4} END { print total}
# $4の値の合計値を出力
```

## printfで出力

書式を指定して出力できる

```bash
NR > 96 { print $3, ($4+$5+$6+$7),  (($4+$5+$6+$7)/4)}

# %s : 文字列、 %d : 整数、 %f : 浮動小数点数
NR > 96 { printf "Name: %s Sum: %d AVG: %f\n", $3,($4+$5+$6+$7),  (($4+$5+$6+$7)/4)}

# 表示桁数を指定
NR > 96 { printf "Name: %-10s Sum: %'10d AVG: %010.2f\n", $3,($4+$5+$6+$7),  (($4+$5+$6+$7)/4)}

# 10文字の文字列(左揃え) 、 10桁の整数（右揃え、3桁ごとに','がつく）、小数点第二位までの10桁の浮動小数点数(足りない分は0で補う)

```

## build-in Function
- int()  
浮動小数点を切り捨てて整数値に

- length()  
文字数を出力

- substr()  
部分文字列を出力する  

```bash
BEGIN {
  print int(3.8) # 3
  print length("hello") # 5
  print substr("hello", 3) # llo
  print substr("hello", 3, 2) # ll
}
```


