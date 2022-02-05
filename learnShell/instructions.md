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