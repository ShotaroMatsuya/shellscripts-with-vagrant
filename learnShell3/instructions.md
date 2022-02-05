# intro

jsonのデータをjqでフィルタリングし、json形式に出力してくれる

# 配列データの取り扱い

- `.`  
jsonをそのまま出力

```bash
[
  1,
  21,
  3,
  8,
  20,
  3,
  21
]
```

- `.[]`   
すべての要素を取り出す
独立した値

```bash
1
21
3
8
20
3
21
```

- `.[] | . * 2`  
それぞれの要素を2倍

```bash
2
42
6
16
40
6
42
```

- `[ .[] | . * 2]`  
出力結果を配列化する
```bash
[
  2,
  42,
  6,
  16,
  40,
  6,
  42
]
```

- `[ .[] | . * 2] | add`  
addは配列に対して使える関数  
配列内の要素をすべて足し合わせる  
```bash
154
```

- `.[0, 3]`  
配列の0番目と3番目の値を取り出す
```bash
1
8
```

- `.[1:5]`  
配列の1番目から5番目の手前(4番目)までを取り出す
```bash
[
  21,
  3,
  8,
  20
]
```

- `.[] | . >= 10`  
booleanで出力
```bash
false
true
false
false
true
false
true
```

- `.[] | select(. >= 10)`  
trueのものだけを出力
selectを使う
```bash
21
20
21
```

- `.[] | "Value: \(.)"`  
文字列を埋め込む
```bash
# 結果
"Value: 1"
"Value: 21"
"Value: 3"
"Value: 8"
"Value: 20"
...
```
## 関数

- `. | map(. * 2)`  
mapは配列に対して使用できる関数
`[ .[] | . * 2 ]`と同じことをシンプルに書ける  

```bash
[
  2,
  42,
  6,
  16,
  40,
  6,
  42
]
```

- `. | add` = `add`  
配列内の全要素の合計(入力が配列であれば省略形が使える)

```bash
77
```

- `length`  
配列の場合は要素数を返す

```bash
7
```

- `add / length`  
平均値を出す  

```bash
11
```

※他にもsort max min unique reverseがある

- `@csv`   
配列をcsv形式で出力
```bash
# 結果
"1,21,3,8,20,3,21"
```

# オブジェクトデータの取り扱い
- `.`
そのまま出力

```bash
{
  "id": 32,
  "name": "taguchi",
  "scores": 88
}
```

- `.[]`  
値(value)のみの取り出し  
```bash
32
"taguchi"
88
```

- `.name`  
特定のkeyのみを出力
```bash
"taguchi"
```

- `.id, .name`
複数のkeyを指定する場合はカンマで区切る
```bash
32
"taguchi"
```

- `{ myid: .id, name, title: "Engineer"}`  
オブジェクトを生成

```bash
{
  "myid": 32,
  "name": "taguchi",
  "title": "Engineer"
}
```

## 関数

- `keys`   
オブジェクトに対して使える関数   
すべてのkeyを配列で取得

```bash
[
  "id",
  "name",
  "scores"
]
```
- `has("name")`  
keyが存在するかどうかbooleanで返す

```bash
true
```

# 複雑なデータの取り扱い

- 生データ出力

```bash
[
  {
    "id": 32,
    "name": "taguchi",
    "scores": [
      52,
      33,
      84
    ],
    "skills": [
      {
        "area": "html",
        "level": 4
      },
      {
        "area": "css",
        "level": 5
      },
      {
        "area": "javascript",
        "level": 3
      }
    ]
  },
  {
    "id": 34,
    "name": "hayashi",
    "scores": [
      80,
      32,
      38
    ],
    "skills": [
      {
        "area": "html",
        "level": 4
      },
      {
        "area": "css",
        "level": 4
      },
      {
        "area": "javascript",
        "level": 4
      },
      {
        "area": "php",
        "level": 2
      }
    ]
  },
  {
    "id": 42,
    "name": "kikuchi",
    "scores": [
      91,
      42,
      33
    ],
    "skills": [
      {
        "area": "html",
        "level": 4
      },
      {
        "area": "css",
        "level": 5
      }
    ]
  },
  {
    "id": 48,
    "name": "kobayashi",
    "scores": [
      95,
      22
    ],
    "skills": [
      {
        "area": "html",
        "level": 3
      },
      {
        "area": "css",
        "level": 4
      },
      {
        "area": "javascript",
        "level": 3
      }
    ]
  },
  {
    "id": 48,
    "name": "kojima",
    "scores": [
      24,
      32,
      22,
      25
    ],
    "skills": [
      {
        "area": "html",
        "level": 3
      },
      {
        "area": "css",
        "level": 2
      },
      {
        "area": "php",
        "level": 5
      }
    ]
  }
]
```

