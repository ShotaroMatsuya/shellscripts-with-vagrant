## available scripts


-eオプション (expression)
```
sed -e '3d' names.txt
```
一つだけだと省略可能
```
sed '3d' names.txt
```
ファイルに上書き出力
```
sed -i '3d' names.txt
```
バックアップを取る(names.txt.bakが作成される)
```bash
sed -i.bak '3d' names.txt
# (names.txt.bakが作成される)
```

## pattern space

address(どの行に対して) command（何をするか）

pattern spaceとは, バッファのようなもの  
fileから1行ずつ読み込みpattern spaceに格納  
addressにマッチしたらcommandを実行  
パターンスペースを表示  

## アドレスの指定
- 3d  
3行目を削除
- 3!d  
3行目以外を削除
- 1d;3d  
1と3行目を削除（複数指定）
- 1,3d  
1から3行目を削除（範囲指定）
- 1~2d  
1行目から2飛ばしで削除
- $d  
最後の行を削除
- 3,$d  
3から最後の行まで削除
- /i$/d  
iで終わる行を削除
- アドレスの省略  
すべての行が対象となる

## コマンド

- pコマンド
プリント
- -nオプション  
パターンスペースの表示を無効化  
pコマンドと一緒によく使われる
- qコマンド  
処理を終了する
- iコマンド
挿入する
```bash
sed '1i\--- start ---' names.txt
# 1行目に文字列を挿入
```
- aコマンド
```bash
sed -e '1i\--- start ---' -e '$a\--- end ---' names.txt
# 行頭にインサート、行末にアペンド
```
- yコマンド  
1文字ずつ置換
```bash
sed 'y/t/T/' names.txt
# t→T
sed 'y/to/TO/' names.txt
# t→T、o→O
```

- sコマンド  
文字列の置換  

```bash
sed 's/apple/Apple/' items.txt
# (行ごとの最初の文字列だけ置換)
sed 's/apple/Apple/g' items.txt
# (行内すべての文字列を置換)
sed 's/apple/Apple/2' items.txt
# (2番目にマッチするものだけを置換)
sed 's/apple/Ringo/ig' items.txt
# (マッチする文字列の大/小文字を無視)
sed 's/[aA]pple/Ringo/g' items.txt
# (正規表現を使って文字列を指定)
```
```bash
# マッチした文字列を使って置換

# &による置換
sed 's/[0-5]/【&】/' items.txt
# \1、\2による置換
sed 's/\([0-5]\) \(.*\)/\2 【\1】/' items.txt

```
## ホールドスペースの利用

行単位ではなく、行をまたいで処理をしたいときホールドスペースを使う  
パターンスペースとは別にある、裏バッファ
一時対比させたり、取り出したりできる


- hコマンド(hold)  
pattern space → hold space

- gコマンド(get)  
pattern space ← hold space

- xコマンド(exchange)  
hold space ⇔ pattern space

```bash
# ファイルを適用
sed -f ex2.sed style.css
```


---

# Sed and Streams

- Sed = ***S***tream ***ed***itor.
- Sed performs text transformations on streams.
    - Examples
        - Substitute some text for other text.
        - Remove lines.
        - Append text after given lines.
        - Insert text before certain lines.


## Available scripts

1. replacement text
```bash
sed 's/assistant/assistant to the/' manager.txt

> Dwight is the assistant to the regional manager.
```

2. insensitive
```bash
sed 's/MY WIFE/sed/i' love.txt

> I love sed.
```
3. multiline text

```bash
sed 's/my wife/sed/' love.txt

> I love sed.
> This is line 2.
> I love sed with all of my heart.
> I love sed and my wife loves me. Also, my wife loves the cat.

```
4. globally
```bash
sed 's/my wife/sed/g' love.txt
> I love sed.
> This is line 2.
> I love sed with all of my heart.
> I love sed and sed loves me. Also, sed loves the cat.
```
5. specify number on each line
```bash
sed 's/my wife/sed/2' love.txt
> I love my wife.
> This is line 2.
> I love my wife with all of my heart.
> I love my wife and sed loves me. Also, my wife loves the cat.
```
6. backup & replaced original text
```bash
$ sed -i.bak 's/my wife/sed/' love.txt
$ ls
> love.txt love.txt.bak manager.txt
```

7. save the only lines where matches a keyword
```bash
$ sed -i.bak 's/love/like/gw like.txt' love.txt
$ cat like.txt
> I like sed.
> I like sed with all of my heart.
> I like sed and my wife likes me. Also, my wife likes the cat.
```

8. changed delimiter
```bash
$ sed 'home/shotaro' | sed 's#/home/shotaro#/export/users/shotaro#'
> /export/users/shotaro

```

9. delete the line
```bash
$ sed '/This/d' love.txt

> I love sed.
> I love sed with all of my heart.
> I love sed and my wife loves me. Also, my wife loves the cat.
```

10. delete the blank lines
```bash
$ sed '/^$/d' config
> #User to run service as.
> User apache
> # Group to run service as.
> Group apache
```

11. multiple sed expression at the same time(separate the ' ; ')
```bash
$ sed '/^#/d ; /^$/ ; s/apache/httpd/' config
> User httpd
> Group httpd
```

12. affect the specific number of lines 
```bash
$ sed '2 s/apache/httpd/' config
> #User to run service as.
> User httpd
>
> # Group to run service  as.
> Group apache

```

13. affect the specific word of lines
```bash
$ sed '/Group/ s/apache/httpd/' config
> #User to run service as.
> User apache
>
> # Group to run service  as.
> Group httpd
```

14. specify the range of line numbers
```bash
$ sed '1,4 s/run/execute/' config
> #User to execute service as.
> User apache
>
> # Group to execute service  as.
> Group apache
```
15.  specify the range by keywords

```bash
$ sed '/#User/,/^$/ s/run/execute/' config
> #User to execute service as.
> User apache
>
> # Group to run service  as.
> Group apache
```