- `.[] | .scores`  
scoresの配列を取得
```bash

[
  52,
  33,
  84
]
[
  80,
  32,
  38
]
[
  91,
  42,
  33
]
[
  95,
  22
]
[
  24,
  32,
  22,
  25
]
```
- `.[] | .scores | add / length`  
```bash
# 各配列ごとに平均値を出す
56.333333333333336
50
55.333333333333336
58.5
25.75
```

- `.[] | .scores | add /length | round`  
```bash
# 小数点を四捨五入
56
50
55
59
26
```

- `.[] | { name, avg: ( .scores | add /length | round)}`  

```bash
# 名前と平均点だけのオブジェクトを生成
{
  "name": "taguchi",
  "avg": 56
}
{
  "name": "hayashi",
  "avg": 50
}
{
  "name": "kikuchi",
  "avg": 55
}
{
  "name": "kobayashi",
  "avg": 59
}
{
  "name": "kojima",
  "avg": 26
}
```

- `.[] | { name, avg: (.scores | add / length | round)} | select(.avg >= 50)`  

```bash
# 平均点50点以上の人だけに限定

{
  "name": "taguchi",
  "avg": 56
}
{
  "name": "hayashi",
  "avg": 50
}
{
  "name": "kikuchi",
  "avg": 55
}
{
  "name": "kobayashi",
  "avg": 59
}

```

- `[.[] | { name, avg: (.scores | add / length | round)} | select(.avg >= 50)] | sort_by(.avg) | reverse`

```bash
# 平均点順にソートする
[
  {
    "name": "kobayashi",
    "avg": 59
  },
  {
    "name": "taguchi",
    "avg": 56
  },
  {
    "name": "kikuchi",
    "avg": 55
  },
  {
    "name": "hayashi",
    "avg": 50
  }
]
```

```bash
# 配列のものを配列で返す場合はmapが便利
map({ name, avg: (.scores | add /length | round)} | select(.avg >= 50)) | sort_by(.avg) | reverse

```
- `.[] | .skills[]`  
```bash
{
  "area": "html",
  "level": 4
}
{
  "area": "css",
  "level": 5
}
{
  "area": "javascript",
  "level": 3
}
{
  "area": "html",
  "level": 4
}
{
  "area": "css",
  "level": 4
}
{
  "area": "javascript",
  "level": 4
}
{
  "area": "php",
  "level": 2
}
{
  "area": "html",
  "level": 4
}
{
  "area": "css",
  "level": 5
}
{
  "area": "html",
  "level": 3
}
{
  "area": "css",
  "level": 4
}
{
  "area": "javascript",
  "level": 3
}
{
  "area": "html",
  "level": 3
}
{
  "area": "css",
  "level": 2
}
{
  "area": "php",
  "level": 5
}

```

- `.[] | [ .skills[] | .level ]`  

```bash

[
  4,
  5,
  3
]
[
  4,
  4,
  4,
  2
]
[
  4,
  5
]
[
  3,
  4,
  3
]
[
  3,
  2,
  5
]
```

- `.[] | { name, skill: ([ .skills[] | .level ] | add / length | round)}`



```bash
{
  "name": "taguchi",
  "skill": 4
}
{
  "name": "hayashi",
  "skill": 4
}
{
  "name": "kikuchi",
  "skill": 5
}
{
  "name": "kobayashi",
  "skill": 3
}
{
  "name": "kojima",
  "skill": 3
}
```

- `.[] | {name , js: .skills[] | select(.area == "javascript")}`
```bash
# javascriptを含む人だけ抽出
{
  "name": "taguchi",
  "js": {
    "area": "javascript",
    "level": 3
  }
}
{
  "name": "hayashi",
  "js": {
    "area": "javascript",
    "level": 4
  }
}
{
  "name": "kobayashi",
  "js": {
    "area": "javascript",
    "level": 3
  }
}
```

- `.[] | {name , js: .skills[] | select(.area == "javascript") | .level } `  

```bash
# levelのみを抽出
{
  "name": "taguchi",
  "js": 3
}
{
  "name": "hayashi",
  "js": 4
}
{
  "name": "kobayashi",
  "js": 3
}
```